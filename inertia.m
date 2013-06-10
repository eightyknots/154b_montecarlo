function [I,cent,num,comp] = inertia(str_areas,spar_areas,cap_areas,cent_skin,I_skin,A_skin)
%% Assemble component matrix

num_str = size(str_areas,1);
num_spar = size(spar_areas,1);
num_cap = size(cap_areas,1);

num_comp=num_str+num_spar+num_cap;

num = [num_comp,num_str,num_cap,num_spar];

comp=zeros(num_comp,3);

%stringers
for n=1:num_str
    for m=1:3
        comp(n,m)=str_areas(n,m);
    end
end

%caps
ind=1;
for n=num_str+1:num_str+num_cap
    for m=1:3
        comp(n,m)=cap_areas(ind,m);
    end
ind=ind+1;
end

%spars
ind=1;
for n=num_str+num_cap+1:num_comp
    for m=1:3
        comp(n,m)=spar_areas(ind,m);
    end
    ind=ind+1;
end

%% Find centroid

%area sum
for n=1:num_comp
    if n==1, A_total=0; end
    A_total=A_total+comp(n,3);
end

%x-coordinate
for n=1:num_comp
    if n==1, x_cent=0; end
    x_cent=x_cent+(comp(n,1)*comp(n,3))/A_total;
end

%y-coordinate
for n=1:num_comp
    if n==1, y_cent=0; end
    y_cent=y_cent+(comp(n,2)*comp(n,3))/A_total;
end

x_cent=(A_total*x_cent+A_skin*cent_skin(1))/(A_total+A_skin);
y_cent=(A_total*y_cent+A_skin*cent_skin(2))/(A_total+A_skin);

cent=[x_cent,y_cent];

%% Find Moments of Inertia

%still have to incorporate the spar for Iyy, Ixy (Ixx negligible)

I=zeros(1,3);
for m=1:3
    for n=1:num_comp
        if m==1
        I(m)=I(m)+comp(n,3)*(comp(n,2)-y_cent)^2;
        end
        if m==2
            I(m)=I(m)+comp(n,3)*(comp(n,1)-x_cent)^2;
        end
        if m==3
            I(m)=I(m)+comp(n,3)*(comp(n,1)-x_cent)*(comp(n,2)-y_cent);
        end
    end
end

I = I+I_skin;

end