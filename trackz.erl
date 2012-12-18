%%%-------------------------------------------------------------------
%%% File    : trackz.erl
%%% Author  : Andreas Stenius <andreas.stenius@astekk.se>
%%% Description : 
%%%
%%% Created : 28 Oct 2011 by  <andreas.stenius@astekk.se>

%% Copyright 2011 Andreas Stenius
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%% 
%%     http://www.apache.org/licenses/LICENSE-2.0
%% 
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.

%%%-------------------------------------------------------------------
-module(trackz).
-author("Andreas Stenius <andreas.stenius@astekk.se>").
-mod_title("Trackz").
-mod_description("Project Tracker on Zotonic - KanBan style").
-mod_schema(1).
-mod_prio(100).
-mod_depends([rbac]).

-include_lib("zotonic.hrl").


%% API
-export([
         %% init/1,
         event/2,
         manage_schema/2,
         observe_rsc_update_done/2,
         observe_edge_insert/2
         %% observe_edge_delete/2
        ]).


%%====================================================================
%% API
%%====================================================================

%%--------------------------------------------------------------------
%% init(_Context) ->
%%     ok.

manage_schema(install, _Context) ->
    #datamodel{ 
       categories = 
           [
            {project, rbac_domain, [{title, <<"Project">>}]},
            {column, meta, [{title, <<"Column">>}]},
            {card, meta, [{title, <<"Card">>}]}
           ],
       predicates = 
           [
            {project_column, [{title, <<"Project Column">>}], [{project, column}]},
            {column_card, [{title, <<"Column Card">>}], [{column, card}]}
           ],
       resources =
           [
            {home, text, [{title, "Home"}, {page_path, "/"}, {body, "This is the trackz front-page."}]},
            {dashboard, text, [{title, "Dashboard"}, {page_path, "/dashboard"}]},
            {profile, text, [{title, "Profile"}, {page_path, "/profile"}]},
            {logon, text, [{title, "Log in"}, {page_path, "/logon"}]},
            {logoff, text, [{title, "Log out"}, {page_path, "/logoff"}]},

            {member_role, rbac_role, [{title, "Project Member Role"}]},
            {admin_role, rbac_role, [{title, "Project Admin Role"}]},
            {view_op, rbac_operation, [{title, "view"}, {operation, view}]},
            {update_op, rbac_operation, [{title, "update"}, {operation, update}]},
            {delete_op, rbac_operation, [{title, "delete"}, {operation, delete}]}
           ],
       edges =
           [
            {member_role, rbac_role_operation, view_op},
            {member_role, rbac_role_operation, update_op},
            {admin_role, rbac_role_operation, delete_op},
            {admin_role, rbac_domain_role, member_role}
           ]
      }.

			
