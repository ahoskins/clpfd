:- use_module(library(clpfd)).

% Question 1 - Four Squares
% TODO: problem, it's an inf loop after it gets the answers....

fourSquare(N, L):-
  ordered(L),
  length(L, 4),
  sumSquared(L, N).

fourSquare(N, L):-
  append(L, [X], L1),
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



% count(L, H, X):-
%   X #= L,
%   X #< H.
% count(L, H, X):-
%   L1 #= L + 1,
%   L1 #< H,
%   count(L1, H, X).
