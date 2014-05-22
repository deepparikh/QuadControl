%%-------------------------------data for Nex robotics motor------------------------------------------% 
arduino_dutycycle=[50 60 70 80 90 100 110 120 130 140 150 160 170 180 190 200];
motor_rpm=[2292 5534 8388 10793 12779 14468 15892 17279 18166 18850 19436 19919 20287 20547 20772 20930];

m=length(arduino_dutycycle);

p=polyfit(motor_rpm,arduino_dutycycle,5) %actual motors behaviour
ht=polyval(p,motor_rpm);

%------------------------------ideal behaviour--------------------------------------------------------%
dutycycle_lin=[50 200];
rpm_lin=[2292 20930];
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
p_output=polyfit(motor_rpm,output,4);
figure
ht_output=polyval(p_output,motor_rpm);
plot(motor_rpm,arduino_dutycycle, 'Color','black');
hold on
plot(motor_rpm,ht, 'Color','red');
hold on
plot(motor_rpm,ht_lin, 'Color','green');
hold on
plot(motor_rpm,output, 'Color','blue');
figure
plot(motor_rpm,ht_output, 'Color','black');


