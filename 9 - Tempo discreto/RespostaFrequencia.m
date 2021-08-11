function Hw  =  RespostaFrequencia(N,fs,Np,T)    %%% Cria N-1 pontos espaçado de 1    n   = [0:1:N-1];    %%% cria o vetor frequência    w   = linspace(-pi*fs,pi*fs,Np);    %%% Inicia a somatória    aux = 0;    %%% Faz a somatória    for k = 1 : N      aux  =  aux  + exp(-j*w*T).^n(k);    end    %%% Apolica o fator  multiplicativo    Hw = aux * (1/N);  
endfunction
