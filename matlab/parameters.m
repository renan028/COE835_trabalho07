clear;
clc;
close all;
global A w;

PRINT = true;
% PRINT = false;

%Simulation time
tfinal = 60;

%Reference
w = [1 3];
a = [1 1];

% Unit vectors
e1 = [1 0]';
e2 = [0 1]';

% System matrix
A = [0 1;0 0];

%% First parameters

kp_1 = 5;
Z_1 = [1];
P_1 = [1 2 1];

k_1 = [1 1]';

a_1 = [1 1];
w_1 = [1 3];

%Initial conditions
y0_1  = [0 0]';
theta0_1 = [0 0 0]';
eta0_1 = [0 0]';
lambda0_1 = [0 0]';
rho0_1 = 0.5;

%Adaptation gain
Gamma_1 = eye(3);
gamma_1 = 1;
c1_1 = 1;
c2_1 = 1;
d1_1 = 1;
d2_1 = 1;

%% Second parameters

kp_2 = 5;
Z_2 = [1];
P_2 = [1 2 1];

k_2 = [1 1]';

a_2 = [1 1];
w_2 = [1 3];

%Initial conditions
y0_2  = [5 0]';
theta0_2 = [0 0 0]';
eta0_2 = [0 0]';
lambda0_2 = [0 0]';
rho0_2 = 0.5;

%Adaptation gain
Gamma_2 = eye(3);
gamma_2 = 1;
c1_2 = 1;
c2_2 = 1;
d1_2 = 1;
d2_2 = 1;