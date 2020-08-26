clear;
clc;
pretty_pictures;

load('eg_curve.mat');

plot(speedVector, torqueVector);
title('BS Vanguard 19 Torque vs Speed');
xlabel('RPM');
ylabel('N-m');
grid on;