function[Ncr] = platecheck(E,t,v,L,max_top_str_dist)
%% Compressive Plate Buckling
a = max_top_str_dist;
b = L;
D = E*t^3/(12*(1-v^2));
k = (b/a+a/b)^2;
Ncr = k*pi^2*D/(b^2);
end