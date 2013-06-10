function [vonmisesfail,sigma_vm] = vonmisescheck(sigma_z,tau_zs)
sigma_vm = VonMises(sigma_z, tau_zs);
criteria_vm = 345/1.25*10^6; %Pa
vonmisesfail = 0;
if sigma_vm > criteria_vm
    vonmisesfail = 1;
end 
end