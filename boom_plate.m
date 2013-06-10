function [boom_areas,top_index,rear_index,bot_index] ...
    = boom_plate(sig_skin,sig_cap,fs_loc,c,alum,skin_t,spar_t,cap_areas,str_areas)


d = zeros(length(sig_skin),1);
for p = 1:length(sig_skin)
    if p < length(sig_skin)
        d(p) = sqrt((sig_skin(p+1,1)-sig_skin(p,1))^2+(sig_skin(p+1,2)-sig_skin(p,2))^2);
    else
        d(p) = sqrt((sig_skin(1,1)-sig_skin(p,1))^2+(sig_skin(1,2)-sig_skin(p,2))^2);
    end    
end

boom_areas = zeros(length(sig_skin),3);
for p = 1:length(sig_skin)
    if p == 1
        B_side1 = alum(skin_t)*d(length(sig_skin))/6*(2+sig_skin(length(sig_skin),3)/sig_skin(p,3));
        B_side2 = alum(skin_t)*d(p)/6*(2+sig_skin(p+1,3)/sig_skin(p,3));
    elseif p == length(sig_skin)
        B_side1 = alum(skin_t)*d(p-1)/6*(2+sig_skin(p-1,3)/sig_skin(p,3));
        B_side2 = alum(skin_t)*d(length(sig_skin))/6*(2+sig_skin(1,3)/sig_skin(p,3));
    else     
        B_side1 = alum(skin_t)*d(p-1)/6*(2+sig_skin(p-1,3)/sig_skin(p,3));
        B_side2 = alum(skin_t)*d(p)/6*(2+sig_skin(p+1,3)/sig_skin(p,3));
    end
    boom_areas(p,1:2) = sig_skin(p,1:2);
    boom_areas(p,3) = B_side1 + B_side2; 
end

% Add stringer areas to appropriate locations
stringer = 1;
for i = 1:length(boom_areas)-1
    if boom_areas(i,1) < str_areas(stringer,1) && boom_areas(i+1,1) > str_areas(stringer,1)...
            && abs(boom_areas(i,2)-str_areas(stringer,2)) < 0.05
        if abs(str_areas(stringer,1)-boom_areas(i,1)) < abs(str_areas(stringer,1)-boom_areas(i+1,1))
            boom_areas(i,3) = boom_areas(i,3)+str_areas(stringer,3);
        else
            boom_areas(i+1,3) = boom_areas(i+1,3)+str_areas(stringer,3);
        end
        stringer = stringer+1;
    end
    if stringer > length(str_areas(:,1))
        break;
    end
end

% Add spar cap areas to appropriate locations
% Forward top caps
for i = 1:round(length(boom_areas)/2)
    if boom_areas(i,1) < fs_loc*c && boom_areas(i+1,1) > fs_loc*c
        if abs(boom_areas(i,1)-fs_loc*c) < abs(boom_areas(i+1,1)-fs_loc*c)
            boom_areas(i,3) = boom_areas(i,3)+cap_areas(1,3)+cap_areas(2,3);
            top_index = i;
            break;
        else
            boom_areas(i+1,3) = boom_areas(i+1,3)+cap_areas(1,3)+cap_areas(2,3);
            top_index = i+1;
            break;
        end
    end
end
% Rear caps
for i = 1:length(boom_areas)-1
    % If rear end of the structure is reached
    if boom_areas(i,1) == boom_areas(i+1,1)
        break;
    end    
end
rear_index = i;
boom_areas(rear_index,3) = boom_areas(rear_index,3)+cap_areas(3,3);
boom_areas(rear_index+1,3) = boom_areas(rear_index+1,3)+cap_areas(4,3);

% Forward bottom caps
for i = round(length(boom_areas)/2):length(boom_areas)
    if boom_areas(i,1) > fs_loc*c && boom_areas(i+1,1) < fs_loc*c
        if abs(boom_areas(i,1)-fs_loc*c) < abs(boom_areas(i+1,1)-fs_loc*c)
            boom_areas(i,3) = boom_areas(i,3)+cap_areas(5,3)+cap_areas(6,3);
            bot_index = i;
            break;
        else 
            boom_areas(i+1,3) = boom_areas(i+1,3)+cap_areas(5,3)+cap_areas(6,3);
            bot_index = i+1; 
            break;
        end
    end
end

% Account for spars/spar thickness
% Fwd spar
dist = abs(boom_areas(top_index,2)-boom_areas(bot_index,2));
boom_areas(top_index,3) = boom_areas(top_index,3)+alum(spar_t)*dist/6*(2+sig_cap(5,3)/sig_cap(2,3));
boom_areas(bot_index,3) = boom_areas(bot_index,3)+alum(spar_t)*dist/6*(2+sig_cap(2,3)/sig_skin(5,3));
% Rear spar
dist = abs(boom_areas(rear_index,2)-boom_areas(rear_index+1,2));
boom_areas(rear_index,3) = boom_areas(rear_index,3)+alum(spar_t)*dist/6*(2+sig_cap(4,3)/sig_cap(3,3));
boom_areas(rear_index+1,3) = boom_areas(rear_index+1,3)+alum(spar_t)*dist/6*(2+sig_cap(3,3)/sig_cap(4,3));

end