%%%-------------------------------------------------------------------
%%% @author jt3518
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 09. Dec 2015 9:19 PM
%%%-------------------------------------------------------------------
-module(ring2).
-author("jt3518").

%% API
-export([start/1, send/2, quit/1]).

start(NumNodes) ->
  spawn_nodes(NumNodes).

send(Front, NumMsgs) when NumMsgs > 0 ->
  Front ! {msg, self()},
  send(Front, NumMsgs - 1).

quit(Front) ->
  Front ! quit.

spawn_nodes(1) ->
  spawn_node(first);
spawn_nodes(NumNodes) when NumNodes > 1 ->
  spawn_node(spawn_nodes(NumNodes - 1)).

spawn_node(Dest) ->
  spawn(fun() -> init(Dest) end).

init(Dest) ->
  io:fwrite("~w is up with target ~w~n", [self(), Dest]),
  loop(Dest).

loop(Dest) ->
  receive
    quit ->
      io:fwrite("Sending quit to ~w~n", [Dest]),
      Dest ! quit
  end.