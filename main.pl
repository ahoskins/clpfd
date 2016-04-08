% four squares
% four numbers who's square sums are N
%

:- use_module(library(clpfd)).

fourSquare(N, L):-
  length(L, 4),
  sumSquared(L, N).
fourSquare(N, L):-
  once(length(L, Len)),
  Len #< 4,
  sumSquared(L, Sum),
  Sum #< N,
  Max #= floor(sqrt(N - Sum)),
  last(L, Last),
  count(Last, Max, X),
  append(L, [X], L1),
  fourSquare(N, L1).

sumSquared([], 0).
sumSquared([X|Tail], Sum):-
  Sum #= Temp + (X*X),
  sumSquared(Tail, Temp),
  label([X]).

count(L, H, X):-
  X #= L,
  X #< H.
count(L, H, X):-
  L1 #= L + 1,
  L1 #< H,
  count(L1, H, X).
