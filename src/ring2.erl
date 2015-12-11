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
-export([start/1, send/2, quit/0]).

start(NumNodes) ->
  First = spawn_nodes(NumNodes),
  io:fwrite("~w is first~n", [First]),
  register(first, First).

send(NumMsgs, Body) when NumMsgs > 0 ->
  io:fwrite("Sending ~w ~w times.~n", [Body, NumMsgs]),
  first ! {msg, Body},
  send(NumMsgs - 1, Body);
send(0, _Body) ->
  ok.

quit() ->
  first ! quit.

spawn_nodes(1) ->
  spawn_node(first);
spawn_nodes(NumNodes) when NumNodes > 1 ->
  spawn_node(spawn_nodes(NumNodes - 1)).

spawn_node(Dest) ->
  io:fwrite("Spawning with target ~w~n", [Dest]),
  spawn(fun() -> init(Dest) end).

init(Dest) ->
  io:fwrite("~w is up with target ~w~n", [self(), Dest]),
  loop(Dest).

loop(Dest) ->
  Self = self(),
  receive
    {msg, Body} ->
      io:fwrite("Starting message loop."),
      Dest ! {msg, self(), Body};
    {msg, Self, Body} ->
      io:fwrite("Reached end of message loop~n"),
      io:fwrite("~w~n", [Body]);
    {msg, First, Body} ->
      io:fwrite("Forwarding message to ~w~n", [Dest]),
      Dest ! {msg, First, Body};
    quit ->
      io:fwrite("Starting quit loop by sending from ~w to ~w~n",
          [Self, Dest]),
      Dest ! {quit, self()},
      loop(Dest);
    {quit, Self} ->
      io:fwrite("Reached end of quit loop~n"),
      io:fwrite("~w exiting~n", [Self]);
    {quit, First} ->
      io:fwrite("Forwarding quit to ~w~n", [Dest]),
      Dest ! {quit, First},
      io:fwrite("~w exiting~n", [Self])
  end.
