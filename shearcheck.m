function [shearfail,N_cr] = shearcheck(E,t,v,L,shear_max,max_str_dist)
N_cr = shear_buckling(E,t,v,L,max_str_dist);
shearfail = 0;
N_cr = N_cr/t;
if N_cr < shear_max
    shearfail = 1;
end
end
    