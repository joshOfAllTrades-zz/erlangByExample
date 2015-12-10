%%%-------------------------------------------------------------------
%%% @author jt3518
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 08. Dec 2015 1:07 PM
%%%-------------------------------------------------------------------
-module(echo).
-author("jt3518").

-export([start/0, stop/0, print/1]).
-export([loop/0]).

start() ->
  Pid = spawn(echo, loop, []),
  register(echo, Pid),
  ok.

stop() ->
  echo ! stop,
  ok.

print(Term) ->
  echo ! {print, Term},
  ok.

loop() ->
  receive
    {print, Msg} ->
      io:fwrite("~w~n", [Msg]),
      loop();
    stop ->
      true
  end.
