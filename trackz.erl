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
-mod_prio(100).

-include_lib("zotonic.hrl").


%% API
-export([
         init/1,
         event/2
        ]).


%%====================================================================
%% API
%%====================================================================

%%--------------------------------------------------------------------
init(Context) ->
    z_datamodel:manage(?MODULE,
		       #datamodel{ categories = [{project, undefined, [{title, <<"Project">>}]},
						 {column, undefined, [{title, <<"Column">>}]},
                                                 {card, undefined, [{title, <<"Card">>}]}
						],
				   predicates = [{project_member, [{title, <<"Project Member">>}], [{project, person}]},
						 {project_column, [{title, <<"Project Column">>}], [{project, column}]},
						 {card_column, [{title, <<"Card Column">>}], [{card, column}]}
						]
				 },
		       Context
		      ),
    ok.

			
%%--------------------------------------------------------------------
event({submit, {create_project, Args}, _, _}, Context) ->
    Title = z_context:get_q_validated("title", Context),
    case m_rsc:insert(
           [
            {title, Title}, 
            {category_id, m_category:name_to_id_check(project, Context)}
           ], 
           Context) 
    of
        {ok, Id} ->
            m_edge:insert(Id, project_member, z_acl:user(Context), Context),
            z_render:wire(
              [
               {Action, [{id, Id}|ActionArgs]} 
               || {Action, ActionArgs} <- proplists:get_all_values(action, Args)
              ],
              Context);
        Error ->
            z_render:growl_error(io_lib:format("Create Project failed~n~p", [Error]), Context)
    end;
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
            {ok, _} = m_edge:insert(Id, card_column, z_context:get_q("column", Context), Context),
            z_render:wire(
              [
               {Action, [{id, Id}|ActionArgs]} 
               || {Action, ActionArgs} <- proplists:get_all_values(action, Args)
              ],
              Context);
        Error ->
            z_render:growl_error(io_lib:format("Add card failed~n~p", [Error]), Context)
    end.


%%====================================================================
%% Internal functions
%%====================================================================
