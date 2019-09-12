%% Todas as possibilidades de vitoria
vitoria(L,XY):- L = [XY,XY,XY,_,_,_,_,_,_];
                L = [_,_,_,XY,XY,XY,_,_,_];
                L = [_,_,_,_,_,_,XY,XY,XY];
                L = [XY,_,_,XY,_,_,XY,_,_];
                L = [_,XY,_,_,XY,_,_,XY,_];
                L = [_,_,XY,_,_,XY,_,_,XY];
                L = [XY,_,_,_,XY,_,_,_,XY];
                L = [_,_,XY,_,XY,_,XY,_,_].

%% Procura possivel jogada e retorna a posicao dela
encontrar_jogada([_,_,_,_,a,_,_,_,_], 5).
encontrar_jogada([_,_,a,_,_,_,_,_,_], 3).
encontrar_jogada([a,_,_,_,_,_,_,_,_], 1).
encontrar_jogada([_,_,_,_,_,_,_,_,a], 9).
encontrar_jogada([_,_,_,_,_,_,a,_,_], 7).
encontrar_jogada([_,a,_,_,_,_,_,_,_], 2).
encontrar_jogada([_,_,_,a,_,_,_,_,_], 4).
encontrar_jogada([_,_,_,_,_,a,_,_,_], 6).
encontrar_jogada([_,_,_,_,_,_,_,a,_], 8).

%% Verifica se existe possibilidade de vitoria
vitoriaAgora(Lista, Jogador) :-
  encontrar_jogada(Lista, Jogada),
  fazer_jogada(Lista, Jogada, Jogador, NovaLista),
  vitoria(NovaLista, Jogador).
vitoriaAntecipada(Lista, Jogador, Oponente) :-
  encontrar_jogada(Lista, Jogada),
  fazer_jogada(Lista, Jogada, Jogador, NovaLista),
  not(vitoriaAgora(NovaLista, Oponente)),
  count(vitoriaAgora(NovaLista, Jogador), Count),
  Count = 2,!.

count(P,Count) :-
findall(1,P,L),
length(L,Count).

%% Registra as jogadas e retorna uma nova lista
fazer_jogada([a,B,C,D,E,F,G,H,I], 1, Jogador, [Jogador,B,C,D,E,F,G,H,I]).
fazer_jogada([A,a,C,D,E,F,G,H,I], 2, Jogador, [A,Jogador,C,D,E,F,G,H,I]).
fazer_jogada([A,B,a,D,E,F,G,H,I], 3, Jogador, [A,B,Jogador,D,E,F,G,H,I]).
fazer_jogada([A,B,C,a,E,F,G,H,I], 4, Jogador, [A,B,C,Jogador,E,F,G,H,I]).
fazer_jogada([A,B,C,D,a,F,G,H,I], 5, Jogador, [A,B,C,D,Jogador,F,G,H,I]).
fazer_jogada([A,B,C,D,E,a,G,H,I], 6, Jogador, [A,B,C,D,E,Jogador,G,H,I]).
fazer_jogada([A,B,C,D,E,F,a,H,I], 7, Jogador, [A,B,C,D,E,F,Jogador,H,I]).
fazer_jogada([A,B,C,D,E,F,G,a,I], 8, Jogador, [A,B,C,D,E,F,G,Jogador,I]).
fazer_jogada([A,B,C,D,E,F,G,H,a], 9, Jogador, [A,B,C,D,E,F,G,H,Jogador]).

%% Procura melhor jogada pra IA
oplay(L,X) :-
  encontrar_jogada(L, X),
  fazer_jogada(L, X, o, NL),
  vitoria(NL, o),!.
oplay(L,X) :-
  encontrar_jogada(L, X),
  fazer_jogada(L, X, o, NL),
  vitoriaAntecipada(NL, o, x),
  not(vitoriaAgora(NL, x)),
  not(vitoriaAntecipada(NL, x, o)),!.
oplay(L,X) :-
  encontrar_jogada(L, X),
  fazer_jogada(L, X, o, NL),
  not(vitoriaAgora(NL, x)),
  not(vitoriaAntecipada(NL, x, o)),!.

%% Retorna falso se naoh eh possivel vitoria da IA
empate(L) :- encontrar_jogada(L, X), fazer_jogada(L, X, x, NL),
             not(vitoria(NL, x);vitoriaAgora(NL, x)),
             not(vitoriaAgora(NL, o)),!.