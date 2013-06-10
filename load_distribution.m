%% LIFT DISTRIBUTION



function [Wx_0,Wy_0,Wx_10,Wy_10,Wx_15,Wy_15] = load_distribution()

% Input
W = 907.184*9.81; % maximum load in N
n_pos = 4.4; % positive limit load factor
n_neg = -1.76; % negative limit load factor
b = 9.7536/2; % half span in m

% Create points along span
z = 0:0.01:b;
num = length(z);

% Rectangular Distribution
Lr_pos = zeros(1,num);
Lr_neg = zeros(1,num);
for count = 1:num
    Lr_pos(count) = n_pos*W/2/b; % flat lift
    Lr_neg(count) = n_neg*W/2/b;
end

% Elliptical Distribution
Lmax_pos = n_pos*W*2/pi/b; % maximum lift for positive AoA
Lmax_neg = n_neg*W*2/pi/b; % maximum downlift for negative AoA
L_pos = zeros(1,num);
L_neg = zeros(1,num); 

for count = 1:num
    L_pos(count) = Lmax_pos*(1-z(count)^2/b^2)^.5; % positive lift as function of distance from root
    L_neg(count) = Lmax_neg*(1-z(count)^2/b^2)^.5; % negative lift as function of distance from root
end

% Averaged Distribution
Avg_pos = zeros(1,num);
Avg_neg = zeros(1,num);

for count = 1:num
    Avg_pos(count) = (L_pos(count)+Lr_pos(count))/2;
    Avg_neg(count) = (L_neg(count)+Lr_neg(count))/2;
end

% Plot lift distribution for half span
% figure(1)
% plot(z,Lr_pos,'b');
% hold on;
% plot(z,Lr_neg,'k');
% plot(z,L_pos,'g');
% plot(z,L_neg,'c');
% plot(z,Avg_pos,'r');
% plot(z,Avg_neg,'m');
% grid on;
% title('Lift distribution for half span');
% xlabel('Distance from root (m)');
% ylabel('Load (N/m)');
% legend('Rectangular distribution (positive lift)','Rectangular distribution (negative lift)',...
%     'Elliptical distribution (positive lift)','Elliptical distribution (negative lift)',...
%     'Averaged distribution (positive lift)','Averaged distribution (negative lift)','Location','NorthEastOutside');

%% DRAG DISTRIBUTION
% For half span

% Constants
AR = 7.2453; % wing aspect ratio
S = 13.1303; % wing area
e = 0.79; % assumed Oswald efficiency factor

% Matrices
v = zeros(4,3);
q = zeros(4,3);
CL = zeros(4,3);
CD = zeros(4,3);
D = zeros(4,3);
rho = zeros(1,3);

rho(1,1) = 1.225; % kg/m^3
rho(1,2) = .9048; % kg/m^3
rho(1,3) = .7711; % kg/m^3

% PHAA, SL
%CL(1,1) = 1.5036;
CD(1,1) = .04218;
v(1,1) = 54.0;
% NHAA, SL
%CL(2,1) = -1.4225; 
CD(2,1) = .03045;
v(2,1) = 39.4;
% PLAA, SL
%CL(3,1) = 1.3883;
CD(3,1) = .00899;
% NLAA, SL
%CL(4,1) = -.0909;
CD(4,1) = .00620;

% PHAA, 10k
%CL(1,2) = 1.4547;
CD(1,2) = .04202;
v(1,2) = 63.6;
% NHAA, 10k
%CL(2,2) = -1.3765;
CD(2,2) = .03132;
v(2,2) = 46.6;
% PLAA, 10k
%CL(3,2) = 1.6722;
CD(3,2) = .01375;
% NLAA, 10k
%CL(4,2) = -.2079;
CD(4,2) = .00681;

