% compare_eg_ref.m
% 
% this script uses equiv_analytical.m to compare the vehicle acceleration
% using various engine reference speeds
% 
% author: Tyler McCown (tylermccown@engineering.ucla.edu)
% created: 28 January 2021

clear;
clc;

% configure search region for engine reference speed
ref_lower = 2000;   % [rpm] lower bound of search region
ref_upper = 3800;   % [rpm] upper bound of search region
n_sims = 30;         % number of simulations to run
T_max = 10;         % [s] simulation duration
ts = .01;           % [s] fixed simulation timestep

%% run simulations and record data

refs = linspace(ref_lower, ref_upper, n_sims);
eg_rpms = zeros(T_max/ts + 1, n_sims);
vels = zeros(size(eg_rpms));
rs = zeros(size(eg_rpms));
us = zeros(size(eg_rpms));
for i = 1:length(refs)
    
    % run simulation
    eg_ref = refs(i);
    simout = sim('equiv_analytical.slx');
    
    % parse data
    t = simout.tout;
    rs(:, i) = simout.r.Data; % cvt ratio
    w1 = simout.w1.Data; % [rad/s] 
    w2 = simout.w2.Data; % [rad/s]
    us(:, i) = simout.u.Data; % [rpm] motor angular velocity

    eg_rpms(:,i) = w1*60/(2*pi); % [rpm] engine angular velocity
    vels(:,i) = w2/r12/r34*wheel_rad; % [m/s] wheel linear velocity
    
end
vels_mph = vels*3600/1600; % [mph]

%% plot results

figure(1);
plot(t, rs);
hline([cvt_low, cvt_high], 'k--');
grid on;
xlabel('time [s]');
ylabel('cvt ratio');

figure(2);
plot(t, eg_rpms);
grid on;
xlabel('time [s]');
ylabel('engine speed [rpm]');

figure(3);
plot(t, vels_mph);
grid on;
xlabel('time [s]');
ylabel('wheel speed [mph]');

figure(4);
plot(vels_mph, eg_rpms);
grid on;
xlabel('wheel speed [mph]');
ylabel('engine speed [rpm]');

figure(5);
plot(t, us);
hline([motor_max, -motor_max], 'k--');
grid on;
xlabel('time [s]');
ylabel('motor speed [rpm]');

%% performance index

perf = sum(vels_mph, 1)*ts/3600;

load('eg_curve.mat');
powerVector = speedVector*2*pi/60.*torqueVector;
load('bs_m19_torque_curve.mat');
speedVector_datasheet = bs_m19_torque_curve(:,1);
torqueVector_datasheet = bs_m19_torque_curve(:,2);
powerVector_datasheet = speedVector_datasheet*2*pi/60.*torqueVector_datasheet;

figure(6);
plot(refs, perf, '*');
hold on;
plot(speedVector, torqueVector/max(torqueVector)*max(perf));
plot(speedVector, powerVector/max(powerVector)*max(perf));
hold off;
xlim([ref_lower, ref_upper]);
ylim([0, max(perf)*1.1]);
grid on;
xlabel('engine reference [rpm]');
% ylabel('distance traveled [miles]');
legend({'performance index', 'normalized torque curve', 'normalized power curve'}, 'location', 'southwest');
title(sprintf('simulation time %i sec', T_max));
