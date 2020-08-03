
th      =   linspace(0, 360, 360);
radius  =   5;
newx    =   radius * cosd(th) + 0;      
newy    =   radius * sind(th) + 15;
theta   =   atan2(newy,newx);

nn_out  =   ([newx; newy; theta]);

pos     =   [   l2*cosd(nn_out(1) + nn_out(2))+l1*cosd(nn_out(1))+l3*cosd(nn_out(1) + nn_out(2) + nn_out(3));
                l2*sind(nn_out(1) + nn_out(2))+l1*sind(nn_out(1))+l3*sind(nn_out(1) + nn_out(2) + nn_out(3))    ];

figure
hold on
grid on
axis equal
plot(newx,newy, ".b");
hold off