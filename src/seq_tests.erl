%%%-------------------------------------------------------------------
%%% @author jt3518
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 07. Dec 2015 4:35 PM
%%%-------------------------------------------------------------------
-module(seq_tests).
-author("jt3518").

-include_lib("eunit/include/eunit.hrl").

sum_1_test() ->
  ?assertEqual(0, seq:sum(0)).

sum_2_test() ->
  ?assertEqual(1, seq:sum(1)).

sum_3_test() ->
  ?assertEqual(15, seq:sum(5)).

sum_4_test() ->
  ?assertException(error, _, seq:sum(-1)).


sum_interval_1_test() ->
  ?assertEqual(6, seq:sum_interval(1,3)).

sum_interval_2_test() ->
  ?assertEqual(6, seq:sum_interval(6, 6)).

create_1_test() ->
  ?assertEqual([], seq:create(0)).

create_2_test() ->
  ?assertException(error, _, seq:create(-1)).

create_3_test() ->
  ?assertEqual([1,2,3], seq:create(3)).

reverse_create_1_test() ->
  ?assertEqual([], seq:reverse_create(0)).

reverse_create_2_test() ->
  ?assertException(error, _, seq:reverse_create(-1)).

reverse_create_3_test() ->
  ?assertEqual([3,2,1], seq:reverse_create(3)).
