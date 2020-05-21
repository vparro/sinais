function [s,xp] = VozAjuste(x,y,k)
% x - vetor tempo; y - vetor de dados, b - condições iniciais
% k - fase

yu = max(y);
yl = min(y);
yr = (yu-yl);                                                                % Range of ?y?
yz = y-yu+(yr/2);
zx = x(yz .* circshift(yz,[0 1]) <= 0);                                      % Find zero-crossings
per = 2*mean(diff(zx));                                                      % Estimate period
ym = mean(y);                                                                % Estimate offset
fit = @(b,x)  b(1)*(exp(-b(2)*x).*sin(2*pi*b(3)*x)+exp(-b(4)*x).*sin(2*pi*b(5)*x));                  % Function to fit
fcn = @(b) sum((fit(b,x)' - y.^2));                                           % Least-Squares cost function
s = fminsearch(fcn, [0 0 0 0 0])                                             % Minimise Least-Squares
xp = linspace(min(x),max(x));

end