## Author: 1 <a1@MacBook-Pro-de-1.local>## Created: 2020-04-11function [tempo,sinal] = sinteseFourier (sintese)  %%% Vetor tempo para visualização do sinal%%% diferente da variável simbólica t%%% para efeito de organização da solução%%% existem outros caminhos M  = sintese.pontos; NP = sintese.periodos; To = sintese.periodo; Dn = sintese.Dn; N  = sintese.N; Ts = To/M; wo = 2*pi/To; % Tempo de simulação de um período do sinal s(t) tempo = [0:Ts:NP*To];            