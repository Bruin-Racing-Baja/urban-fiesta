% analytical_esc_ga.m
% 
% runs a genetic algorithm to tune an extremum-seeking controller based on
% maximizing wheel speed. works with analytical_fitness.m
% 
% author: Tyler McCown (tylermccown@engineering.ucla.edu
% created: 3 February 2021

clear;
clc;

T_max = 30;     % [s] simulation duration
ts = .01;       % [s] fixed simulation timestep

options = optimoptions(@ga, ...
    'PopulationSize', 25, ...
    'MaxGenerations', 100); %, ...
%     'OutputFcn', @ga_output);

% parameter vector:
% controller gain [rpm/rad]
% perturbation frequency [rad/s]
% perturbation amplitude [rpm]
% high pass cutoff frequency [rad/s]
% demodulation phase shift [rad]
lb = [.1, .01*2*pi, 100, 1, -180];
ub = [Inf, 10*2*pi, 500, 100, 180];

t_start = tic;
[esc_params, fitness_val] = ga(@(K)analytical_fitness(T_max, ts, K), 5, [], [], [], [], lb, ub, [], options);
t_stop = toc(t_start);

esc_params
fitness_val
