-module(day04_SUITE).
-export([all/0, part1/1, part2/1]).

-include_lib("common_test/include/ct.hrl").
-include_lib("stdlib/include/assert.hrl").

all() ->
  [part1, part2].

part1(_) ->
  ?assertEqual(1694, day04:part1()),
  ok.

part2(_) ->
  ?assertEqual(1148, day04:part2()),
  ok.
