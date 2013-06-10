function [sigma_vm] = VonMises(sigma_z, tau_zs)
sigma_vm = sqrt(sigma_z^2 + 6*(tau_zs^2));
end