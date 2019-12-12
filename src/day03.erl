-module(day03).
-export([part1/0, part2/0, distance/1]).

part1() ->
  Priv = code:priv_dir(advent),
  File = filename:join([Priv, "day03"]),
  {ok, Bin} = file:read_file(File),
  distance(string:trim(unicode:characters_to_list(Bin))).

part2() ->
  Priv = code:priv_dir(advent),
  File = filename:join([Priv, "day03"]),
  {ok, Bin} = file:read_file(File),
  fewest_steps(string:trim(unicode:characters_to_list(Bin))).

fewest_steps(String) ->
  [Item1, Item2] = string:tokens(String, "\n"),
  Wire1Tokens = string:tokens(Item1, ","),
  Wire2Tokens = string:tokens(Item2, ","),
  Wire1Points = parse_points(Wire1Tokens),
  Wire2Points = parse_points(Wire2Tokens),
  Wire1 = fill(Wire1Points),
  Wire2 = fill(Wire2Points),
  Set1 = ordsets:from_list(Wire1),
  Set2 = ordsets:from_list(Wire2),
  Intersections = ordsets:intersection(Set1, Set2) -- [{0,0}],
  Steps1 = steps(Wire1, Intersections),
  Steps2 = steps(Wire2, Intersections),
  lists:min([A+B || {A,B} <- lists:zip(Steps1, Steps2)]).

steps(Wire, Intersections) ->
  [do_thing(Wire, Point, 0) || Point <- Intersections].

do_thing([Point | _], Point, Acc) -> Acc;
do_thing([_ | Rest], Point, Acc) ->
  do_thing(Rest, Point, Acc + 1).

distance(String) ->
  [Item1, Item2] = string:tokens(String, "\n"),
  Wire1Tokens = string:tokens(Item1, ","),
  Wire2Tokens = string:tokens(Item2, ","),
  Wire1Points = parse_points(Wire1Tokens),
  Wire2Points = parse_points(Wire2Tokens),
  Wire1 = fill(Wire1Points),
  Wire2 = fill(Wire2Points),
  Set1 = ordsets:from_list(Wire1),
  Set2 = ordsets:from_list(Wire2),
  Intersections = ordsets:intersection(Set1, Set2) -- [{0,0}],
  [Distance | _] = lists:sort([abs(X) + abs(Y) || {X,Y} <- ordsets:to_list(Intersections)]),
  Distance.

fill(List) ->
  fill(List, [{0,0}]).

fill([], Acc) ->
  lists:reverse(Acc);
fill([{Direction, Distance} | Rest], [Point | _] = Acc) ->
  fill(Rest, next_point(Direction, Distance, Point, Acc)).

next_point(_Direction, 0, _Point, Acc) ->
  Acc;
next_point(Direction, Distance, {X,Y}, Acc) ->
  NextPoint = case Direction of
    up    -> {X, Y + 1};
    down  -> {X, Y - 1};
    left  -> {X - 1, Y};
    right -> {X + 1, Y}
  end,
  next_point(Direction, Distance - 1, NextPoint, [NextPoint | Acc]).

parse_points(Wire) ->
  parse_points(Wire, []).

parse_points([], Acc) ->
  lists:reverse(Acc);
parse_points([Head|Tail], Acc) ->
  parse_points(Tail, [parse_position(Head) | Acc]).

parse_position("U" ++ Rest) -> {up, list_to_integer(Rest)};
parse_position("D" ++ Rest) -> {down, list_to_integer(Rest)};
parse_position("L" ++ Rest) -> {left, list_to_integer(Rest)};
parse_position("R" ++ Rest) -> {right, list_to_integer(Rest)}.
