% Save this as mgandhi.pl
% This version is fixed to give UNIQUE results (no duplicates) 
% and includes all of Mahatma Gandhi's sons.

% -------- Gender --------
male(karamchand_gandhi).
male(mahatma_gandhi).
male(laxmidas_gandhi).
male(karsandas_gandhi).
male(harilal_gandhi).
male(manilal_gandhi).
male(ramdas_gandhi).
male(devdas_gandhi).
male(child1_laxmidas).
male(child1_karsandas).

female(putlibai_gandhi).
female(kasturba_gandhi).

% -------- Parent Relationships --------
% Parents of Mahatma and his brothers
parent(karamchand_gandhi, mahatma_gandhi).
parent(putlibai_gandhi, mahatma_gandhi).
parent(karamchand_gandhi, laxmidas_gandhi).
parent(putlibai_gandhi, laxmidas_gandhi).
parent(karamchand_gandhi, karsandas_gandhi).
parent(putlibai_gandhi, karsandas_gandhi).

% Mahatma Gandhi's 4 sons
parent(mahatma_gandhi, harilal_gandhi).
parent(kasturba_gandhi, harilal_gandhi).
parent(mahatma_gandhi, manilal_gandhi).
parent(kasturba_gandhi, manilal_gandhi).
parent(mahatma_gandhi, ramdas_gandhi).
parent(kasturba_gandhi, ramdas_gandhi).
parent(mahatma_gandhi, devdas_gandhi).
parent(kasturba_gandhi, devdas_gandhi).

% Children of siblings (for cousins)
parent(laxmidas_gandhi, child1_laxmidas).
parent(karsandas_gandhi, child1_karsandas).

% -------- Basic Relations --------
father(F, C) :- male(F), parent(F, C).
mother(M, C) :- female(M), parent(M, C).

% -------- Siblings (FIXED: Checks father ONLY to avoid duplicates) --------
sibling(X, Y) :-
    father(F, X),
    father(F, Y),
    X \= Y.

brother(B, X) :- male(B), sibling(B, X).
sister(S, X) :- female(S), sibling(S, X).

% -------- Grandparents --------
grandparent(GP, C) :- parent(GP, P), parent(P, C).
grandfather(GF, C) :- male(GF), grandparent(GF, C).
grandmother(GM, C) :- female(GM), grandparent(GM, C).

% -------- Uncle & Aunt --------
uncle(U, C) :- parent(P, C), brother(U, P).
aunt(A, C) :- parent(P, C), sister(A, P).

% -------- Cousins --------
cousin(X, Y) :- 
    parent(P1, X), 
    parent(P2, Y), 
    sibling(P1, P2).

% -------- Ancestor (Recursive) --------
% Base case
ancestor(A, C) :- parent(A, C).
% Recursive case
ancestor(A, C) :- parent(P, C), ancestor(A, P).
