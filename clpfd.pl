:- use_module(library(clpfd)).

%%%%%%%%%%%%%%%%%%%%%%%%%% Four Squares %%%%%%%%%%%%%%%%%%%%%%%%%%
/*
It's an interesting theorem from number theory that every natural number
can be expressed as the sum of four or fewer squares.

fourSquares(N, L) where L is a list of numbers who's square sum is N

ex: fourSquares(20, L) --> L = [1,1,3,3] OR L = [0,0,2,4] OR ...
*/

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

%%%%%%%%%%%%%%%%%%%%%%%%% War and Peace %%%%%%%%%%%%%%%%%%%%%%%%%%
/*
Two countries have signed a peace treaty and want to disarm over a period of months,
but they still don't completely trust each other. Each month one of the countries
can choose to dismantle one military division while the other can dismantle two.
Each division has a certain strength, and both sides want to make sure that the
total military strength remains equal at each point during the disarmament process.

ex:
Country A: 1, 3, 3, 4, 6, 10, 12
Country B: 3, 4, 7, 9, 16

one solution is:
Month 1: A dismantles 1 and 3, B dismantles 4
Month 2: A dismantles 3 and 4, B dismantles 7
Month 3: A dismantles 12, B dismantles 3 and 9
Month 4: A dismantles 6 and 10, B dismantles 16

expressed in prolog as:
Solution = [[[1,3],[4]], [[3,4],[7]], [[12],[3,9]], [[6,10],[16]]]

disarm(A, B, D) where A and B are lists of country division strengths, and D is the solution
*/

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
