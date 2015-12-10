%%%-------------------------------------------------------------------
%%% @author jt3518
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 07. Dec 2015 4:14 PM
%%%-------------------------------------------------------------------
-module(boolean_tests).
-author("jt3518").

-include_lib("eunit/include/eunit.hrl").

b_not_true_test() ->
  ?assertEqual(true, boolean:b_not(false)).

b_not_false_test() ->
  ?assertEqual(false, boolean:b_not(true)).

b_and_tt_test() ->
  ?assertEqual(true, boolean:b_and(true, true)).

b_and_tf_test() ->
  ?assertEqual(false, boolean:b_and(true, false)).

b_and_ft_test() ->
  ?assertEqual(false, boolean:b_and(false, true)).

b_and_ff_test() ->
  ?assertEqual(false, boolean:b_and(false, false)).

b_or_tt_test() ->
  ?assertEqual(true, boolean:b_or(true, true)).

b_or_tf_test() ->
  ?assertEqual(true, boolean:b_or(true, false)).

b_or_ft_test() ->
  ?assertEqual(true, boolean:b_or(false, true)).

b_or_ff_test() ->
  ?assertEqual(false, boolean:b_or(false, false)).
