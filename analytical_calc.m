% analytical_calc.m
% 
% author: Tyler McCown (tylermccown@engineering.ucla.edu
% created: 24 January 2021

clear;
clc;

% extremeum-seeking controller
load esc_params_short
K = esc_params(1);      % [rpm/rad] controller gain
om = esc_params(2);     % [rad/s] perturbation frequency
a = esc_params(3);      % [rpm] perturbation amplitude
om_h = esc_params(4);   % [rad/s] high pass cutoff frequency
phi = esc_params(5);    % [rad] demodulation phase shift

% configure and run simulation
eg_ref = 3200;  % [rpm] reference engine rpm
T_max = 30;     % [s] simulation duration
ts = .01;       % [s] fixed simulation timestep
simout = sim('equiv_analytical.slx');

%% parse data

t = simout.tout;
r = simout.r.Data;      % cvt ratio
w1 = simout.w1.Data;    % [rad/s] primary angular velocity
w2 = simout.w2.Data;    % [rad/s] secondary angular velocity
Te = simout.Te.Data;    % [N*m] engine torque
u = simout.u.Data;      % [rpm] motor angular velocity

eg_rpm = w1*60/(2*pi);      % [rpm] engine angular velocity
vel = w2/r12/r34*wheel_rad; % [m/s] wheel linear velocity
vel_mph = vel*3600/1600;    % [mph]

%% plot

figure(1);
subplot(221);
plot(t, r);
hline(cvt_low, 'k--');
hline(cvt_high, 'k--');
grid on;
xlabel('time [s]');
title('cvt ratio');

% figure(2);
subplot(223);
plot(t, eg_rpm);
grid on;
xlabel('time [s]');
title('engine speed');
ylabel('[rpm]');

% figure(3);
subplot(224);
plot(t, vel_mph);
grid on;
xlabel('time [s]');
title('wheel speed');
ylabel('[mph]');

figure(4);
plot(vel_mph, eg_rpm);
grid on;
xlabel('wheel speed [mph]');
title('engine speed');
ylabel('[rpm]');

figure(1);
% figure(5);
subplot(222);
plot(t, u);
hline([motor_max, -motor_max], 'k--');
grid on;
xlabel('time [s]');
title('motor speed');
ylabel('[rpm]');

figure(6);
plot(t, r, t, w1./w2);
grid on;
xlabel('time [s]');
ylabel('ratio');
legend('model', 'true');
