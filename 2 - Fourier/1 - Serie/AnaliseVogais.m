%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 0 - Proposta %% %%  a. implementar a série discreta%%  Xn = 1/N somatoria_{k=0}^{N-1} gk(k) exp(-j*n*k*2*pi/N)%%  b. visualizar graficamente%%  c. interpretar o resultado%%  d. comparar com tempo%%%%%%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1 - Preparação do código %% %% Boas práticas: limpeza de variáveis; variáveis globais%% Constantes; carregar bibliotecas;...%%%%% Limpezaclc;          % limpa visual da tela de comandosclose all;    % limpa as figurasclear all;    % limpa as variáveis%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 2 - Sinal: calibração e sinal real%%%% trabalhar com um sinal amostrado%% %%% sinal artificial de referência - calibrar o Fourier nas mesmas condições%%%% criar um senoide artificial: amplitude - Ap, frequência - fo e fase - theta%% %%   sinal = Ap * cos (2 * pi * fo * t + theta)%%% recuperar o sinal a partir de um arquivo - real[gk,fs] = audioread ('a.wav');       % transformei um arquivo .wav em um vetor g(k)                                     % recuperei a taxa de amostragem - fs%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  3 - Pré - processamento%%%%%%  Xn = 1/N somatoria_{k=0}^{N-1} gk(k) exp(-j*n*k*2*pi/N)N       = length(gk);               % número de pontos do sinal em análiseTs      = 1/fs;                     % tempo de amostragemws      = 2*pi*fs;                  % frequência anngularduracao = N*Ts;                     % Duração do sinaltempo   = linspace(0,N*Ts,N);       % vetor tempo computacionalfmax    = fs/2;                     % frequência máxima de amostragemfrequencia = linspace(-fs/2,fs/2,N);% vetor de frequências de Fourierresolucao  = fs/N;                  % resoluÇào em frequência%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  4 - Fourier%%%%%%  Xn = 1/N somatoria_{k=0}^{N-1} gk(k) exp(-j*n*k*2*pi/N)                                         %%% estrutura matricial - sem o auxílio do fortic;                                % inicia um contador%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%WN              = exp(-j*2*pi/N);                 % determina o elemento base da matrizMatriz_J        = WN * ones(N,N);                 % cria uma matriz de elementos fixosMatriz_nk       = [0:1:N-1]'*[0:1:N-1];           % cria a amtriz nk dos expoentesMatriz_Fourier  = Matriz_J.^Matriz_nk;            % Matriz de Fourier - fixaXnM             = Matriz_Fourier*gk';             % o sinal no domínio da frequênciaXnM             = fftshift(XnM/N);                % rotaciona o resultado de Fourier%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%toc;  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  5 -  Visualização%%%%figure(2)plot(tempo,gk,'k-','linewidth',3)     % configura plot(x,y, cor azul e linha cheia)xlabel('Tempo em segundos')           % tempo em segundosylabel('Amplitude')                   % amplitude em voltstitle('Sinal g(k) amostrado')         % títulogridfigure(3)stem(frequencia,abs(Xn),'k-','linewidth',3)                % configura plot(x,y, cor azul e linha cheia)xlabel('Frequência em Hz')                                 % tempo em segundosylabel('Amplitude')                                        % amplitude em voltstitle('Espectro de amplitude')                             % títulogridfigure(4)stem(frequencia,abs(XnM),'k-','linewidth',3)                % configura plot(x,y, cor azul e linha cheia)xlabel('Frequência em Hz')                                  % tempo em segundosylabel('Amplitude')                                         % amplitude em voltstitle('Espectro de amplitude')                              % títulogrid