%%--------------------------------------------------------------------
event({sort, Sorted, #dragdrop{ tag={card_sorter, Props}}}, Context) ->
    ColumnId = proplists:get_value(id, Props),
    CardIds = [ CardId || #dragdrop{ tag=CardId } <- Sorted ],
    ok = m_edge:set_sequence(ColumnId, column_card, CardIds, Context),
    mod_signal:emit({card_changed, 
                     [{event, sorted},
                      {cards, CardIds},
                      {column, ColumnId},
                      {project, proplists:get_value(project, Props)}
                     ]},
                    Context),
    Context;
event({submit, {add_card, Args}, _, _}, Context) ->
    Title = z_context:get_q_validated("title", Context),
    case m_rsc:insert(
           [
            {title, Title}, 
            {category_id, m_category:name_to_id_check(card, Context)}
           ],
           Context) 
    of
        {ok, Id} ->
            ProjId = z_convert:to_integer(z_context:get_q("project", Context)),
            {ok, _} = m_edge:insert(ProjId, rbac_domain_rsc, Id, Context),
            ColumnId = z_convert:to_integer(z_context:get_q("column", Context)),
            {ok, _} = m_edge:insert(ColumnId, column_card, Id, Context),
            mod_signal:emit({card_changed,
                             [{event, added},
                              {card, Id},
                              {column, ColumnId},
                              {project, ProjId}
                             ]},
                            Context),
            z_render:wire(
              [
               {Action, [{id, Id}|ActionArgs]} 
               || {Action, ActionArgs} <- proplists:get_all_values(action, Args)
              ],
              Context);
        Error ->
            z_render:growl_error(io_lib:format("Add card failed~n~p", [Error]), Context)
    end;
event(#postback{message={setup_project, Args}}, Context) ->
    Id = proplists:get_value(id, Args),
    ok = setup_project(Id, Context),
    Context.

%%--------------------------------------------------------------------
observe_rsc_update_done(#rsc_update_done{ id=Card, 
                                          action=Action,
                                          post_is_a=IsA,
                                          pre_props=PreP,
                                          post_props=PostP },
                        Context) ->
    case lists:member(card, IsA) of
        false -> undefined;
        true ->
            ok = add_card_history(
                   Card, 
                   {Action, 
                    get_updated_props(Action, PostP -- PreP)
                   },
                   Context)
    end.

%%--------------------------------------------------------------------
observe_edge_insert(#edge_insert{ predicate=column_card, 
                                  subject_id=Column, 
                                  object_id=Card },
                    Context) ->
    ok = add_card_history(Card, 
                          {move,
                           [
                            {by, z_acl:user(Context)},
                            {timestamp, calendar:local_time()},
                            {column, Column}
                           ]
                          },
                          Context);
observe_edge_insert(_, _) -> undefined.


%%--------------------------------------------------------------------
%% observe_edge_delete(#edge_delete{ predicate=column_card,
%%                                   subject_id=Column,
%%                                   object_id=Card },
%%                     Context) ->
%%     ok;
%% observe_edge_delete(_, _) -> undefined.


%%--------------------------------------------------------------------
%%--------------------------------------------------------------------


%%====================================================================
%% Internal functions
%%====================================================================

%%--------------------------------------------------------------------
add_card_history(Card, Event, Context) ->
    mod_signal:emit({card_history, [{card, Card}, {event, Event}]}, Context),
    History = get_card_history(Card, Context),
    save_card_history(Card, [Event|History], Context).

%%--------------------------------------------------------------------
get_card_history(Card, Context) ->
    case m_tkvstore:get(card_history, Card, Context) of
        undefined ->
            [];
        List when is_list(List) ->
            List
    end.

%%--------------------------------------------------------------------
save_card_history(Card, History, Context) ->
    1 = m_tkvstore:put(card_history, Card, History, Context),
    ok.

%%--------------------------------------------------------------------
get_updated_props(insert, Updated) ->
    [ {transform_propname(Name), Value} || {Name, Value} <- Updated,
                                           filter_inserted_props(Name)];
get_updated_props(update, Updated) ->
    [ {transform_propname(Name), Value} || {Name, Value} <- Updated,
                                           filter_updated_props(Name)].

%%--------------------------------------------------------------------
transform_propname(modifier_id) -> by;
transform_propname(modified) -> timestamp;
transform_propname(body) -> description;
transform_propname(NoTransform) -> NoTransform.

%%--------------------------------------------------------------------
filter_inserted_props(version) -> true;
filter_inserted_props(modifier_id) -> true;
filter_inserted_props(modified) -> true;
filter_inserted_props(_) -> false.

filter_updated_props(title) -> true;
filter_updated_props(summary) -> true;
filter_updated_props(body) -> true;
filter_updated_props(Others) -> filter_inserted_props(Others).

%%--------------------------------------------------------------------
setup_project(Id, Context) ->
    Translation = (m_rsc:p(Id, translation, Context))(z_context:language(Context)),
    case m_rsc:insert(
           [
            {title, z_string:concat(Translation(title), " admin")}, 
            {short_title, "Admin"},
            {category_id, m_category:name_to_id_check(rbac_role, Context)}
           ], 
           Context) 
    of
        {ok, AdminRoleId} ->
            m_edge:insert(AdminRoleId, rbac_domain_role, admin_role, Context),
            m_edge:insert(Id, rbac_domain_role, AdminRoleId, Context),
            m_edge:insert(z_acl:user(Context), rbac_role_member, AdminRoleId, Context)
    end,
    case m_rsc:insert(
           [
            {title, z_string:concat(Translation(title), " member")}, 
            {short_title, "Member"},
            {category_id, m_category:name_to_id_check(rbac_role, Context)}
           ], 
           Context) 
    of
        {ok, MemberRoleId} ->
            m_edge:insert(MemberRoleId, rbac_domain_role, member_role, Context),
            m_edge:insert(Id, rbac_domain_role, MemberRoleId, Context)
    end,
    ok.

%%--------------------------------------------------------------------
