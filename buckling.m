function [L] = buckling(sigma_zz,area_stringer,E,I_xxstringer,I_yystringer,I_xystringer)
%% Compressive Beam Buckling

I_p = 1/2*(I_xxstringer + I_yystringer) - 1/2*sqrt((I_xxstringer - I_yystringer)^2 + 4*I_xystringer^2);% Moment of Inertia of Stringer
P_cr = 1.5*sigma_zz*area_stringer; %Pcr with safety factor included
L = sqrt(pi^2*E*I_yystringer/P_cr); % Length between ribs
end
