-module(day02_SUITE).
-export([all/0, examples/1, part1/1, part2/1]).

-include_lib("common_test/include/ct.hrl").
-include_lib("stdlib/include/assert.hrl").

all() ->
  [examples, part1, part2].

part1(_) ->
  ?assertEqual(5534943, day02:part1()),
  ok.

part2(_) ->
  ?assertEqual(7603, day02:part2()),
  ok.

examples(_) ->
  ?assertEqual([2,0,0,0,99], day02:run([1,0,0,0,99])),
  ?assertEqual([2,3,0,6,99], day02:run([2,3,0,3,99])),
  ?assertEqual([2,4,4,5,99,9801], day02:run([2,4,4,5,99,0])),
  ?assertEqual([30,1,1,4,2,5,6,0,99], day02:run([1,1,1,4,99,5,6,0,99])),
  ok.
