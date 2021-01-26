clear;
clc;
pretty_pictures;

load('eg_curve.mat');
load('bs_m19_torque_curve.mat');
speedVector_datasheet = bs_m19_torque_curve(:,1);
torqueVector_datasheet = bs_m19_torque_curve(:,2);

powerVector = speedVector*2*pi/60.*torqueVector;
powerVector_datasheet = speedVector_datasheet*2*pi/60.*torqueVector_datasheet;

figure(4);
sgtitle('BS Vanguard 19 Engine Curves');
subplot(211); % torque
plot(speedVector, torqueVector, speedVector_datasheet, torqueVector_datasheet);
xlabel('RPM');
ylabel('Torque [Nm]');
grid on;
legend({'SAE India', 'B\&S Datasheet'}, 'location', 'southwest');
subplot(212); % power
plot(speedVector, powerVector/1000, speedVector_datasheet, powerVector_datasheet/1000);
xlabel('RPM');
ylabel('Power [kW]');
grid on;
