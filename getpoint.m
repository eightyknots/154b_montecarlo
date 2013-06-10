function [y] = getpoint(x,input,c)

t = .12; % 12%C max thickness
p = .40; % 40%C max thickness location
m = .02; % 2% max camber

y_t = t/0.2*(.2969*sqrt(x)-0.1260*x-0.3516*x^2+.2843*x^3-0.1015*x^4);
if x <= p*100
    y_c = m/p^2*(2*p*x-x^2);
else
    y_c = m/(1-p)^2*((1-2*p)+2*p*x-x^2);
end

if strcmp(input,'top') == 1
    y = y_c+y_t;
elseif strcmp(input,'bot') == 1
    y = y_c-y_t;
elseif strcmp(input,'mid') == 1
    y = y_c;
end

y = y*c;

end