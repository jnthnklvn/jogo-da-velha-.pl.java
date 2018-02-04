%% Todas as possibilidades de vitoria
vitoria(L,XY):- L = [XY,XY,XY,_,_,_,_,_,_];
                L = [_,_,_,XY,XY,XY,_,_,_];
                L = [_,_,_,_,_,_,XY,XY,XY];
                L = [XY,_,_,XY,_,_,XY,_,_];
                L = [_,XY,_,_,XY,_,_,XY,_];
                L = [_,_,XY,_,_,XY,_,_,XY];
                L = [XY,_,_,_,XY,_,_,_,XY];
                L = [_,_,XY,_,XY,_,XY,_,_].
%% Verifica se existe possibilidade de vitoria
vitoriaA(L) :-
  moverIA(L, X),
  moverJ(L, X, o, NL),
  vitoria(NL, o).
%% Procura possivel jogada e retorna a posição dela
moverIA([_,_,_,_,a,_,_,_,_], 5).
moverIA([x,a,a,_,_,_,a,_,x], 2).
moverIA([a,a,x,_,_,_,x,_,a], 2).
moverIA([x,x,a,_,_,_,a,a,x], 8).
moverIA([a,x,x,_,_,_,x,a,a], 8).
moverIA([_,_,_,_,_,_,_,_,a], 9).
moverIA([_,_,_,_,_,_,a,_,_], 7).
moverIA([_,_,a,_,_,_,_,_,_], 3).
moverIA([a,_,_,_,_,_,_,_,_], 1).
moverIA([_,a,_,_,_,_,_,_,_], 2).
moverIA([_,_,_,a,_,_,_,_,_], 4).
moverIA([_,_,_,_,_,a,_,_,_], 6).
moverIA([_,_,_,_,_,_,_,a,_], 8).
%% Registra as jogadas e retorna uma nova lista
moverJ([a,B,C,D,E,F,G,H,I], 1, XY, [XY,B,C,D,E,F,G,H,I]).
moverJ([A,a,C,D,E,F,G,H,I], 2, XY, [A,XY,C,D,E,F,G,H,I]).
moverJ([A,B,a,D,E,F,G,H,I], 3, XY, [A,B,XY,D,E,F,G,H,I]).
moverJ([A,B,C,a,E,F,G,H,I], 4, XY, [A,B,C,XY,E,F,G,H,I]).
moverJ([A,B,C,D,a,F,G,H,I], 5, XY, [A,B,C,D,XY,F,G,H,I]).
moverJ([A,B,C,D,E,a,G,H,I], 6, XY, [A,B,C,D,E,XY,G,H,I]).
moverJ([A,B,C,D,E,F,a,H,I], 7, XY, [A,B,C,D,E,F,XY,H,I]).
moverJ([A,B,C,D,E,F,G,a,I], 8, XY, [A,B,C,D,E,F,G,XY,I]).
moverJ([A,B,C,D,E,F,G,H,a], 9, XY, [A,B,C,D,E,F,G,H,XY]).
%% Verifica se existe espaço pra vitoria do jogador
venceJ(L) :- moverIA(L, X), moverJ(L, X, x, NL), vitoria(NL, x).
%% Procura melhor jogada pra IA (1.vitoria, 2.not(derrota))
oplay(L,X) :-
  moverIA(L, X),
  moverJ(L, X, o, NL),
  vitoria(NL, o),!.
oplay(L,X) :-
  moverIA(L, X),
  moverJ(L, X, o, NL),
  not(venceJ(NL)).
