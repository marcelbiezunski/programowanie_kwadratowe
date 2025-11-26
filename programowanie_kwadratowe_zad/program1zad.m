% Rozwiązanie zadania programowania kwadratowego

H = ; % hesjan
f = ; % wektor współczynników funkcji celu
A = ; % macierz ograniczeń liniowych
b = ; % wektor ograniczeń
lb = ; % wektor ograniczeń zerowych

% Poszukiwanie rozwiązania
[x, fval, exitflag, output, lambda] = quadprog(H, f, A, b, [], [], lb)