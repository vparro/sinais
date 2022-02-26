<<<<<<< HEAD
%% Copyright (C) 2020 1
%% 
%% This program is free software: you can redistribute it and/or modify it
%% under the terms of the GNU General Public License as published by
%% the Free Software Foundation, either version 3 of the License, or
%% (at your option) any later version.
%% 
%% This program is distributed in the hope that it will be useful, but
%% WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%% GNU General Public License for more details.
%% 
%% You should have received a copy of the GNU General Public License
%% along with this program.  If not, see
%% <https://www.gnu.org/licenses/>.

%% -*- texinfo -*- 
%% @deftypefn {} {@var{retval} =} sinteseFourier (@var{input1}, @var{input2})
%%
%% @seealso{}
%% @end deftypefn

%% Author: 1 <a1@MacBook-Pro-de-1.local>
%% Created: 2020-04-11

function  [D_o,Dn,f,Pg,PN] = sFourier(sinal)

% pkg load symbolic;         % somente para quem usa Octave
warning ("off");

A = sinal.tipo              % Seleciona o tipo de sinal

switch A
  case {"quadrada"}
    disp("Sinal quadrado");
    
%%%%%%
%% Definindo o sinal a ser estudado
%% Ona pulsada de dois níveis, período To e largura tau

A1  = sinal.Ap;                       % Amplitude em nível alto
A2  = sinal.An;                       % Amplitude em nível baixo
tau = sinal.largura;                  % Duração em nível alto
To  = sinal.periodo;                  % Período
N   = sinal.harmonicas;               % Número de harmônicas para análise

%%% Valores calculados

 fo = inv(To);            % frequência em Hz
 wo = 2*pi*fo;            % frequência angular
 n=[-N:1:N];              % índice de cada harmônica
 f = n*fo;                % vetor de frequências da análise de Fourier
 
%% Determinando o termo Dn simbolicamente

syms n t

Dn = inv(To)*int(A1*exp(-j*n*wo*t),t,0,tau) + inv(To)*int(A2*exp(-j*n*wo*t),t,tau,To);
D_o = inv(To)*int(A1,t,0,tau) + inv(To)*int(A2,t,tau,To);

%% Determinando o termo Dn numericamente

% Dn = a tau sin(n wo tau/2) / (n wo tau/2)
% n = 0 D0 = a tau 0/0 (!) --> NaN

n=[-N:1:N];
 
Dn = eval(Dn);
D_o = eval(D_o);      % Corrigindo o valor médio (NaN devido a indeterminação)
Dn(N+1) = D_o;       % Subistituindo no vetor de respostas

%% Determinando a Potência do sinal do tempo

Pg = inv(To)*int(A1^2,t,0,tau) + inv(To)*int(A2^2,t,tau,To);
Pg = eval(Pg);

%% Verifica a potência pelo teorema de Paserval

PN = cumsum([Dn(N+1)^2 2*abs(Dn(N+2:end)).^2]);

%%%%%%    
    
  case {"AMquadrada"}    
    disp("AMquadrada");
    
    %%%%%%
%% Definindo o sinal a ser estudado
%% Ona pulsada de dois níveis, período To e largura tau

A1  = sinal.Ap;                       % Amplitude em nível alto
A2  = sinal.An;                       % Amplitude em nível baixo
tau = sinal.largura;                  % Duração em nível alto
To  = sinal.periodo;                  % Período
N   = sinal.harmonicas;               % Número de harmônicas para análise
wc  = sinal.portadora;                % Frequência da portadora

%%% Valores calculados

 fo = inv(To);            % frequência em Hz
 wo = 2*pi*fo;            % frequência angular
 n=[-N:1:N];              % índice de cada harmônica
 f = n*fo;                % vetor de frequências da análise de Fourier
 
%% Determinando o termo Dn simbolicamente

syms n t

Dn1 = inv(To)*int(A1*exp(-j*n*wo*t).*cos(wc*t),t,0,tau); 
Dn2 = inv(To)*int(A2*exp(-j*n*wo*t).*cos(wc*t),t,tau,To);
Dn  = Dn1 + Dn2;
D_o1 = inv(To)*int(A1*cos(wc*t),t,0,tau); 
D_o2 = inv(To)*int(A2*cos(wc*t),t,tau,To);
D_o  = D_o1 + D_o2;

%% Determinando o termo Dn numericamente

% Dn = a tau sin(n wo tau/2) / (n wo tau/2)
% n = 0 D0 = a tau 0/0 (!) --> NaN

n=[-N:1:N];              % índice de cada harmônica
 
Dn = eval(Dn);
D_o = eval(D_o);     % Corrigindo o valor médio (NaN devido a indeterminação)
Dn(N+1) = D_o;       % Subistituindo no vetor de respostas

%% Determinando a Potência do sinal do tempo

Pg1 = inv(To)*int((A1*cos(wc*t))^2,t,0,tau);
Pg2 = inv(To)*int((A2*cos(wc*t))^2,t,tau,To);
Pg  = Pg1 + Pg2;
Pg = eval(Pg);

%% Verifica a potência pelo teorema de Paserval


PN = cumsum([Dn(N+1)^2 2*abs(Dn(N+2:end)).^2]);

%%%%%% 

  case {"demodulado"}
    disp("demodulado");
    
%%%%%%
%% Definindo o sinal a ser estudado
%% Ona pulsada de dois níveis, período To e largura tau

