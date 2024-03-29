% analytical_init.m
% 
% InitFcn callback for equiv_analytical.slx
% 
% author: Tyler McCown (tylermccown@engineering.ucla.edu)
% created: 24 January 2021

% shift limits
cvt_low = 4.31; % cvt engagement ratio
cvt_high = .81; % cvt overdrive ratio
r_prim_min = 1.066987364; % [in] primary sheave minimum radius
r_prim_max = 3.339987364; % [in] primary sheave maximum radius
sheave_angle = 13; % [deg] primary sheave angle

% actuator
motor_max = 3360; % [rpm] maximum actuator motor angular velocity
lead = .003; % [m/rev] ball screw lead
shift_fork_amp = 3.12; % shift fork amplification
dr1_max = motor_max/60*lead/shift_fork_amp/tand(sheave_angle); % [m/s] maximum actuator linear speed

% whole vehicle
m = 410/2.2; % [kg] vehicle mass
W = m*9.8; % [N] vehicle weight
wheel_rad = 11.5*.0254; % [m] tire static radius
cont_pat = 1.8*.0254; % [m] tire contact patch half-length
wheel_rad_def = sqrt(wheel_rad^2 - cont_pat^2); % [m] tire deformed radius
cd = 1.12; % drag coefficient
A = 3; % [m^2] frontal area
rho = 1.18; % [kg/m^3] air density
drag_coeff = .5*cd*A*rho; % [N/(m/s)^2] multiply this by velocity to get drag force

I_conversion = .0002926397; % [(kg*m^2)/(lbm*in^2)]

% driving side
Ie = .03674; % [kg*m^2] inertia of engine crankshaft and flywheel
Ip = (2*3.952 + 0.256)*I_conversion; % [kg*m^2] inertia of primary sheaves and shaft
I1 = Ie + Ip; % total inertia of driving side
b1 = .001; % [N*m/(rad/s)] total damping of driving side

% driven side
Is = 2*11.23*I_conversion; % [kg*m^2] inertia of secondary sheaves
Ig1 = 0.0546245051*I_conversion; % [kg*m^2] inertia of input gear
Ig2 = 4.424584913*I_conversion; % [kg*m^2] inertia of second gear
Ig3 = 0.1365612627*I_conversion; % [kg*m^2] inertia of third gear
Ig4 = 11.06146228*I_conversion; % [kg*m^2] inertia of final gear
r12 = 48/16; % first reduction
r34 = 48/16; % second reduction
Ic = 2*(2*.32952 + 2*.07131 + 2*.00068 + 4*.00044 + 2*.00004); % [kg*m^2] inertia of rest of drivetrain
I2 = Is + Ig1 + Ig2/r12 + Ig3/r12 + Ig4/(r12*r34) + Ic/(r12*r34); % total inertia of driven side
b2 = .01; % [N*m/(rad/s)] total damping of driven side

% initial conditions
r_init = cvt_low; % cvt ratio initial condition
w1_init = 1700*(2*pi/60); % [rad/s] engine speed initial condition
w2_init = w1_init/r_init; % [rad/s] wheel speed initial condition
