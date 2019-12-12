-module(day01_SUITE).
-export([all/0, examples/1, part1/1, part2/1]).

-include_lib("common_test/include/ct.hrl").
-include_lib("stdlib/include/assert.hrl").

all() ->
  [examples, part1, part2].

part1(_) ->
  ?assertEqual(3361299, day01:part1()),
  ok.

part2(_) ->
  ?assertEqual(5039071, day01:part2()),
  ok.

examples(_) ->
  ?assertEqual(2,     day01:fuel(12)),
  ?assertEqual(2,     day01:fuel(14)),
  ?assertEqual(654,   day01:fuel(1969)),
  ?assertEqual(33583, day01:fuel(100756)),
  ?assertEqual(2,     day01:calculate_fuel(14)),
  ?assertEqual(966,   day01:calculate_fuel(1969)),
  ?assertEqual(50346, day01:calculate_fuel(100756)),
  ok.
