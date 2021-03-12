%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1 - Preparação do código %% %% Boas práticas: limpeza de variáveis; variáveis globais%% Constantes; carregar bibliotecas;...%%%%% Limpezaclc;          % limpa visual da tela de comandosclose all;    % limpa as figurasclear all;    % limpa as variáveis%%% Carregar bibliotecaspkg load symbolic;  % biblioteca simbólica%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  2 - calcular o valor de c%% %%  Ambiente de cálculo integral e simbólico%%  %%  Symbolic pkg v2.9.0: %%  Python communication link active, SymPy v1.5.1.%%syms Ap An to To t  % t - tempo variável simbólica%%% numerador de cIp    = int(Ap*cos(t),t,to,to+To/2);In    = int(An*cos(t),t,to+To/2,to+To);Inum  = Ip + In; %%% denominador de c  Iden  = int(cos(t)*cos(t),t,0,To);%%% determinando cc = Inum/Iden;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3 - Problema%%%% aproximar uma onda quadrada por um sinal%% harmônico - g(t) = c. cos(t) + erro%% %% Definir a onda quadradaAp = +1;    % amplitude positiva de g(t)An = -1;    % amplitude negativa de g(t)To = 2*pi;  % período da onda quadradato = -pi/2; % instante inicial de g(t)%%% Parâmetros calculadosfo = 1/To;    % frequência da onda quadradawo = 2*pi*fo; % frequência angular de g(t)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  