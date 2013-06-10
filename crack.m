function [a_c,N_f,K] = crack(sigma_0,t)
sigma_0 = sigma_0*1.5; % Safety factor
m = 2.85;
C = 10^-12;
K_1c = 29e6; %MPa*m*0.5
Y = 1.12;
a_0 = 30e-6;%3*t/2+20e-6;
K = Y*sigma_0*sqrt(pi*a_0); 
a_c = (K_1c/(Y*sigma_0))^2/pi; %Critical Crack Length
N_f = (a_c^(1-m/2)-a_0^(1-m-2))/(C*(1-m/2)*(1.12*sigma_0*sqrt(pi))^m);
end
