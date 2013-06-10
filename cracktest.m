function [crackfail,N_f] = cracktest(sigma_0,t)
[a_c,N_f,K] = crack(sigma_0,t);
crackfail = 0;
if N_f < 1e6
    crackfail = 1;
end 
end