function [Mx_0,My_0,Mx_10,My_10,Mx_15,My_15] = moment(Sx_0,Sy_0,Sx_10,Sy_10,Sx_15,Sy_15)

b = 0:0.01:9.7536/2; % half span in m
num=length(b);

colors = {'r','b','g','k'};

%Integrate Sx_0 to get My_0
My_0=zeros(4,num);
for count = 1:num
    for c=1:4
        if count == 1
            My_0(c,count)=0;
        else
            My_0(c,count)=My_0(c,count-1)+0.01*Sx_0(c,count);
        end
    end
end

for count = 1:num
    for c=1:4
        reaction=My_0(c,num);
        My_0(c,count)=My_0(c,count)-reaction;
    end
end


%Integrate Sy_0 to get Mx_0
Mx_0=zeros(4,num);
for count = 1:num
    for c=1:4
        if count == 1
            Mx_0(c,count)=0;
        else
            Mx_0(c,count)=Mx_0(c,count-1)+0.01*Sy_0(c,count);
        end
    end
end

for count = 1:num
    for c=1:4
        reaction=Mx_0(c,num);
        Mx_0(c,count)=Mx_0(c,count)-reaction;
    end
end


%Integrate Sx_10 to get My_10
My_10=zeros(4,num);
for count = 1:num
    for c=1:4
        if count == 1
            My_10(c,count)=0;
        else
            My_10(c,count)=My_10(c,count-1)+0.01*Sx_10(c,count);
        end
    end
end

for count = 1:num
    for c=1:4
        reaction=My_10(c,num);
        My_10(c,count)=My_10(c,count)-reaction;
    end
end


%Integrate Sy_10 to get Mx_10
Mx_10=zeros(4,num);
for count = 1:num
    for c=1:4
        if count == 1
            Mx_10(c,count)=0;
        else
            Mx_10(c,count)=Mx_10(c,count-1)+0.01*Sy_10(c,count);
        end
    end
end

for count = 1:num
    for c=1:4
        reaction=Mx_10(c,num);
        Mx_10(c,count)=Mx_10(c,count)-reaction;
    end
end


%Integrate Sx_15 to get My_15
My_15=zeros(4,num);
for count = 1:num
    for c=1:4
        if count == 1
            My_15(c,count)=0;
        else
            My_15(c,count)=My_15(c,count-1)+0.01*Sx_15(c,count);
        end
    end
end

for count = 1:num
    for c=1:4
        reaction=My_15(c,num);
        My_15(c,count)=My_15(c,count)-reaction;
    end
end


%Integrate Sy_15 to get Mx_15
Mx_15=zeros(4,num);
for count = 1:num
    for c=1:4
        if count == 1
            Mx_15(c,1)=0;
        else
            Mx_15(c,count)=Mx_15(c,count-1)+0.01*Sy_15(c,count);
        end
    end
end

for count = 1:num
    for c=1:4
        reaction=Mx_15(c,num);
        Mx_15(c,count)=Mx_15(c,count)-reaction;
    end
end


% %% Plots
% figure(31)
% for c=1:4
%     plot(b,My_0(c,:),colors{c})
%     hold on
% end
% xlabel('Span dimension (m)');
% ylabel('Moment (N-m)');
% title('Moment about Y axis at SL');
% legend('PHAA','NHAA','PLAA','NLAA','Location','NorthEastOutside');
% grid on;
% 
% figure(32)
% for c=1:4
%     plot(b,Mx_0(c,:),colors{c})
%     hold on
% end
% xlabel('Span dimension (m)');
% ylabel('Moment (N-m)');
% title('Moment about X axis at SL');
% legend('PHAA','NHAA','PLAA','NLAA','Location','NorthEastOutside');
% grid on;
% 
% figure(33)
% for c=1:4
%     plot(b,My_10(c,:),colors{c})
%     hold on
% end
% xlabel('Span dimension (m)');
% ylabel('Moment (N-m)');
% title('Moment about Y axis at 10K');
% legend('PHAA','NHAA','PLAA','NLAA','Location','NorthEastOutside');
% grid on;
% 
% figure(34)
% for c=1:4
%     plot(b,Mx_10(c,:),colors{c})
%     hold on
% end
% xlabel('Span dimension (m)');
% ylabel('Moment (N-m)');
% title('Moment about X axis at 10K');
% legend('PHAA','NHAA','PLAA','NLAA','Location','NorthEastOutside');
% grid on;
% 
% figure(35)
% for c=1:4
%     plot(b,My_15(c,:),colors{c})
%     hold on
% end
% xlabel('Span dimension (m)');
% ylabel('Moment (N-m)');
% title('Moment about Y axis at 15K');
% legend('PHAA','NHAA','PLAA','NLAA','Location','NorthEastOutside');
% grid on;
% 
% figure(36)
% for c=1:4
%     plot(b,Mx_15(c,:),colors{c})
%     hold on
% end
% xlabel('Span dimension (m)');
% ylabel('Moment (N-m)');
% title('Moment about X axis at 15K');
% legend('PHAA','NHAA','PLAA','NLAA','Location','NorthEastOutside');
% grid on;

end