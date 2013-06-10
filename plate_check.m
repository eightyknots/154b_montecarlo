function[platefail,N_cr] = plate_check(E,t,v,L,sigma_zz,max_top_str_dist)
N_cr = platecheck(E,t,v,L,max_top_str_dist);
platefail = 0;
N_cr = N_cr/t;
if N_cr < sigma_zz
    platefail = 1;
end 
end
