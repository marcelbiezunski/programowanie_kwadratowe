% Funkcja celu: x1^2 - 6x1 + 9 + x2^2 - 8x2 + 16
% Postać macierzowa 0.5*x^(T)*H*x + f^(T)*x
% Zauważ, że we wzorze jest 1/2, więc musimy pomnożyć współczynniki kwadratowe przez 2 w macierzy H.

% Macierze H - hesjan definiujący krzywiznę funkcji.
% Wartości na przekątnej są dodatnie, więc funkcja jest wypukła.
% Gwarantuje to istnienie minimum.
H = [2, 0; 0, 2];
% Wektor f - część liniowa odpowiadająca za przesunięcie "dna miski"
% względem punktu (0, 0).
f = [-6; -8];

% Ograniczenia nierównościowe A*x <= b
A = [1, 1];
b = [5];

% Ograniczenia brzegowe (x >= 0)
lb = [0; 0];
ub = []; % brak górnych ograniczeń

% Opcje (wymuszenie algorytmu active-set dla celów dydaktycznych)
options = optimoptions('quadprog', 'Algorithm', 'active-set', 'Display', 'iter');

[x, fval, exitflag, output] = quadprog(H, f, A, b, [], [], lb, ub, x0, options);

disp('Rozwiązanie:');
disp(x);