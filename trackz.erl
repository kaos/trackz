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
-export([init/1]).


%%====================================================================
%% API
%%====================================================================

%%--------------------------------------------------------------------
init(Context) ->
    z_datamodel:manage(?MODULE,
		       #datamodel{ categories = [{project, undefined, [{title, <<"Project">>}]}],
				   predicates = [{project_member, [{title, <<"Project Member">>}], [{project, person}]}]
				 },
		       Context
		      ),
    ok.

			


%%====================================================================
%% Internal functions
%%====================================================================
