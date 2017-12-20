%%%-------------------------------------------------------------------
%%% @author stengel
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 19. Dec 2017 20:31
%%%-------------------------------------------------------------------
-module(recurring).
-author("stengel").

%% API
-export([first_occurrence/1]).

first_occurrence(String) ->
  occurrence([[X] || X <- String], dict:new(), 0).

occurrence([], _Dict, _Index) ->
  none_found;
occurrence(ListOfLetters, Dict, Index) ->
  Letter = hd(ListOfLetters),
  case dict:find(Letter, Dict) of
    error -> occurrence(tl(ListOfLetters), dict:append(Letter, Index, Dict), Index + 1);
    {ok, Y} -> {Letter, hd(Y)}
  end.