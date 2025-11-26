% Znajdź minimum funkcji kwadratowej znajdującej się w trójkącie
% ograniczonym prostymi

H = 2*eye(2); % eye tworzy macierz diagonalną o wymiarze x
f = zeros(2, 1);
ub = [2; 1];
A = [-1 -2];
b = [-2];

% Poszukiwanie rozwiązania
[x, fval] = quadprog(H, f, A, b, [], [], [], ub)