%%%-------------------------------------------------------------------
%%% @author stengel
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 19. Dec 2017 20:29
%%%-------------------------------------------------------------------
-module(recurring_tests).
-author("stengel").

-include_lib("eunit/include/eunit.hrl").

recurring_test() ->
  ?assertEqual({"B", 1}, recurring:first_occurrence("ABCDEBC")),
  ?assertEqual({"U", 3}, recurring:first_occurrence("IKEUNFUVFV")),
  ?assertEqual({"J", 3}, recurring:first_occurrence("PXLJOUDJVZGQHLBHGXIW")).
