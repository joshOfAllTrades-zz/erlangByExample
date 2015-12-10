%%%-------------------------------------------------------------------
%%% @author jt3518
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 09. Dec 2015 11:14 PM
%%%-------------------------------------------------------------------
-module(ring).
-author("jt3518").

%% API
-export([run/3]).

%% Entry Point - Initializes the ring, sends the messages, and cleans up.
run(NumNodes, NumMsgs, MsgBody) ->
  Ring = spawn(fun() -> init_master(NumNodes - 1) end),
  sendMsgs(Ring, NumMsgs, MsgBody),
  Ring ! {self(), quit}.

sendMsgs(_Ring, 0, _Body) ->
  true;
sendMsgs(Ring, NumMsgs, Body) when NumMsgs > 0 ->
  Ring ! {self(), msg, Body},
  sendMsgs(Ring, NumMsgs - 1, Body).

%% Initializes the Master node
init_master(NumSlaves) ->
  SlavePid = spawn_slaves(NumSlaves, self()),
  io:fwrite("Master: ~w, Slave:~w~n", [self(), SlavePid]),
  loop(SlavePid).

%% Spawns the slave nodes
spawn_slaves(1, Master) ->
  spawn(fun() -> init_slave(Master) end);
spawn_slaves(NumSlaves, Master) ->
  spawn(fun() -> init_slave(spawn_slaves(NumSlaves - 1, Master)) end).

%% Initializes a single slave and starts the event loop
init_slave(NextPid) ->
  io:fwrite("~w is up with target ~w~n", [self(), NextPid]),
  loop(NextPid).

loop(Dest) ->
  Self = self(),
  receive
    {Self, msg, _Body} ->
      % I sent this message
      io:fwrite("Received a message I sent"),
      loop(Dest);
    {_, msg, Body} ->
      % Someone else sent this message
      io:fwrite("~w ~s~n", [self(), Body]),
      Dest ! {msg, Body},
      loop(Dest);
    {Self, quit} ->
      % I sent this message
      io:fwrite("Everyone has been notified to quit.");
    {_, quit} ->
      io:fwrite("Sending quit to ~w~n", [Dest]),
      Dest ! quit
  end.