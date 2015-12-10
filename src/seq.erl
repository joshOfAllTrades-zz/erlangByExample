%%%-------------------------------------------------------------------
%%% @author jt3518
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 07. Dec 2015 4:35 PM
%%%-------------------------------------------------------------------
-module(seq).
-author("jt3518").

%% API
-export([sum/1, sum_interval/2, create/1, reverse_create/1, print/1, even_print/1]).

sum(N) when N > 0 ->
  N + sum(N - 1);
sum(0) -> 0.

sum_interval(M, M) -> M;
sum_interval(N, M) when N < M ->
  N + sum_interval(N + 1, M).

create(N) when N >= 0 ->
  create(N, []).

create(0, L) ->
  L;
create(N, L) ->
  create(N - 1, [N | L]).

reverse_create(0) -> [];

reverse_create(N) when N > 0 ->
  [N | reverse_create(N - 1)].

print(N) when N > 0 ->
  print(1, N).

print(N, N) ->
  println(N);
print(N, End) ->
  println(N),
  print(N + 1, End).

even_print(1) ->
  ok;
even_print(N) when N >= 2 ->
  even_print(2, N).

even_print(N, End) when N > End ->
  ok;
even_print(N, End) when N =< End ->
  println(N),
  even_print(N + 2, End).

println(Val) ->
  io:fwrite("~w~n", [Val]).
