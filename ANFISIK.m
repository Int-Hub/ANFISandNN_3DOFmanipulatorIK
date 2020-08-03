%% Inverse kinematics solution using Anfis

l1 = 10; % length of first arm
l2 = 7; % length of second arm
l3 = 5; %lengh of third arm
Q1 = 90 * rand(1,3000);
Q2 = 90 * rand(1,3000);
Q3 = 90 * rand(1,3000);

x_e = l1 * cosd(Q1) + l2 * cosd(Q1+Q2) + l3 * cosd(Q1+Q2+Q3);
y_e = l1 * sind(Q1) + l2 * sind(Q1+Q2) + l3 * sind(Q1+Q2+Q3);

data1 = [x_e(:) y_e(:) Q1(:)]; % create x-y-theta1 dataset
data2 = [x_e(:) y_e(:) Q2(:)]; % create x-y-theta2 dataset
data3 = [x_e(:) y_e(:) Q3(:)]; % create x-y-theta3 dataset

% Train an ANFIS system using the first set of training data, |data1|.
disp('--> Training first ANFIS network.')
opt = anfisOptions;
opt.InitialFIS = 3;
opt.EpochNumber =   200;
opt.DisplayANFISInformation = 0;
opt.DisplayErrorValues = 1;
opt.DisplayStepSize = 0;
opt.DisplayFinalResults = 1;
anfis1 = anfis(data1,opt);

disp('--> Training second ANFIS network.')
opt = anfisOptions;
opt.InitialFIS = 8;
opt.EpochNumber =   300;
opt.DisplayANFISInformation = 0;
opt.DisplayErrorValues = 1;
opt.DisplayStepSize = 0;
opt.DisplayFinalResults = 1;
anfis2 = anfis(data2,opt);

disp('--> Training third ANFIS network.')
opt = anfisOptions;
opt.InitialFIS = 8;
opt.EpochNumber =   300;
opt.DisplayANFISInformation = 0;
opt.DisplayErrorValues = 1;
opt.DisplayStepSize = 0;
opt.DisplayFinalResults = 1;
anfis3 = anfis(data3,opt);
%% Closed form solution for Inverse Kinematics
l1 = 10; % length of first arm
l2 = 7; % length of second arm
l3 = 5; %lengh of third arm
Q1 = 90 * rand(1,3000);
Q2 = 90 * rand(1,3000);
Q3 = 90 * rand(1,3000);

x_e = l1 * cosd(Q1) + l2 * cosd(Q1+Q2) + l3 * cosd(Q1+Q2+Q3);
y_e = l1 * sind(Q1) + l2 * sind(Q1+Q2) + l3 * sind(Q1+Q2+Q3);
theta_e = Q1+Q2+Q3;
x = x_e(:) - l3 * cosd(theta_e(:)); % x coordinates for validation
y = y_e(:) - l3 * sind(theta_e(:)); % y coordinates for validation
r = sqrt(x.^2 + y.^2);
beta = acosd((l1^2 + l2^2 - r.^2)/(2*l1*l2));
A=zeros(3000,1);
A(:) = 90;
Q2D = A - beta;
gamma = acosd((r.^2 +l1^2 - l2^2)./(2*r*l1));
alpha = atan2d(y, x);
Q1D = alpha - gamma;
Q3D = theta_e(:) - Q1D - Q2D;

% Here, |evalfis| is used to find out the FIS outputs for the same x-y
% values used earlier in the inverse kinematics formulae.

XYT = [x_e(:) y_e(:)];
Q1P = evalfis(anfis1,XYT); % theta1 predicted by anfis1
Q2P = evalfis(anfis2,XYT); % theta2 predicted by anfis2
Q3P = evalfis(anfis3,XYT); % theta3 predicted by anfis3

%%
% Now, we can see how close the FIS outputs are with respect to the
% deduced values.

Q1diff = Q1D - Q1P;
Q2diff = Q2D - Q2P;
Q3diff = Q3D - Q3P;
%%
subplot(2,2,1);
plot(Q1diff);
ylabel('THETA1D - THETA1P','fontsize',10)
title('Deduced theta1 - Predicted theta1','fontsize',10)

subplot(2,2,2);
plot(Q2diff);
ylabel('THETA2D - THETA2P','fontsize',10)
title('Deduced theta2 - Predicted theta2','fontsize',10)

subplot(2,2,3);
plot(Q3diff);
ylabel('THETA3D - THETA3P','fontsize',10)
title('Deduced theta3 - Predicted theta3','fontsize',10)