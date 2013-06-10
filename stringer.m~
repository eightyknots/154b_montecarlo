function[area_stringer,I_xxstringer,I_yystringer,I_xystringer] = stringer(b,h,t)

I_xxstringer = 2*b*t*(h/2)^2 + 2/12*t^3*b +t/12*h^3; % Ixx of stringer
I_yystringer = 2*b*t*(b/2)^2 + 2/12*t*b^3 +t^3*h/12; % Iyy of stringer
I_xystringer = b^2*h*t/2; %Ixy of stringer
area_stringer = 2*b*t + h*t; % area of stringer

end