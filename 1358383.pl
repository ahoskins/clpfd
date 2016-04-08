% Andrew Hoskins
% CMPUT 325 Assignment 4 - Prolog
% arhoskin - 1358383

:- use_module(library(clpfd)).

%%%%%%%%%%%%%%%%%%%%%%%%%% Question 1 - Four Squares %%%%%%%%%%%%%%%%%%%%%%%%%%
% Note: known problem of infinite loop after giving all answers :(

fourSquares(N, L):-
  ordered(L),
  length(L, 4),
  sumSquared(L, N).

fourSquares(N, [_|L]):-
  length(L, Len),
  Len #< 4,
  fourSquares(N, L).

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

%%%%%%%%%%%%%%%%%%%%%%%%% Question 2 - War and Peace %%%%%%%%%%%%%%%%%%%%%%%%%%

disarm(A, B, Out):-
  disarm(A, B, Out1, _),
  sort(Out1, Out).

disarm([], [], [], _).
disarm(A, B, [[[ASel1, ASel2],[BSel]] | Out], _):-
  length(A, LenA),
  LenA #>= 2,
  length(B, LenB),
  LenB #>= 1,

  select(ASel1, A, ARem),
  select(ASel2, ARem, ARemRem),
  select(BSel, B, BRem),
  BSel #= ASel1 + ASel2,

  disarm(ARemRem, BRem, Out, _).

disarm(A, B, [[[BSel1, BSel2],[ASel]] | Out], _):-
  length(A, LenA),
  LenA #>= 1,
  length(B, LenB),
  LenB #>= 2,

  select(BSel1, B, BRem),
  select(BSel2, BRem, BRemRem),
  select(ASel, A, ARem),
  ASel #= BSel1 + BSel2,

  disarm(ARem, BRemRem, Out, _).
