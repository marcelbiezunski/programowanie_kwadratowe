% Zastosowanie praktyczne – Dywersyfikacja portfela (Markowitz)
% To klasyczne zadanie dla QP. Jest ciekawsze niż abstrakcyjne "iksy".
% Treść: Jesteś inwestorem. Masz 3 spółki do wyboru.
% Oczekiwane zwroty (wektor r): Spółka A: 10%, B: 20%, C: 15%.
% Ryzyko (macierz kowariancji H): Podana w kodzie.
% Cel: Zminimalizuj ryzyko portfela (1/2*​(x^T)*H*x) przy założeniu, że oczekiwany zysk z całego portfela wyniesie co najmniej 15%.
% Warunki: Suma udziałów musi wynosić 1 (100% kapitału), udziały nie mogą być ujemne (brak krótkiej sprzedaży).

%% DANE WEJŚCIOWE
% Oczekiwane zwroty dla spółek A, B, C
r = [0.10; 0.20; 0.15]; 

% Macierz kowariancji (ryzyko współzależne)
Cov = [0.1,  0.02, 0.04; 
       0.02, 0.2,  0.06; 
       0.04, 0.06, 0.15];

%% 1. DEFINICJA FUNKCJI CELU
% Funkcja celu w quadprog to: min 0.5 * x' * H * x + f' * x
% W modelu Markowitza minimalizujemy wariancję portfela: x' * Cov * x

% ZADANIE 1: Zdefiniuj macierz H oraz wektor f.
% Uwaga: Skoro we wzorze jest 0.5, a my chcemy zminimalizować całą wariancję...
% (Albo przyjmijmy konwencję, że minimalizujemy 1/2 wariancji - wtedy H = Cov)
H = [0.1,  0.02, 0.04; 
       0.02, 0.2,  0.06; 
       0.04, 0.06, 0.15];
f = [0; 0; 0]; 

%% 2. OGRANICZENIA
% ZADANIE 2: Zdefiniuj ograniczenie na minimalny zwrot (r_portfela >= 15%)
% Pamiętaj: quadprog obsługuje nierówności w postaci A*x <= b.
% Musisz przekształcić r*x >= 0.15 na postać mniejszą/równą.
target_return = 0.15;
A = -[0.10, 0.20, 0.15]; 
b = -target_return;

% ZADANIE 3: Zdefiniuj ograniczenie budżetowe (Suma wag = 100%)
% Postać Aeq * x = beq
Aeq = [1, 1, 1];
beq = 1;

% Ograniczenia brzegowe (brak krótkiej sprzedaży: x >= 0)
lb = [0; 0; 0];
ub = [1; 1; 1];

%% 3. KONFIGURACJA I ROZWIĄZANIE
% Wybieramy algorytm active-set (metoda zbiorów aktywnych)
options = optimoptions('quadprog', 'Algorithm', 'active-set', 'Display', 'iter');

% ZADANIE 4: Metoda active-set WYMAGA punktu startowego x0.
% Zdefiniuj dowolny punkt startowy (np. równy podział kapitału).
x0 = [0; 0; 0]; 

% Wywołanie funkcji quadprog
disp('Rozpoczynam optymalizację...');

% Odkomentuj poniższą linię i uzupełnij brakujące argumenty
[x, fval, exitflag] = quadprog(H, f, A, b, Aeq, beq, lb, ub, x0, options);

%% 4. WYNIKI
if exist('x', 'var')
    fprintf('\n--- WYNIKI OPTYMALIZACJI ---\n');
    fprintf('Udział w Spółce A: %.2f%%\n', x(1)*100);
    fprintf('Udział w Spółce B: %.2f%%\n', x(2)*100);
    fprintf('Udział w Spółce C: %.2f%%\n', x(3)*100);
    
    port_return = r' * x;
    port_risk = sqrt(x' * Cov * x); % Odchylenie standardowe
    fprintf('Oczekiwany zwrot portfela: %.2f%%\n', port_return*100);
    fprintf('Ryzyko portfela (std dev): %.4f\n', port_risk);
else
    disp('Kod nie został jeszcze uruchomiony poprawnie.');
end