A1  = sinal.Ap;                       % Amplitude em nível alto
A2  = sinal.An;                       % Amplitude em nível baixo
tau = sinal.largura;                  % Duração em nível alto
To  = sinal.periodo;                  % Período
N   = sinal.harmonicas;               % Número de harmônicas para análise
wc  = sinal.portadora;                % Frequência da portadora

%%% Valores calculados

 fo = inv(To);            % frequência em Hz
 wo = 2*pi*fo;            % frequência angular
 n=[-N:1:N];              % índice de cada harmônica
 f = n*fo;                % vetor de frequências da análise de Fourier
 
%% Determinando o termo Dn simbolicamente

syms n t

Dn1 = inv(To)*int(sqrt((A1*cos(wc*t))^2).*exp(-j*n*wo*t),t,0,tau); 
Dn2 = inv(To)*int(sqrt((A2*cos(wc*t))^2).*exp(-j*n*wo*t),t,tau,To);
Dn  = Dn1 + Dn2;
D_o1 = inv(To)*int(abs(A1*cos(wc*t)),t,0,tau); 
D_o2 = inv(To)*int(abs(A2*cos(wc*t)),t,tau,To);
D_o  = D_o1 + D_o2;

%% Determinando o termo Dn numericamente

% Dn = a tau sin(n wo tau/2) / (n wo tau/2)
% n = 0 D0 = a tau 0/0 (!) --> NaN

n=[-N:1:N];              % índice de cada harmônica
 
Dn = eval(Dn);
D_o = eval(D_o);     % Corrigindo o valor médio (NaN devido a indeterminação)
Dn(N+1) = D_o;       % Subistituindo no vetor de respostas

%% Determinando a Potência do sinal do tempo

Pg1 = inv(To)*int((A1*cos(wc*t))^2,t,0,tau);
Pg2 = inv(To)*int((A2*cos(wc*t))^2,t,tau,To);
Pg  = Pg1 + Pg2;
Pg = eval(Pg);

%% Verifica a potência pelo teorema de Paserval


PN = cumsum([Dn(N+1)^2 2*abs(Dn(N+2:end)).^2]);

%%%%%%
  case {"outroTipo"}
    disp("outroTipo");             
  otherwise
    disp("sinal não definido");
endswitch


end
=======
## Copyright (C) 2020 1## ## This program is free software: you can redistribute it and/or modify it## under the terms of the GNU General Public License as published by## the Free Software Foundation, either version 3 of the License, or## (at your option) any later version.## ## This program is distributed in the hope that it will be useful, but## WITHOUT ANY WARRANTY; without even the implied warranty of## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the## GNU General Public License for more details.## ## You should have received a copy of the GNU General Public License## along with this program.  If not, see## <https://www.gnu.org/licenses/>.## -*- texinfo -*- ## @deftypefn {} {@var{retval} =} sinteseFourier (@var{input1}, @var{input2})#### @seealso{}## @end deftypefn## Author: 1 <a1@MacBook-Pro-de-1.local>## Created: 2020-04-11function  [D_o,Dn,f,Pg,PN] = sFourier(sinal)pkg load symbolic;         % somente para quem usa Octavewarning ("off");A = sinal.tipo             % Seleciona o tipo de sinalswitch A  case {"quadrada"}    disp("Sinal quadrado");    %%%%%%%% Definindo o sinal a ser estudado%% Ona pulsada de dois níveis, período To e largura tauA1  = sinal.Ap;                       % Amplitude em nível altoA2  = sinal.An;                       % Amplitude em nível baixotau = sinal.largura;                  % Duração em nível altoTo  = sinal.periodo;                  % PeríodoN   = sinal.harmonicas;               % Número de harmônicas para análise%%% Valores calculados fo = inv(To);            % frequência em Hz wo = 2*pi*fo;            % frequência angular N = 10;                  % Número de harmônicas da análise n=[-N:1:N];              % índice de cada harmônica f = n*fo;                % vetor de frequências da análise de Fourier %% Determinando o termo Dn simbolicamentesyms n tDn = inv(To)*int(A1*exp(-j*n*wo*t),t,0,tau) + inv(To)*int(A2*exp(-j*n*wo*t),t,tau,To);D_o = inv(To)*int(A1,t,0,tau) + inv(To)*int(A2,t,tau,To);%% Determinando o termo Dn numericamente% Dn = a tau sin(n wo tau/2) / (n wo tau/2)% n = 0 D0 = a tau 0/0 (!) --> NaNn=[-N:1:N]; Dn = eval(Dn);D_o = eval(D_o);      % Corrigindo o valor médio (NaN devido a indeterminação)Dn(N+1) = D_o;       % Subistituindo no vetor de respostas%% Determinando a Potência do sinal do tempoPg = inv(To)*int(A1^2,t,0,tau) + inv(To)*int(A2^2,t,tau,To);Pg = eval(Pg);%% Verifica a potência pelo teorema de PaservalPN = cumsum([Dn(N+1)^2 2*abs(Dn(N+2:end)).^2]);%%%%%%          case {"exponencial"}    disp("exponencial");  case {"triangular"}    disp("triangular");  case {"outroTipo"}    disp("outroTipo");               otherwise    disp("sinal não definido");endswitch
endfunction
>>>>>>> 34f90e00111b138cc89f9626e434beb646c23769
