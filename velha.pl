vitoria(L,XY):- L = [XY,XY,XY,_,_,_,_,_,_];
                L = [_,_,_,XY,XY,XY,_,_,_];
                L = [_,_,_,_,_,_,XY,XY,XY];
                L = [XY,_,_,XY,_,_,XY,_,_];
                L = [_,XY,_,_,XY,_,_,XY,_];
                L = [_,_,XY,_,_,XY,_,_,XY];
                L = [XY,_,_,_,XY,_,_,_,XY];
                L = [_,_,XY,_,XY,_,XY,_,_].

moverIA([A,B,C,D,a,F,G,H,I], 5).
moverIA([x,a,a,D,E,F,a,H,x], 2).
moverIA([a,a,x,D,E,F,x,H,a], 2).
moverIA([x,x,a,D,E,F,a,a,x], 8).
moverIA([a,x,x,D,E,F,x,a,a], 8).
moverIA([A,B,C,D,E,F,G,H,a], 9).
moverIA([A,B,C,D,E,F,a,H,I], 7).
moverIA([A,B,a,D,E,F,G,H,I], 3).
moverIA([a,B,C,D,E,F,G,H,I], 1).
moverIA([A,a,C,D,E,F,G,H,I], 2).
moverIA([A,B,C,a,E,F,G,H,I], 4).
moverIA([A,B,C,D,E,a,G,H,I], 6).
moverIA([A,B,C,D,E,F,G,a,I], 8).

moverJ([a,B,C,D,E,F,G,H,I], 1, [x,B,C,D,E,F,G,H,I]).
moverJ([A,a,C,D,E,F,G,H,I], 2, [A,x,C,D,E,F,G,H,I]).
moverJ([A,B,a,D,E,F,G,H,I], 3, [A,B,x,D,E,F,G,H,I]).
moverJ([A,B,C,a,E,F,G,H,I], 4, [A,B,C,x,E,F,G,H,I]).
moverJ([A,B,C,D,a,F,G,H,I], 5, [A,B,C,D,x,F,G,H,I]).
moverJ([A,B,C,D,E,a,G,H,I], 6, [A,B,C,D,E,x,G,H,I]).
moverJ([A,B,C,D,E,F,a,H,I], 7, [A,B,C,D,E,F,x,H,I]).
moverJ([A,B,C,D,E,F,G,a,I], 8, [A,B,C,D,E,F,G,x,I]).
moverJ([A,B,C,D,E,F,G,H,a], 9, [A,B,C,D,E,F,G,H,x]).

venceJ(L) :- moverIA(L, X), moverJ(L, X, NL), vitoria(NL, x).

oplay(L,X) :-
  moverIA(L, X),
  moverJ(L, X, NL),
  vitoria(NL, o),!.
oplay(L,X) :-
  moverIA(L, X),
  not(venceJ(NL)).
oplay(L,X) :-
  moverIA(L, X).
oplay(L,X) :-
  not(member(a,L)),
  X = -1.
