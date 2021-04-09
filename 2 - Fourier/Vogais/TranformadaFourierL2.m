%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 0 - Boas práticas %% %%%% clear all;clc;close all;pkg load symbolic;                                    % Somente para os que usam                                                       % Octave                                                      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1 - sinais a serem analisados %% %%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% sinal de base g(t) To = 100;                  % período para todos os sinais gp = @(t) 2*t+1;           % reta ascendente gn = @(t) -2*t+1;          % reta decrescente ti = -0.5;                 % tempo inicial tf = +0.5;                 % tempo final  %%% Valores calculados para o primeio pulso fo = inv(To);            % frequência em Hz --> fo  = 0.01Hz wo = 2*pi*fo;            % frequência angular N  = 1000;               % Número de harmônicas da análise                          % -10Hz --> 10Hz - escolha n  =[-N:1:N];            % índice de cada harmônica f  = n*fo;               % vetor de frequências da análise de Fourier%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% sinal derivada g1(t) g1p = @(t) 2;               % constante positiva g1n = @(t) -2;              % constante negativa ti  = -0.5;                 % tempo inicial tf  = +0.5;                 % tempo final%%% Vetor tempo para visualização do sinal%%% diferente da variável simbólica t%%% para efeito de organização da solução%%% existem outros caminhos M = 1000; Ts = To/M; tempo = [-To/10:Ts:To/10];  % Tempo de simulação de um período do sinal g(t) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 2 - Fourier %% %%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% sinal de base g(t) %% Determinando o termo Dn simbolicamente% n simbólicosyms n tDn = inv(To)*int(gp*exp(-j*n*wo*t),t,ti,0) + inv(To)*int(gn*exp(-j*n*wo*t),t,0,tf);D_o = inv(To)*int(gp,t,ti,0) + inv(To)*int(gn,t,0,tf);Dn1 = inv(To)*int(g1p*exp(-j*n*wo*t),t,ti,0) + inv(To)*int(g1n*exp(-j*n*wo*t),t,0,tf);D_o1 = inv(To)*int(g1p,t,ti,0) + inv(To)*int(g1n,t,0,tf);%% Determinando o termo Dn numericamenten=[-N:1:N]; Dn = eval(Dn);D_o = eval(D_o) ;     % Corrigindo o valor médio (NaN devido a indeterminação)Dn(N+1) = D_o ;      % Subistituindo no vetor de respostasDn1 = eval(Dn1);D_o1 = eval(D_o1) ;     % Corrigindo o valor médio (NaN devido a indeterminação)Dn1(N+1) = D_o1 ;      % Subistituindo no vetor de respostas%% Visualizando o espector de Amplitude figure(1) subplot(2,1,1);plot(f,abs(Dn),'ko');title('Serie de Fourier do sinal g(t) -- To = 100s');xlabel('Frequencia em Hz');ylabel('Amplitude em  volts')subplot(2,1,2);plot(f,abs(Dn1),'ko');title('Serie de Fourier do sinal g(t) -- To = 100s');xlabel('Frequencia em Hz');ylabel('Amplitude em  volts')%% Sintetizando o primeiro sinaln=[-N:1:N];aux  = 0; aux1  = 0;             for k = 0 : 2*N         aux = aux + Dn(k+1)*exp(j*n(k+1)*wo*tempo);  aux1 = aux1 + Dn1(k+1)*exp(j*n(k+1)*wo*tempo);  endgs = aux;gs1 = aux1;figure(2)subplot(2,1,1);plot(tempo,gs); title('Serie de Fourier do sinal g(t) To = 100s');xlabel('Tempo em segundos');ylabel('Amplitude em  volts');subplot(2,1,2);plot(tempo,gs1); title('Serie de Fourier do sinal g(t) To = 100s');xlabel('Tempo em segundos');ylabel('Amplitude em  volts');%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3 - Funções de transferência%% %%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%figure(3)subplot(1,2,1);stem(f,abs(Dn1./Dn),'linewidth',3); title('Serie de Fourier do sinal g(t) To = 100s');xlabel('Frequencia em Hz');ylabel('Amplitude em  volts');subplot(1,2,2);stem(f,angle(Dn1./Dn)*180/pi,'linewidth',3); title('Serie de Fourier do sinal g(t) To = 100s');xlabel('Frequencia em Hz');ylabel('Amplitude em  volts');

