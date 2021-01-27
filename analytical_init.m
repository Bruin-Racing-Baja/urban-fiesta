% analytical_init.m
% 
% InitFcn callback for equiv_analytical.slx
% 
% author: Tyler McCown (tylermccown@engineering.ucla.edu)
% created: 24 January 2021

% shift limits
cvt_low = 4.31;
cvt_high = .81;

wheel_rad = 11.5*.0254; % [m] tire static radius

I_conversion = .0002926397; % [(kg*m^2)/(lbm*in^2)]

% driving side
Ie = .03674; % [kg*m^2] inertia of engine crankshaft and flywheel
Ip = (2*3.952 + 0.256)*I_conversion; % [kg*m^2] inertia of primary sheaves and shaft
I1 = Ie + Ip; % total inertia of driving side
b1 = .01; % [N*m/(rad/s)] total damping of driving side

% driven side
Is = 2*11.23*I_conversion; % [kg*m^2] inertia of secondary sheaves
Ig1 = 0.0546245051*I_conversion; % [kg*m^2] inertia of input gear
Ig2 = 4.424584913*I_conversion; % [kg*m^2] inertia of second gear
Ig3 = 0.1365612627*I_conversion; % [kg*m^2] inertia of third gear
Ig4 = 11.06146228*I_conversion; % [kg*m^2] inertia of final gear
r12 = 48/16; % first reduction
r34 = 48/16; % second reduction
Ic = 4*.32952 + 2*.07131 + 2*.00068 + 4*.00044 + 2*.00004; % [kg*m^2] inertia of rest of drivetrain
I2 = Is + Ig1 + Ig2/r12 + Ig3/r12 + Ig4/(r12*r34) + Ic/(r12*r34); % total inertia of driven side
b2 = .1; % [N*m/(rad/s)] total damping of driven side

% initial conditions
w1_init = 1700*(2*pi/60); % [rad/s] engine speed initial condition
% w2_init = 0*(2*pi/60); % [rad/s] wheel speed initial condition
r_init = cvt_low;
w2_init = w1_init/r_init;