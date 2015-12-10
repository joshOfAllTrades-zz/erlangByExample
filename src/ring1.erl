%%%-------------------------------------------------------------------
%%% @author jt3518
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 09. Dec 2015 6:33 PM
%%%-------------------------------------------------------------------
-module(ring1).
-author("jt3518").

%% API
-export([start/1, quit/0]).
%% Internal API
-export([start_proc/2]).

-spec start(non_neg_integer()) -> ok.
start(NodeCount) ->
  master_loop(spawn_next(self(), NodeCount - 1)).

quit() ->
  self() ! stop,
  ok.

spawn_next(FrontPid, NodeCount) ->
  log("Spawning next process"),
  spawn(ring1, construct, [FrontPid, NodeCount]).

master_loop(NextPid) ->
  receive
    {send, MsgCount} -> ok;
    stop -> ok
  end.

start_proc(Front, 0) ->
  log("up"),
  loop(Front),
  ok;
start_proc(Front, Nodes) ->
  log("up"),
  Pid = spawn(ring1, construct, [Front, Nodes -1]),
  loop(Pid),
  ok.

loop(Next) ->
  log("awaiting messages").

log(Msg) ->
  io:fwrite("~w: ~s~n", [self(), Msg]).
