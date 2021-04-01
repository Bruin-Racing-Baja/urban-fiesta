function J = analytical_fitness(T, dt, params)
% fitness function to tune an ESC using a genetic algorithm based on
% maximizing wheel speed
% 
% T: [s] simulation duration
% dt: [s] fixed simulation timestep
% params: parameter vector containing the following items:
%   K: [rpm/rad] controller gain
%   om: [rad/s] perturbation frequency
%   a: [rpm] perturbation amplitude
%   om_h: [rad/s] high pass cutoff frequency
%   phi: [rad] demodulation phase shift

% sim parameters
% K = params(1);
% om = params(2);
% a = params(3);
% om_h = params(4);
% phi = params(5);

% run simulation
mws = get_param('equiv_analytical', 'ModelWorkspace');
mws.assignin('T_max', T);
mws.assignin('ts', dt);
mws.assignin('K', params(1));
mws.assignin('om', params(2));
mws.assignin('a', params(3));
mws.assignin('om_h', params(4));
mws.assignin('phi', params(5));
simout = sim('equiv_analytical.slx'); %, ...
%     'T_max', T, ...
%     'ts', dt, ...
%     'K', params(1), ...
%     'om', params(2), ...
%     'a', params(3), ...
%     'om_h', params(4), ...
%     'phi', params(5));

% parse data
t = simout.tout;
r = simout.r.Data;      % cvt ratio
w1 = simout.w1.Data;    % [rad/s] primary angular velocity
w2 = simout.w2.Data;    % [rad/s] secondary angular velocity
% Te = simout.Te.Data;    % [N*m] engine torque

r12 = 48/16; % first reduction
r34 = 48/16; % second reduction
wheel_rad = 11.5*.0254; % [m] tire static radius
cvt_low = 4.31; % cvt engagement ratio
cvt_high = .81; % cvt overdrive ratio

eg_rpm = w1*60/(2*pi);      % [rpm] engine angular velocity
vel = w2/r12/r34*wheel_rad; % [m/s] wheel linear velocity
vel_mph = vel*3600/1600;    % [mph]

figure(1);
plot(t, r);
hline(cvt_low, 'k--');
hline(cvt_high, 'k--');
grid on;
xlabel('time [s]');
ylabel('cvt ratio');

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

figure(5);
plot(t, r, t, w1./w2);
grid on;

% fitness based on wheel speed
J = sum(vel_mph)*dt;

% penalty for every second that the engine is stalled
[min_rpm, min_ind] = min(eg_rpm);
if min_rpm < 1600
    J = J - 50*(length(eg_rpm) - min_ind)*dt;
end
% J = J - 1e3*(min(eg_rpm) < 1600);

% switch maximization to minimization
J = -J;

end