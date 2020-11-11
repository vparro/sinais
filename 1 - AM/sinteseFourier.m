function [tempo,sinal] = sinteseFourier (sintese)
  
%%% Vetor tempo para visualização do sinal
%%% diferente da variável simbólica t
%%% para efeito de organização da solução
%%% existem outros caminhos

 M  = sintese.pontos;
 NP = sintese.periodos;
 To = sintese.periodo;
 Dn = sintese.Dn;
 N  = sintese.N;
 
%%% Calculados
 
 Ts = To/M;
 wo = 2*pi/To;
 tempo = [0:Ts:NP*To];            % Tempo de simulação de um período do sinal s(t)
 
%% Sintetizando o sinal - s(t)

n=[-N:1:N];
aux  = 0;             

for k = 0 : 2*N      
  aux = aux + Dn(k+1)*exp(j*n(k+1)*wo*tempo);
end

for k = 0 : 2*N      
  
  aux = aux + Dn(k+1)*exp(j*n(k+1)*wo*tempo);
  
end

sinal = aux;


endfunction
