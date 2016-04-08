:- use_module(library(clpfd)).

% Question 1 - Four Squares
% TODO: problem, it's an inf loop after it gets the answers....

fourSquare(N, L):-
  ordered(L),
  length(L, 4),
  sumSquared(L, N).

fourSquare(N, L):-
  append(L1, [_], L),
  % append(L, [_], L1),
  fourSquare(N, L1).

sumSquared([], 0).
sumSquared([X|Tail], Sum):-
  Sum #= Temp + (X*X),
  sumSquared(Tail, Temp),
  label([X]).

ordered([]).
ordered([X|L]):-
  ordered(L, X).

ordered([], _).
ordered([X|L], Last):-
  X #>= Last,
  ordered(L, X).

% Question 2

disarm([], [], []).
disarm(A, B, [[[ASel1, ASel2],[BSel]] | Out]):-
  length(A, LenA),
  LenA #>= 2,
  length(B, LenB),
  LenB #>= 1,

  select(ASel1, A, ARem),
  select(ASel2, ARem, ARemRem),
  select(BSel, B, BRem),
  BSel #= ASel1 + ASel2,
  disarm(ARemRem, BRem, Out).

disarm(A, B, [[[BSel1, BSel2],[ASel]] | Out]):-
  length(A, LenA),
  LenA #>= 1,
  length(B, LenB),
  LenB #>= 2,

  select(BSel1, B, BRem),
  select(BSel2, BRem, BRemRem),
  select(ASel, A, ARem),
  ASel #= BSel1 + BSel2,
  disarm(ARem, BRemRem, Out).
