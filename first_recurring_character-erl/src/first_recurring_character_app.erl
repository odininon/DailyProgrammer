%%%-------------------------------------------------------------------
%% @doc first_recurring_character public API
%% @end
%%%-------------------------------------------------------------------

-module(first_recurring_character_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
    first_recurring_character_sup:start_link().

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================
