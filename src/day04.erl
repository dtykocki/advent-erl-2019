-module(day04).
-export([part1/0, part2/0]).

part1() ->
  Sequence = lists:seq(156218, 652527),
  Filtered = lists:filter(fun(Number) ->
                              Chars = integer_to_list(Number),
                              double(Chars) andalso increasing(Chars)
                          end, Sequence),
  length(Filtered).

part2() ->
  Sequence = lists:seq(156218, 652527),
  Filtered = lists:filter(fun(Number) ->
                              Chars = integer_to_list(Number),
                              adjacent(Chars) andalso increasing(Chars)
                          end, Sequence),
  length(Filtered).

adjacent([]) -> false;
adjacent([N, N, N | Rest]) -> adjacent(remove_item(N, Rest));
adjacent([N, N | _Rest]) -> true;
adjacent([_ | Rest]) -> adjacent(Rest).

double([]) -> false;
double([N, N | _Rest]) -> true;
double([_ | Rest]) -> double(Rest).

increasing(Chars) when length(Chars) =< 1 -> true;
increasing([First, Second | _]) when First > Second -> false;
increasing([_First, Second | Rest]) -> increasing([Second | Rest]).

remove_item(Item, List) -> [Elem || Elem <- List, Elem =/= Item].
