-module(day03_SUITE).
-export([all/0, examples/1, part1/1, part2/1]).

-include_lib("common_test/include/ct.hrl").
-include_lib("stdlib/include/assert.hrl").

all() ->
  [examples, part1, part2].

part1(_) ->
  ?assertEqual(2427, day03:part1()),
  ok.

part2(_) ->
  ?assertEqual(27890, day03:part2()),
  ok.

examples(_) ->
  ?assertEqual(159, day03:distance("R75,D30,R83,U83,L12,D49,R71,U7,L72\nU62,R66,U55,R34,D71,R55,D58,R83\n")),
  ?assertEqual(135, day03:distance("R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51\nU98,R91,D20,R16,D67,R40,U7,R15,U6,R7\n")),
  ok.