% PHAA, 15k
%CL(1,3) = 1.4279;
CD(1,3) = .04181;
v(1,3) = 69.4;
% NHAA, 15k
%CL(2,3) = -1.2904;
CD(2,3) = .03022;
v(2,3) = 49.8;
% PLAA, 15k
%CL(3,3) = 1.7562;
CD(3,3) = .01961;
% NLAA, 15k
%CL(4,3) = -.2898;
CD(4,3) = .00733;

v(3,:) = 76;
v(4,:) = 76;

% Compute q and D
for i = 1:4
    for j = 1:3
       q(i,j) = .5*rho(1,j)*v(i,j)^2;
       D(i,j) = q(i,j)*S*CD(i,j);%+CL(i,j)^2/(pi*AR*e); 
    end    
end

loc = -b:0.01:b;
pts = length(loc);
jump = .20*b;

d_0 = zeros(4,pts);
d_10 = zeros(4,pts);
d_15 = zeros(4,pts);
for sec = 1:pts
    for n = 1:4
        if loc(sec) <= (-b+jump) || loc(sec) >= (b-jump)
            d_0(n,sec) = 1.2*D(n,1)/(2*b);
            d_10(n,sec) = 1.2*D(n,2)/(2*b);
            d_15(n,sec) = 1.2*D(n,3)/(2*b);
        else
            d_0(n,sec) = (D(n,1) - 2*1.2*D(n,1)/(2*b)*(.20*b))/(.80*2*b);
            d_10(n,sec) = (D(n,2) - 2*1.2*D(n,2)/(2*b)*(.20*b))/(.80*2*b);
            d_15(n,sec) = (D(n,3) - 2*1.2*D(n,3)/(2*b)*(.20*b))/(.80*2*b);
        end
    end
end

% % Plot sea level
% figure(2)
% plot(loc,d_0(1,:),'r');
% hold on;
% plot(loc,d_0(2,:),'b');
% plot(loc,d_0(3,:),'g');
% plot(loc,d_0(4,:),'k');
% axis([-5 5 0 145]);
% grid on;
% xlabel('Distance from root (m)');
% ylabel('Drag (N/m)');
% title('Drag distribution at sea level');
% legend('PHAA','NHAA','PLAA','NLAA','Location','NorthEastOutside');
% 
% % Plot 10k feet
% figure(3)
% plot(loc,d_10(1,:),'r');
% hold on;
% plot(loc,d_10(2,:),'b');
% plot(loc,d_10(3,:),'g');
% plot(loc,d_10(4,:),'k');
% axis([-5 5 0 145]);
% grid on;
% xlabel('Distance from root (m)');
% ylabel('Drag (N/m)');
% title('Drag distribution at 10,000 feet');
% legend('PHAA','NHAA','PLAA','NLAA','Location','NorthEastOutside');
% 
% % Plot 15k feet
% figure(4)
% plot(loc,d_15(1,:),'r');
% hold on;
% plot(loc,d_15(2,:),'b');
% plot(loc,d_15(3,:),'g');
% plot(loc,d_15(4,:),'k');
% axis([-5 5 0 145]);
% grid on;
% xlabel('Distance from root (m)');
% ylabel('Drag (N/m)');
% title('Drag distribution at 15,000 feet');
% legend('PHAA','NHAA','PLAA','NLAA','Location','NorthEastOutside');

%% TRANSFORMATION

% SL
alpha(1,1) = .31765;
alpha(2,1) = -.30718;
alpha(3,1) = .13946;
alpha(4,1) = -.08816;

% 10k feet
alpha(1,2) = .30718;
alpha(2,2) = -.29845;
alpha(3,2) = .20057;
alpha(4,2) = -.10593;

% 15k feet
alpha(1,3) = .30020;
alpha(2,3) = -.28972;
alpha(3,3) = .24175;
alpha(4,3)= -.11791;

Wx_0 = zeros(4,num);
Wy_0 = zeros(4,num);
Wx_10 = zeros(4,num);
Wy_10 = zeros(4,num);
Wx_15 = zeros(4,num);
Wy_15 = zeros(4,num);

