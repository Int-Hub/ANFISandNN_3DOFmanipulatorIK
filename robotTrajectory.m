function [x, y, theta, angles] = trajectory(points)
% Generate circular path
th          =   linspace(0, 360, points);
radius      =   2;
x           =   radius * cosd(th) + 12.5;      
y           =   radius * sind(th) + 12.5;
theta       =   atan2d(y,x);

[a1,a2,a3]  =    ik(x,y,theta, points);
 angles     =    [a1, a2, a3]' 
end