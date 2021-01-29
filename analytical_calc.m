% analytical_calc.m
% 
% author: Tyler McCown (tylermccown@engineering.ucla.edu
% created: 24 January 2021

clear;
clc;

% configure and run simulation
eg_ref = 3500; % [rpm] reference engine rpm
T_max = 30; % [s] simulation duration
simout = sim('equiv_analytical.slx');

%% parse data

t = simout.tout;
r = simout.r.Data; % cvt ratio
w1 = simout.w1.Data; % [rad/s] 
w2 = simout.w2.Data; % [rad/s]

eg_rpm = w1*60/(2*pi); % [rpm] engine angular velocity
vel = w2/r12/r34*wheel_rad; % [m/s] wheel linear velocity
vel_mph = vel*3600/1600; % [mph]

%% plot

figure(1);
plot(t, r);
hline(cvt_low, 'k--');
hline(cvt_high, 'k--');
grid on;
xlabel('time [s]');

figure(2);
plot(t, eg_rpm);
grid on;
xlabel('time [s]');
ylabel('engine speed [rpm]');

figure(3);
plot(t, vel_mph);
grid on;
xlabel('time [s]');
ylabel('wheel speed [mph]');

figure(4);
plot(vel_mph, eg_rpm);
grid on;
xlabel('wheel speed [mph]');
ylabel('engine speed [rpm]');
