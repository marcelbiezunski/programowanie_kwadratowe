% Zastosowanie praktyczne – Dywersyfikacja portfela (Markowitz)
% 
% To klasyczne zadanie dla QP. Jest ciekawsze niż abstrakcyjne "iksy".
% 
% Treść: Jesteś inwestorem. Masz 3 spółki do wyboru.
% 
% Oczekiwane zwroty (wektor r): Spółka A: 10%, B: 20%, C: 15%.
% 
% Ryzyko (macierz kowariancji H): Podana w kodzie.
% 
% Cel: Zminimalizuj ryzyko portfela (1/2*​(x^T)*H*x) przy założeniu, że oczekiwany zysk z całego portfela wyniesie co najmniej 15%.
% 
% Warunki: Suma udziałów musi wynosić 1 (100% kapitału), udziały nie mogą być ujemne (brak krótkiej sprzedaży).

H = [0.1, 0.02, 0.04; 
     0.02, 0.2, 0.06; 
     0.04, 0.06, 0.15];

f = [0; 0; 0]; % W tym modelu minimalizujemy tylko wariancję (ryzyko)

% Ograniczenie 1: Średni zwrot >= 15% (czyli -r * x <= -0.15)
% quadprog obsługuje <=, więc mnożymy przez -1
A = -[0.10, 0.20, 0.15];
b = -0.15;

% Ograniczenie 2: Suma wag = 1 (równościowe)
Aeq = [1, 1, 1];
beq = 1;

% Ograniczenie 3: Wagi >= 0
lb = [0; 0; 0];
ub = [1; 1; 1];
x0 = [0; 0; 0];

options = optimoptions('quadprog', 'Algorithm', 'active-set');
[x, fval] = quadprog(H, f, A, b, Aeq, beq, lb, ub, x0, options);

fprintf('Udział w Spółce A: %.2f%%\n', x(1)*100);
fprintf('Udział w Spółce B: %.2f%%\n', x(2)*100);
fprintf('Udział w Spółce C: %.2f%%\n', x(3)*100);