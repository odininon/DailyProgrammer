%%%-------------------------------------------------------------------
%%% @author mstenge
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. Dec 2017 3:19 PM
%%%-------------------------------------------------------------------
-module(compliments).
-author("mstenge").

%% API
-export([mask32/1, answer/0]).

mask32(Num) -> Num band 2#11111111111111111111111111111111.

mxor(X, Y) -> mask32(X bxor Y).
mnot(X) -> mask32(bnot X).

popcount(N) ->
  popcount(N, 0).

popcount(0, Acc) ->
  Acc;
popcount(N, Acc) ->
  popcount(N div 2, Acc + N rem 2).

compatibility(X, Y) -> popcount(mxor(X, mnot(Y))) / 0.32.

answer() ->
  answer([
    [20, 65515],
    [32000, 101],
    [42000, 42],
    [13, 12345],
    [9999, 9999],
    [8008, 37331],
    [54311, 2],
    [31200, 34335],
    [100, 42]
  ]).

answer(List) ->
  lists:foreach(fun([A, Y]) -> answer(A, Y) end, List).

answer(X, Y) ->
  io:format("~p% Compatibility\n", [compatibility(X, Y)]),
  io:format("~p should avoid ~p\n", [X, mnot(X)]),
  io:format("~p should avoid ~p\n\n", [Y, mnot(Y)]).