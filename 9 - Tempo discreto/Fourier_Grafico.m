## Copyright (C) 2021 1
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
## @deftypefn {} {@var{retval} =} Fourier_Grafico (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: 1 <a1@MacBook-Pro-de-1.local>
## Created: 2021-10-06

function retval = Fourier_Grafico (gk, fs, Nf)
  
%%% Determinar a transformada discreta de Fourier

Gw = fft(gk);

%%% Para mostrar o espectro bilateral -fs/2 (-pi) <--> fs/2 (+pi)
%%
%%% O comando fftshift desloca de 0Hz (0) --> fs (2pi)

%%% Criar o eixo frequência

Np   = length(gk);
ws   = 2*pi*fs;
w    = linspace(-ws/2,+ws/2, Np);
freq = w/(2*pi);

%%% Determina o módulo

Gw_m = fftshift(abs(Gw));

%%% Determina a fase

Gw_f = fftshift(angle(Gw))*180/pi;

%%% Visualizando os resultados

figure(Nf)

subplot(2,1,1)
plot(freq,Gw_m);
title('Resposta em frequencia')
xlabel('Frequencia em Hz');
ylabel('Magnitude');

%%% Zoom em uma região de interesse

%axis ([-5000 +5000])
axis ([-fs/2 +fs/2])

%%% Ajuste do gráfico

set(findall(gcf,'Type','line'),'LineWidth',3);
set(gca,'FontSize',14,'LineWidth',2);
 

subplot(2,1,2)
plot(freq,Gw_f);
title('Resposta em frequencia')
xlabel('Frequencia em Hz');
ylabel('Fase em graus');

%%% Zoom em uma região de interesse

% axis ([-5000 +5000])
axis ([-fs/2 +fs/2])

%%% Ajuste do gráfico

set(findall(gcf,'Type','line'),'LineWidth',3);
set(gca,'FontSize',14,'LineWidth',2);

retval = [];

endfunction
