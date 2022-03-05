function [c] = projecao(g1,g2,T0)
% Determina projeção do sinal g1(t) no dinal g2(t)
% retorna o valor da projeção numericamente

%%% Boas práticas

syms t

%%% Numerador

Num = int(g1*g2,t,0,T0);

%%% Denominador

Den = int(g2*g2,t,0,T0);

%%% Projeção simbólica

cn = Num/Den;

%%% Projeção Numérica

c = eval(cn);

end