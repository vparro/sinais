%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 0 - Boas práticasclear all;                        % apaga todas as variáveisclose all;                        % fechar as figurasclc;                              % limpa o ambiente de simulação%%% pacotes que contém comandos importantespkg load signal                   % somente para o Octavepkg load control                  % somente para o Octave %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1 - Função de transferência em Z%%% Numerador ==> z^2 - z e^{-aT} cos (wT)%%% Denominador ==>  z^2 - 2 z e^{-aT} cos (wT) +  e^{-2aT}%%% Tempo --> y(t) = e^{-akT} cos(wkT)%%% Parâmetros% 1 -  T : taxa de amostragem% 2 -  w : frequência angular do sinal --> 2 pi f = w% 3 -  a : expoente da exponencial% 4 -  k : índice da amostra%%% Atribuindo valoresNp = 10;           % número de períodosf  = 1;            % sinal tem frequência de 1Hzw  = 2*pi*f;       % frequência angularTo = 1/f;          % período do sinalfs = 50;           % frequência de amostragem acima do mínimo T  = 1/fs;         % período de amostragema  = 1;            % constante de tempo da exponencial (!)k  = [0:1:Np*fs];  % índice de cada amostra (tempo)%%% Modelo matemático no domínio do tempoy  = @(w,T,k,a)   exp(-a*k*T).*cos(w*k*T);%%% gerar o sinal no tempo (discreto e amostrado)yk = y(w,T,k,a) %%% Visualizar o resultadofigure(1)stem(k,yk); title('Sinal amostrado');xlabel('Amostra')ylabel('valor da amostra')grid%%% Qualidade do gráficoset(findall(gcf,'Type','line'),'LineWidth',3);set(gca,'FontSize',14,'LineWidth',2);%%% Modelo matemático da finção no domínio Z - Y(z)%%% Numerador ==> z^2 - z e^{-aT} cos (wT) + 0%%% Denominador ==>  z^2 - 2 z e^{-aT} cos (wT) +  e^{-2aT}N = [1 -exp(-a*T)*cos(w*T) 0];D = [1 -2*exp(-a*T)*cos(w*T) exp(-2*a*T)];Yz = tf(N,D,T);##Transfer function 'Yz' from input 'u1' to output ...####         z^2 + 0.9979 z## y1:  ---------------------##      z^2 - 1.996 z + 0.996####Sampling time: 0.02 s##Discrete-time model.figure(2)%  -- Function File: [X, T] = impz (B, A, N, FS)%%% Sintese do sinal no tempo - sintetizadorimpz(N,D,length(k),fs);%%% Qualidade do gráficoset(findall(gcf,'Type','line'),'LineWidth',3);set(gca,'FontSize',14,'LineWidth',2);%%% O que é importante de Yz%%% 1 - Grau do numerador          : 2%%% 2 - Grau do denominador        : 2%%% 3 - Coeficientes do numerador  : [1 -0.9979 0]%%% 4 - Coeficientes do denominador: [1 -1.9960 0.996]%%% Quantos valores são necessários? 6 valores !!!%%% Conclusão: compactação do número de pontos.%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 2 - Analisando uma vogal - /a/[ak,fs] = audioread ('a.wav'); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3 - Sintetizando o sinal sem o comando impz##>> Yz####Transfer function 'Yz' from input 'u1' to output ...####          1 - 0.9725 z^{-1}              Y(z)## y1:  ------------------------------- = ------##      1 - 1.945 z^{-1} + 0.9608z^{-2}    X(z)####Sampling time: 0.02 s##Discrete-time model.%%% Y(z): saída do sistema%%% X(z): entrada do sistema%%% Anti transformada Z de Y(z) - equação de diferenças%%% y(n) =  1.945 y(n-1) - 0.9608 y(n-2) + x(n) - 0.9725 x(n-1)%%% Gerar a entrada impusilva do sistema - impulso digitalx = [1 zeros(1,length(k)-1)];%%% Valores iniciais das variáveisya  = 0;y2a = 0;xa  = 0;for k = 1 : 500    yk(k) =  1.945*ya - 0.9608*y2a + x(k) - 0.9725*xa;    %% Atualizar as variáveis    y2a  = ya;  ya   = yk(k);  xa   = x(k);  end%%% Visualizar o resultadofigure(3)stem(yk); title('Sinal amostrado');xlabel('Amostra')ylabel('valor da amostra')grid%%% Qualidade do gráficoset(findall(gcf,'Type','line'),'LineWidth',3);set(gca,'FontSize',14,'LineWidth',2);