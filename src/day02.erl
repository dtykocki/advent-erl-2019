-module(day02).
-export([part1/0, part2/0, run/1]).

part1() ->
  String = input(),
  Program = [list_to_integer(X) || X <- string:tokens(String, ",")],
  Map = program_to_map(Program),
  NewMap = Map#{1 := 12, 2 := 2},
  Final = run(NewMap, 0),
  maps:get(0, Final).

part2() ->
  String = input(),
  Program = [list_to_integer(X) || X <- string:tokens(String, ",")],
  Map = program_to_map(Program),
  Sequence = [{Noun, Verb} || Noun <- lists:seq(0, 99),
                              Verb <- lists:seq(0, 99)],
  {Noun, Verb} = search(Map, 19690720, Sequence),
  100 * Noun + Verb.

search(Map, Value, [{Noun, Verb} | Rest]) ->
  NewMap = Map#{1 := Noun, 2 := Verb},
  case run(NewMap, 0) of
    #{0 := Value} -> {Noun, Verb};
    _ -> search(Map, Value, Rest)
  end.

run(Program) ->
  Final = run(program_to_map(Program), 0),
  [V || {_,V} <- maps:to_list(Final)].

run(Program, Pointer) ->
  case maps:get(Pointer, Program) of
    1   -> run(do_add(Program, Pointer), Pointer + 4);
    2   -> run(do_mul(Program, Pointer), Pointer + 4);
    99  -> Program
  end.

do_add(Program, Pointer) ->
  P1 = maps:get(Pointer + 1, Program),
  P2 = maps:get(Pointer + 2, Program),
  SP = maps:get(Pointer + 3, Program),
  #{P1 := A, P2 := B} = Program,
  Program#{SP := A + B}.

do_mul(Program, Pointer) ->
  P1 = maps:get(Pointer + 1, Program),
  P2 = maps:get(Pointer + 2, Program),
  SP = maps:get(Pointer + 3, Program),
  #{P1 := A, P2 := B} = Program,
  Program#{SP := A * B}.

program_to_map(Program) ->
  {_, Result} = lists:foldl(
    fun(Value, {Index, Map}) -> {Index + 1, Map#{Index => Value}} end,
    {0, #{}},
    Program
  ),
  Result.

input() ->
  Priv = code:priv_dir(advent),
  File = filename:join([Priv, "day02"]),
  {ok, Bin} = file:read_file(File),
  string:trim(unicode:characters_to_list(Bin)).
