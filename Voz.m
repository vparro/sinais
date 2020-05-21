%% Análise de sinais de voz


%%% Incia o ambiente matlab para uma sessão de análises

clear; clc; close all;

%%% Carrega o trabalho feito anteriormente e gravado no arquivo Voz.mat

load('Voz.mat') 

%%% Vissualizando o material que temos

figure(1) % Cria uma figura para a análise temporal

plot(t,Vp);
title('Sinal de voz para a vogal a');
xlabel('Tempo em us');
ylabel('Tensão em Volts'); 
grid minor

%%% modifica parâmteros do gráfico

set(findall(gcf,'Type','line'),'LineWidth',3);
set(gca,'FontSize',14,'LineWidth',2);

figure(2) % Cria uma figura para a análise em frequência

plot(frequencia,Y0);
title('Espectro de amplitude da vogal a');
xlabel('Frequência em Hz');
ylabel('Magnitude em dB'); 
grid minor

%%% modifica parâmteros do gráfico

set(findall(gcf,'Type','line'),'LineWidth',3);
set(gca,'FontSize',14,'LineWidth',2);

%%% Analisando os parâmteros graficamente

ti = 0.001126;  % começo do primeiro período inteiro
tf = 0.09537;   % fim do último período inteiro

T = (tf-ti)/13; % valor médio dentre os 13 períodos
f = inv(T);     % frequência associada a vibração gerada

figure(3)

findpeaks(Vp,t,'MinPeakDistance',0.001);

[vt,tp]=findpeaks(Vp,t,'MinPeakDistance',0.001);

Tm =mean(diff(tp));

title('Sinal de voz para a vogal a');
xlabel('Tempo em us');
ylabel('Tensão em Volts'); 
grid minor

figure(4)

findpeaks(Y0,frequencia,'MinPeakDistance',0.9*f);

title('Espectro de amplitude da vogal a');
xlabel('Frequência em Hz');
ylabel('Magnitude em dB'); 
grid minor

[Md,fp]=findpeaks(Y0,frequencia,'MinPeakDistance',0.9*f);


%%% Harmônicas

H(1) = 130;
H(2) = 270;
H(3) = 400;
H(4) = 540;
H(5) = 670;
H(6) = 800;
H(7) = 940;
H(8) = 1070;

delta  =  diff(H);

%%% Valor médio da harmônica

Hm = mean(delta);

%%%% Formantes

FRM(1) = 670;
FRM(2) = 1480;
FRM(3) = 2700;




