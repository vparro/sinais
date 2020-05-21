## Copyright (C) 2020 1
## 
## This program is free software: you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see
## <https://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} sinteseFourier (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: 1 <a1@MacBook-Pro-de-1.local>
## Created: 2020-04-11


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
<<<<<<< HEAD
 
%%% Calculados
 
=======
>>>>>>> 34f90e00111b138cc89f9626e434beb646c23769
 Ts = To/M;
 wo = 2*pi/To;
 tempo = [0:Ts:NP*To];            % Tempo de simulação de um período do sinal s(t)
 
%% Sintetizando o sinal - s(t)

n=[-N:1:N];
aux  = 0;             
<<<<<<< HEAD
for k = 0 : 2*N      
  aux = aux + Dn(k+1)*exp(j*n(k+1)*wo*tempo);
end
=======


for k = 0 : 2*N      
  
  aux = aux + Dn(k+1)*exp(j*n(k+1)*wo*tempo);
  
end

>>>>>>> 34f90e00111b138cc89f9626e434beb646c23769
sinal = aux;


endfunction
