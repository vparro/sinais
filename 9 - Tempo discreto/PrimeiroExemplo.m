%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 0 - Sintese de uma série temporal a partir de G(z) %% %%  Z --> tempo %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1 - Preparação do código %% %% Boas práticas: limpeza de variáveis; variáveis globais%% Constantes; carregar bibliotecas;...%%%%% Limpezaclc;          % limpa visual da tela de comandosclose all;    % limpa as figurasclear all;    % limpa as variáveis%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 2 - Função em Z%% %%%%%  G(z) --> Numerador   = z * sin(wT)%%%  G(z) --> Denominador = z^2 - 2z * cos(wT) + 1%%% Escolha dos parâmetros: w e TT   = 1;            % amostragem de 1 segundof   = 1/T;          % frequência de amostragemfmax= f/2;          % frequência máxima que o sinal pode operarfreq= fmax/100;      % escolhi uma frequência inferior a fmax w   = 2*pi*freq;    % frequência angular do sinalwT  = w*T;          % produto wTn1  = sin(wT);      % parâmetro fixo do numeradord1  = cos(wT);      % parâmetro fixo do denominador%%%  G(z) --> Numerador   = z * n1%%%  G(z) --> Denominador = z^2 - 2z * d1 + 1%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3 - Criação de um simulador temporal a partir de G(z)%% %% y(k) = -2*d1*y(k-1) + y(k-2) - n1*x(k-1)%%% entrada x(k) --> impulsoxk   = [1 zeros(1,100) ];Nk   = length(xk);%%% Recursiva a equação y(k)%%   y(0)  = -2*d1*y(-1) + y(-2) - n1*x(-1)%   y(1)  = -2*d1*y(0) + y(-1) - n1*x(0)%   y(2)  = -2*d1*y(1) + y(0) - n1*x(1) <--%   y(3)  = -2*d1*y(2) + y(1) - n1*x(2)%%% Valor inicial das variáveis%%% y(k-1) = ya%%% y(k-2) = y2a%%% x(k-1) = xaxa     = 0;ya     = 0;y2a    = 0; for k = 0 : Nk-2     y(k+1) = 1.9021*ya - y2a + 0.30902*xa;      %%% Série temporal --> 2*d1, -1, n1      %%% atualizar as variáveis com a passagem de tempo      xa     = xk(k+1);   y2a    = ya;   ya     = y(k+1);    end%%% Visualizar a série temporalstem(y)