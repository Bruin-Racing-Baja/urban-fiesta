% belt_length_calcs.m
% 
% calculates 3-tuples of (primary radius, secondary radius, cvt ratio)
% based on belt length and center-to-center distance
% 
% author: Tyler McCown (tylermccown@engineering.ucla.edu)
% created: 27 January 2021

clear;
clc;

L = 39.99469; % [in] belt cord length
c = 10.5; % [in] primary-secondary center-to-center distance
r_prim_min = .75; % [in] primary sheave minimum radius
r_prim_max = 3.5; % [in] primary sheave maximum radius
r_sec_min = 2.02; % [in] secondary sheave minimum radius
r_sec_max = 4.6; % [in] secondary sheave maximum radius

n = 100; % number of points to calculate
r_prim = linspace(r_prim_min, r_prim_max, n); % vector of primary radius values
r_sec = zeros(size(r_prim));
r_sec(1) = r_sec_max;

% symbolic equation relating belt geometry and sheave radii
syms r1 r2;
Leq = pi*(r1 + r2) + 2*(r2 - r1)*asin((r2 - r1)/c) + 2*sqrt(c^2 - (r2 - r1).^2) - L;

% numerically solve secondary radius from primary radius
for i = 2:length(r_prim)
    r_sec(i) = vpasolve(subs(Leq, r1, r_prim(i)), r2, r_sec(i-1));
end
r_sec(1) = vpasolve(subs(Leq, r1, r_prim(1)), r2, r_sec(1));
r_sec = abs(r_sec);

% calculate ratio
cvt_rat = r_sec./r_prim;

% plot results
figure(1);
subplot(311);
plot(r_prim, r_sec);
grid on;
xlabel('primary radius [in]');
ylabel('secondary radius [in]');
subplot(312);
plot(r_prim, cvt_rat);
grid on;
xlabel('primary radius [in]');
ylabel('cvt ratio');
subplot(313);
plot(r_sec, cvt_rat);
grid on;
xlabel('secondary radius [in]');
ylabel('cvt ratio');

error = zeros(size(r_prim));
for i = 1:length(r_prim)
    error(i) = pi*(r_prim(i) + r_sec(i)) + 2*(r_sec(i) - r_prim(i))*asin((r_sec(i) - r_prim(i))/c) + 2*sqrt(c^2 - (r_sec(i) - r_prim(i)).^2) - L;
end

% check numerical error
figure(2);
plot(1:length(r_prim), error);
grid on;
ylabel('numerical solution error [in]');

UA413_belt_data = struct();
UA413_belt_data.cord_length = L;
UA413_belt_data.center_to_center = c;
UA413_belt_data.primary_radius = r_prim;
UA413_belt_data.secondary_radius = r_sec;
UA413_belt_data.cvt_ratio = cvt_rat;
UA413_belt_data.description = 'Belt geometry for the UA413 belt calculated using belt_length_calcs.m. All length units are inches.';
