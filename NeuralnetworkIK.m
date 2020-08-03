[inputData, outputData] = fk(3000);
net=feedforwardnet([40 30 30],'trainbr');
net.trainParam.epochs = 150;
net = train(net,inputData,outputData);
a=net(inputData);
%plotfit(net,inputData,ouputData);
perform(net,ouputData,a);

Q1diff = a1 - outputData(1,:);
Q2diff = a2 - outputData(2,:);
Q3diff = a3 - outputData(3,:);
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

