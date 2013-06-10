function [sig_str,sig_spar,sig_cap,sig_skin] ...
    = sigma(Ixx,Iyy,Ixy,Mx,My,str_areas,spar_areas,cap_areas,skin_areas,cent)
    
    x_cent = cent(1);
    y_cent = cent(2);

    % Stress at stringer locations
    sig_str = zeros(length(str_areas(:,1)),3);
    for i = 1:length(str_areas(:,1))
        x = str_areas(i,1)-x_cent;
        sig_str(i,1) = x+x_cent;
        y = str_areas(i,2)-y_cent;
        sig_str(i,2) = y+y_cent;
        sig_str(i,3) = (Ixx*My-Ixy*Mx)/(Iyy*Ixx-Ixy^2)*x+(Iyy*Mx-Ixy*My)/(Iyy*Ixx-Ixy^2)*y;
    end

    % Stress at spar locations
    sig_spar = zeros(length(spar_areas(:,1)),3);
    for i = 1:length(spar_areas(:,1))
        x = spar_areas(i,1)-x_cent;
        sig_spar(i,1) = x+x_cent;
        y = spar_areas(i,2)-y_cent;
        sig_spar(i,2) = y+y_cent;
        sig_spar(i,3) = (Ixx*My-Ixy*Mx)/(Iyy*Ixx-Ixy^2)*x+(Iyy*Mx-Ixy*My)/(Iyy*Ixx-Ixy^2)*y;
    end
    
    % Stress at spar cap locations
    sig_cap = zeros(length(cap_areas(:,1)),3);
    for i = 1:length(cap_areas(:,1))
        x = cap_areas(i,1)-x_cent;
        sig_cap(i,1) = x+x_cent;
        y = cap_areas(i,2)-y_cent;
        sig_cap(i,2) = y+y_cent;
        sig_cap(i,3) = (Ixx*My-Ixy*Mx)/(Iyy*Ixx-Ixy^2)*x+(Iyy*Mx-Ixy*My)/(Iyy*Ixx-Ixy^2)*y;
    end
    
    % Stress at skin segment locations
    sig_skin = zeros(length(skin_areas(:,1)),3);
    for i = 1: length(skin_areas(:,1))
        x = skin_areas(i,1)-x_cent;
        sig_skin(i,1) = x+x_cent;
        y = skin_areas(i,2)-y_cent;
        sig_skin(i,2) = y+y_cent;
        sig_skin(i,3) = (Ixx*My-Ixy*Mx)/(Iyy*Ixx-Ixy^2)*x+(Iyy*Mx-Ixy*My)/(Iyy*Ixx-Ixy^2)*y;
    end
end