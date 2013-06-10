function [cent_skin,I_skin,A_skin,AFpnt] = skin(t)

c=1.3462;   %chord in meters

AFpnt=zeros(15001,2);
ind=1;
for x=0.75:-0.0001:0
    AFpnt(ind,1)=x*c;
    AFpnt(ind,2)=getpoint(x,'top',c);
    ind=ind+1;
end

for x=0.0001:0.0001:0.75
    AFpnt(ind,1)=x*c;
    AFpnt(ind,2)=getpoint(x,'bot',c);
    ind=ind+1;
end
    
    

A_skin=zeros(1,length(AFpnt));
sumXcent=0;
sumYcent=0;
for n=1:length(AFpnt)
    if n==length(AFpnt)
        dist=((AFpnt(1,1)-AFpnt(n,1))^2+(AFpnt(1,2)-AFpnt(n,2))^2)^0.5;
        A_skin(n)=dist*t;
        sumXcent=sumXcent+dist*t*(AFpnt(1,1)+AFpnt(n,1))/2;
        sumYcent=sumYcent+dist*t*(AFpnt(1,2)+AFpnt(n,2))/2;
    else
        dist=((AFpnt(n+1,1)-AFpnt(n,1))^2+(AFpnt(n+1,2)-AFpnt(n,2))^2)^0.5;
        A_skin(n)=dist*t;
        sumXcent=sumXcent+dist*t*(AFpnt(n,1)+AFpnt(n+1,1))/2;
        sumYcent=sumYcent+dist*t*(AFpnt(n,2)+AFpnt(n+1,2))/2;
    end
end

Xcent=sumXcent/sum(A_skin);
Ycent=sumYcent/sum(A_skin);


%% Moments of inertia

Ixx=0;
Iyy=0;
Ixy=0;

for n=1:length(AFpnt)
    if n==length(AFpnt)
        dx=(AFpnt(1,1)+AFpnt(n,1))/2-Xcent;
        dy=(AFpnt(1,2)+AFpnt(n,2))/2-Ycent;
        Ixx=Ixx+A_skin(n)*dy^2;
        Iyy=Iyy+A_skin(n)*dx^2;
        Ixy=Ixy+A_skin(n)*dx*dy;
    else
        dx=(AFpnt(n+1,1)+AFpnt(n,1))/2-Xcent;
        dy=(AFpnt(n+1,2)+AFpnt(n,2))/2-Ycent;
        Ixx=Ixx+A_skin(n)*dy^2;
        Iyy=Iyy+A_skin(n)*dx^2;
        Ixy=Ixy+A_skin(n)*dx*dy;
    end
end

Ixx_skin = Ixx;
Iyy_skin = Iyy;
Ixy_skin = Ixy;


cent_skin = [Xcent,Ycent];
I_skin = [Ixx_skin Iyy_skin Ixy_skin];

end
