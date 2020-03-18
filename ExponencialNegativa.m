%% Exponencial Negativa

clear all;
clc;
close all;
pkg load symbolic;

%% Definindo o sinal a ser estudado

 gt1 = @(t) (1-exp(-t));
 gt2 = @(t) (exp(-(t-0.5)) - exp(-0.5));
 To = 1;
 fo = inv(To);
 wo = 2*pi*fo;
 T1 = 0.5;
 T2 = 1.0;
 N = 10;
 n=[-N:1:N];
 f = n*fo;

%%% Vetor tempo para visualização do sinal
%%% diferente da variável simbólica t
%%% para efeito de organização da solução
%%% existem outros caminhos

 M = 1000;
 Ts = To/M;
 tempo1 = [0:Ts:T1];                         % Três períodos do sinal
 tempo2 = [0.5:Ts:T2];                       % Modifica ao vetor tempo
 tempo  = [0:Ts:To];                         % tempo para sintese - 1 período
 
%% Visualizando o sinal gt completo

figure(1)

plot(tempo1,gt1(tempo1),tempo2,gt2(tempo2))
title('Sinal g(t)')
xlabel('Tempo em segundos')
ylabel('Amplitude em volts')

%% Determinando o valor médio

syms n t

D_o = inv(To)*int(gt1,t,0,T1) + inv(To)*int(gt2,t,T1,T2);
Dn1 = inv(To)*int(gt1.*exp(-j*n*wo*t),t,0,T1);
Dn2 = inv(To)*int(gt2.*exp(-j*n*wo*t),t,T1,To);


%% Determinando valores numéricos

n = [[-N:1:-1] [1:1:N]];
Dn1 = eval(Dn1);
Dn2 = eval(Dn2);

Dn =  Dn1+Dn2;
D_o = eval(D_o);
Dn = [Dn(1:N) D_o Dn(N+1:2*N)];


%% Visualizando o espector de Amplitude
 
figure(2) 
stem(f,abs(Dn)); 
title('Série de Fourier do sinal g(t)');
xlabel('Frequência em Hz');
ylabel('Amplitude em  volts')

%% Sintetizando o sinal

n=[-N:1:N];
aux  = 0;             


for k = 0 : 2*N      
  
  aux = aux + Dn(k+1)*exp(j*n(k+1)*wo*tempo);
  
end

gr = aux;

%% Visualizando o sinal reconstruido

figure(3)
plot(tempo1,gt1(tempo1),tempo2,gt2(tempo2),tempo,gr)
% plot(tempo,gr)
title('Reconstrução do sinal g(t)');
xlabel('Tempo em segundos');
ylabel('Amplitude em  volts')

%% Determinando a potência do sinal g(t)

f1 = @(t) (1-2*exp(-t)+exp(-2*t));
f2 = @(t) (exp(-(t-0.5)) - exp(-0.5))^2;


Pg1 = inv(To)*int(f1,t,0,0.5) 
Pg2 = inv(To)*int(f2,t,0.5,1)
Pg = eval(Pg1+Pg2)

%%% Verifica a potência pelo teorema de Paserval

PN = cumsum([abs(D_o)^2 2*abs(Dn(N+2:end)).^2])


figure(4)
plot(f(N+1:end),PN,f(N+1:end),ones(1,N+1)*Pg)
title('Potência total e em função do harmônico');
xlabel('Harmônico');
ylabel('Potência em W')


 


  

