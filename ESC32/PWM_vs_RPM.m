%%-------------------------------data for Nex robotics motor------------------------------------------% 
arduino_dutycycle=[50 60 65 70 80 90 100 110 120 130 140 150 160 170 180 190 200 210 220 230 240 250];
motor_rpm=[2500 2954 3769 4465 5655 6612 7390 8022 8537 8973 9330 9630 9876 10087 10240 10387 10514 10624 10694 10822 11022 11500];

m=length(arduino_dutycycle);

p=polyfit(motor_rpm,arduino_dutycycle,5) %actual motors behaviour
ht=polyval(p,motor_rpm);

%------------------------------ideal behaviour--------------------------------------------------------%
dutycycle_lin=[50 250];
rpm_lin=[2500 11500];
p_lin=polyfit(rpm_lin,dutycycle_lin,1); %linear behaviour
ht_lin=polyval(p_lin,motor_rpm);

%------------------------------non-linearity-----------------------------------------------------------%
data_non=ht_lin-ht;
plot(motor_rpm,data_non);
p_non=polyfit(motor_rpm,data_non,5);
ht_non=polyval(p_non,motor_rpm);
hold on
plot(motor_rpm,ht_non,'r');

%-------------------------------combined behaviour----------------------------------------------------%
output=ht_non+ht_lin;
figure
plot(motor_rpm,arduino_dutycycle, 'Color','black');
hold on
plot(motor_rpm,ht, 'Color','red');
hold on
plot(motor_rpm,ht_lin, 'Color','green');
hold on
plot(motor_rpm,output, 'Color','blue');
