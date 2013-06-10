function [N_cr] = shear_buckling(E,t,v,L,max_str_dist)
%% Shear Plate Buckling
a = L;% Distance between ribs
b = max_str_dist; % Max distance between stringers
D = E*t^3/(12*(1-v^2));
k_shear = (b/a+a/b)^2;
N_cr = 10*k_shear*pi^2*D/(b^2);
end