-module(day01).
-export([part1/0, part2/0, fuel/1, calculate_fuel/1]).

part1() ->
  String = input(),
  Modules = parse_input(String),
  lists:sum([fuel(Module) || Module <- Modules]).

part2() ->
  String = input(),
  Modules = parse_input(String),
  lists:sum([calculate_fuel(Module) || Module <- Modules]).

calculate_fuel(Module) ->
  Fuel = fuel(Module),
  calculate_fuel(Fuel, 0).

calculate_fuel(Fuel, Acc) when Fuel > 0 ->
  NewFuel = fuel(Fuel),
  calculate_fuel(NewFuel, Fuel + Acc);
calculate_fuel(_, Acc) ->
  Acc.

fuel(N) ->
  (N div 3) - 2.

parse_input(String) ->
  [list_to_integer(X) || X <- string:tokens(String, "\n")].

input() ->
  Priv = code:priv_dir(advent),
  File = filename:join([Priv, "day01"]),
  {ok, Bin} = file:read_file(File),
  unicode:characters_to_list(Bin).
