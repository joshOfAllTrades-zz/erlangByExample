%%%-------------------------------------------------------------------
%%% @author jt3518
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 07. Dec 2015 10:50 PM
%%%-------------------------------------------------------------------
-module(db).
-author("jt3518").

%% API
-export([new/0, destroy/1, write/3, delete/2, read/2, match/2]).

new() -> [].

destroy(_DbRef) -> ok.

write(Key, Element, DbRef) ->
  add({Key, Element}, delete(Key, DbRef)).

delete(Key, DbRef) ->
  delete(Key, [], DbRef).

read(Key, DbRef) ->
  find(Key, DbRef).

match(Element, DbRef) ->
  findAll(Element, [], DbRef).

add(Entry, []) ->
  [Entry];
add(Entry, [H | T]) ->
  [H | add(Entry, T)].

%% Helper Functions
find(_Key, []) ->
  {error, instance};
find(Key, [{Key, Value} | _Tail]) ->
  {ok, Value};
find(Key, [_ | Tail]) ->
  find(Key, Tail).

findAll(_Key, Results, []) ->
  Results;
findAll(Value, Results, [{Key, Value} | Tail]) ->
  findAll(Value, Results ++ [Key], Tail);
findAll(Value, Results, [_ | Tail]) ->
  findAll(Value, Results, Tail).

delete(_Key, Head, []) ->
  Head;
delete(Key, Head, [{Key, _Value} | Tail]) ->
  Head ++ Tail;
delete(Key, Head, [H | Tail]) ->
  delete(Key, Head ++ [H], Tail).
