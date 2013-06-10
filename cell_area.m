function [A_cell1 A_cell2] = cell_area(fs_loc)

c=1.524; %chord length in meters

x1=0:0.0001:fs_loc*c;
x2=fs_loc*c:0.0001:0.75*c;

A_cell1=0;
A_cell2=0;

for n=1:length(x1)-1
   b1 = getpoint(x1(n)/c,'top',c)-getpoint(x1(n)/c,'bot',c);
   b2 = getpoint(x1(n+1)/c,'top',c)-getpoint(x1(n+1)/c,'bot',c);
   A_cell1 = A_cell1 + 0.5*0.0001*(b1+b2);
end

for n=1:length(x2)-1
    b1 = getpoint(x2(n)/c,'top',c)-getpoint(x2(n)/c,'bot',c);
    b2 = getpoint(x2(n+1)/c,'top',c)-getpoint(x2(n+1)/c,'bot',c);
    A_cell2 = A_cell2 + 0.5*0.0001*(b1+b2);
end

