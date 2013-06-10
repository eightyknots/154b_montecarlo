function [Sx_0,Sy_0,Sx_10,Sy_10,Sx_15,Sy_15] = shear(Wx_0,Wy_0,Wx_10,Wy_10,Wx_15,Wy_15)

b = 0:0.01:9.7536/2; % half span in m
num=length(b);

colors = {'r','b','g','k'};

%Integrate Wx_0 to get Sx_0
Sx_0=zeros(4,num);
for count = 1:num
    for c=1:4
        if count == 1
            Sx_0(c,count)=0;
        else
            Sx_0(c,count)=Sx_0(c,count-1)+0.01*Wx_0(c,count);
        end
    end
end

for count = 1:num
    for c=1:4
        reaction=Sx_0(c,num);
        Sx_0(c,count)=-1*(Sx_0(c,count)-reaction);
    end
end


%Integrate Wy_0 to get Sy_0
Sy_0=zeros(4,num);
for count = 1:num
    for c=1:4
        if count == 1
            Sy_0(c,count)=0;
        else
            Sy_0(c,count)=Sy_0(c,count-1)+0.01*Wy_0(c,count);
        end
    end
end

for count = 1:num
    for c=1:4
        reaction=Sy_0(c,num);
        Sy_0(c,count)=-1*(Sy_0(c,count)-reaction);
    end
end


%Integrate Wx_10 to get Sx_10
Sx_10=zeros(4,num);
for count = 1:num
    for c=1:4
        if count == 1
            Sx_10(c,count)=0;
        else
            Sx_10(c,count)=Sx_10(c,count-1)+0.01*Wx_10(c,count);
        end
    end
end

for count = 1:num
    for c=1:4
        reaction=Sx_10(c,num);
        Sx_10(c,count)=-1*(Sx_10(c,count)-reaction);
    end
end


%Integrate Wy_10 to get Sy_10
Sy_10=zeros(4,num);
for count = 1:num
    for c=1:4
        if count == 1
            Sy_10(c,count)=0;
        else
            Sy_10(c,count)=Sy_10(c,count-1)+0.01*Wy_10(c,count);
        end
    end
end

for count = 1:num
    for c=1:4
        reaction=Sy_10(c,num);
        Sy_10(c,count)=-1*(Sy_10(c,count)-reaction);
    end
end


%Integrate Wx_15 to get Sx_15
Sx_15=zeros(4,num);
for count = 1:num
    for c=1:4
        if count == 1
            Sx_15(c,count)=0;
        else
            Sx_15(c,count)=Sx_15(c,count-1)+0.01*Wx_15(c,count);
        end
    end
end

for count = 1:num
    for c=1:4
        reaction=Sx_15(c,num);
        Sx_15(c,count)=-1*(Sx_15(c,count)-reaction);
    end
end


%Integrate Wy_15 to get Sy_15
Sy_15=zeros(4,num);
for count = 1:num
    for c=1:4
        if count == 1
            Sy_15(c,1)=0;
        else
            Sy_15(c,count)=Sy_15(c,count-1)+0.01*Wy_15(c,count);
        end
    end
end

for count = 1:num
    for c=1:4
        reaction=Sy_15(c,num);
        Sy_15(c,count)=-1*(Sy_15(c,count)-reaction);
    end
end


% %% Plots
% figure(21)
% for c=1:4
%     plot(b,Sx_0(c,:),colors{c})
%     hold on
% end
% xlabel('Span dimension (m)');
% ylabel('Shear Force (N)');
% title('Shear Force in X direction at SL');
% legend('PHAA','NHAA','PLAA','NLAA','Location','NorthEastOutside');
% grid on;
% 
% figure(22)
% for c=1:4
%     plot(b,Sy_0(c,:),colors{c})
%     hold on
% end
% xlabel('Span dimension (m)');
% ylabel('Shear Force (N)');
% title('Shear Force in Y direction at SL');
% legend('PHAA','NHAA','PLAA','NLAA','Location','NorthEastOutside');
% grid on;
% 
% figure(23)
% for c=1:4
%     plot(b,Sx_10(c,:),colors{c})
%     hold on
% end
% xlabel('Span dimension (m)');
% ylabel('Shear Force (N)');
% title('Shear Force in X direction at 10K');
% legend('PHAA','NHAA','PLAA','NLAA','Location','NorthEastOutside');
% grid on;
% 
% figure(24)
% for c=1:4
%     plot(b,Sy_10(c,:),colors{c})
%     hold on
% end
% xlabel('Span dimension (m)');
% ylabel('Shear Force (N)');
% title('Shear Force in Y direction at 10K');
% legend('PHAA','NHAA','PLAA','NLAA','Location','NorthEastOutside');
% grid on;
% 
% figure(25)
% for c=1:4
%     plot(b,Sx_15(c,:),colors{c})
%     hold on
% end
% xlabel('Span dimension (m)');
% ylabel('Shear Force (N)');
% title('Shear Force in X direction at 15K');
% legend('PHAA','NHAA','PLAA','NLAA','Location','NorthEastOutside');
% grid on;
% 
% figure(26)
% for c=1:4
%     plot(b,Sy_15(c,:),colors{c})
%     hold on
% end
% xlabel('Span dimension (m)');
% ylabel('Shear Force (N)');
% title('Shear Force in Y direction at 15K');
% legend('PHAA','NHAA','PLAA','NLAA','Location','NorthEastOutside');
% grid on;

end