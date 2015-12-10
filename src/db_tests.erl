%%%-------------------------------------------------------------------
%%% @author jt3518
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 07. Dec 2015 10:52 PM
%%%-------------------------------------------------------------------
-module(db_tests).
-author("jt3518").

-include_lib("eunit/include/eunit.hrl").

book_1_test() ->
  Db = db:new(),
  ?assertEqual([], Db).

book_2_test() ->
  Db = db:new(),
  Db1 = db:write(francesco, london, Db),
  ?assertEqual([{francesco, london}], Db1).

book_3_test() ->
  Db = db:new(),
  Db1 = db:write(francesco, london, Db),
  Db2 = db:write(lelle, stockholm, Db1),
  ?assertEqual([{francesco, london}, {lelle, stockholm}], Db2).

book_4_test() ->
  Db = db:new(),
  Db1 = db:write(francesco, london, Db),
  Db2 = db:write(lelle, stockholm, Db1),
  ?assertEqual({ok, london}, db:read(francesco, Db2)).

book_5_test() ->
  Db = db:new(),
  Db1 = db:write(francesco, london, Db),
  Db2 = db:write(lelle, stockholm, Db1),
  Db3 = db:write(joern, stockholm, Db2),
  ?assertEqual([{francesco, london}, {lelle, stockholm}, {joern, stockholm}], Db3).

book_6_test() ->
  Db = db:new(),
  Db1 = db:write(francesco, london, Db),
  Db2 = db:write(lelle, stockholm, Db1),
  Db3 = db:write(joern, stockholm, Db2),
  ?assertEqual({error, instance}, db:read(ola, Db3)).

book_7_test() ->
  Db = db:new(),
  Db1 = db:write(francesco, london, Db),
  Db2 = db:write(lelle, stockholm, Db1),
  Db3 = db:write(joern, stockholm, Db2),
  ?assertEqual([lelle, joern], db:match(stockholm, Db3)).

book_8_test() ->
  Db = db:new(),
  Db1 = db:write(francesco, london, Db),
  Db2 = db:write(lelle, stockholm, Db1),
  Db3 = db:write(joern, stockholm, Db2),
  Db4 = db:delete(lelle, Db3),
  ?assertEqual([{francesco, london}, {joern, stockholm}], Db4).

book_9_test() ->
  Db = db:new(),
  Db1 = db:write(francesco, london, Db),
  Db2 = db:write(lelle, stockholm, Db1),
  Db3 = db:write(joern, stockholm, Db2),
  Db4 = db:delete(lelle, Db3),
  ?assertEqual([joern], db:match(stockholm, Db4)).

book_10_test() ->
  Db = db:new(),
  Db1 = db:write(francesco, london, Db),
  Db2 = db:write(lelle, stockholm, Db1),
  Db3 = db:write(joern, stockholm, Db2),
  Db4 = db:delete(lelle, Db3),
  ?assertEqual([{francesco, london}, {joern, london}],
      db:write(joern, london, Db4)).