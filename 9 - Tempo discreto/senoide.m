function [xa,y,ya,ya2] = senoide(x,xa,ya,ya2)
% Execcuta a transformada Z de um sinal harmônico

y =  2*x - 1.9021*xa + 1.9021*ya -ya2;

% atualiza as variáveis

ya2 = ya;
ya = y;
xa = x;

end