pos = length(loc)/2;
for count = 1:num
    for i = 1:4
        for j = 1:3
            AoA = alpha(i,j);
            if i == 1 || i == 3
                Wx_0(i,count) = -Avg_pos(count)*sin(AoA) + d_0(i,pos)*cos(AoA);
                Wx_10(i,count) = -Avg_pos(count)*sin(AoA) + d_10(i,pos)*cos(AoA);
                Wx_15(i,count) = -Avg_pos(count)*sin(AoA) + d_15(i,pos)*cos(AoA);
                Wy_0(i,count) = Avg_pos(count)*cos(AoA) + d_0(i,pos)*sin(AoA);
                Wy_10(i,count) = Avg_pos(count)*cos(AoA) + d_10(i,pos)*sin(AoA);
                Wy_15(i,count) = Avg_pos(count)*cos(AoA) + d_15(i,pos)*sin(AoA);
            else
                Wx_0(i,count) = -Avg_neg(count)*sin(AoA) + d_0(i,pos)*cos(AoA);
                Wx_10(i,count) = -Avg_neg(count)*sin(AoA) + d_10(i,pos)*cos(AoA);
                Wx_15(i,count) = -Avg_neg(count)*sin(AoA) + d_15(i,pos)*cos(AoA);
                Wy_0(i,count) = Avg_neg(count)*cos(AoA) + d_0(i,pos)*sin(AoA);
                Wy_10(i,count) = Avg_neg(count)*cos(AoA) + d_10(i,pos)*sin(AoA);
                Wy_15(i,count) = Avg_neg(count)*cos(AoA) + d_15(i,pos)*sin(AoA);
            end
        end
    end
    pos = pos+1;
end



% % Plot for SL
% colors = {'r','b','g','k'};
% 
% figure(5)
% for s = 1:4
%     plot(z,Wx_0(s,:),colors{s});
%     hold on;
% end
% xlabel('Distance from root (m)');
% ylabel('Load (N/m)');
% title('Force in X direction at sea level');
% grid on;
% legend('PHAA','NHAA','PLAA','NLAA','Location','NorthEastOutside');
% 
% % Plot for SL
% figure(6)
% for s = 1:4
%     plot(z,Wy_0(s,:),colors{s});
%     hold on;
% end
% xlabel('Distance from root (m)');
% ylabel('Load (N/m)');
% title('Force in Y direction at sea level');
% grid on;
% legend('PHAA','NHAA','PLAA','NLAA','Location','NorthEastOutside');
% 
% % Plot for 10k
% figure(7)
% for s = 1:4
%     plot(z,Wx_10(s,:),colors{s});
%     hold on;
% end
% xlabel('Distance from root (m)');
% ylabel('Load (N/m)');
% title('Force in X direction at 10,000 feet');
% grid on;
% legend('PHAA','NHAA','PLAA','NLAA','Location','NorthEastOutside');
% 
% % Plot for 10k
% figure(8)
% for s = 1:4
%     plot(z,Wy_10(s,:),colors{s});
%     hold on;
% end
% xlabel('Distance from root (m)');
% ylabel('Load (N/m)');
% title('Force in Y direction at 10,000 feet');
% grid on;
% legend('PHAA','NHAA','PLAA','NLAA','Location','NorthEastOutside');
% 
% % Plot for 15k
% figure(9)
% for s = 1:4
%     plot(z,Wx_15(s,:),colors{s});
%     hold on;
% end
% xlabel('Distance from root (m)');
% ylabel('Load (N/m)');
% title('Force in X direction at 15,000 feet');
% grid on;
% legend('PHAA','NHAA','PLAA','NLAA','Location','NorthEastOutside');
% 
% % Plot for 15k
% figure(10)
% for s = 1:4
%     plot(z,Wy_15(s,:),colors{s});
%     hold on;
% end
% xlabel('Distance from root (m)');
% ylabel('Load (N/m)');
% title('Force in Y direction at 15,000 feet');
% grid on;
% legend('PHAA','NHAA','PLAA','NLAA','Location','NorthEastOutside');


end