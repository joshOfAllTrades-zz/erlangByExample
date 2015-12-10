%%%-------------------------------------------------------------------
%%% @author jt3518
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 07. Dec 2015 9:13 AM
%%%-------------------------------------------------------------------
-module(demo).
-author("jt3518").

%% API
-export([double/1]).

double(X) ->
  times(X, 2).

times(X, N) ->
  X * N.