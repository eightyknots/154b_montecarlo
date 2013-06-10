%% CREATE WING

function [top,bot,pts] = create(c)

% Set step size for number of points
pts = 100;

top = zeros(pts,1);
bot = zeros(pts,1);

t = .12; % 12%C max thickness
p = .40; % 40%C max thickness location
m = .02; % 2% max camber

for i = 1:pts
    x = i/pts;
    y_t = t/0.2*(.2969*sqrt(x)-0.1260*x-0.3516*x^2+.2843*x^3-0.1015*x^4);
    if x <= p
        y_c = m/p^2*(2*p*x-x^2);
    else
        y_c = m/(1-p)^2*((1-2*p)+2*p*x-x^2);
    end
    top(i) = y_c+y_t;
    bot(i) = y_c-y_t;
end

top = top.*c;
bot = bot.*c;

%% OBSOLETE CODE

% load('naca2412.mat');
% % NACA2412.mat is a 200x2 matrix of x and y coordinates
% 
% % Separate top and bottom surfaces (create same size matrices)
% up = naca(1:100,:);
% down = naca(101:200,:);
% 
% % Change top matrix to be ordered from leading to trailing edge
% temp = up(:,1);
% for a = 1:length(up)
%     up(a,1) = temp(length(temp)+1-a);
% end
% 
% % Truncate top and bottom surfaces after 75% chord
% for b = 1:100
%     if up(b,1) <= c*0.75
%         top(b,:) = up(b,:);
%     end
%     if down(b,1) <= c*0.75
%         bot(b,:) = down(b,:);
%     end
% end