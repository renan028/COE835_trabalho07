%----------------------------------------------------------------------
%
%  COE-835  Controle adaptativo
%
%  Script para simular exemplo 
%
%  Backstepping  :  n  = 2     Second and third order plant
%                   n* = 2     Relative degree
%                   np = 4, 6     Adaptive parameters
% Com observador completo
%----------------------------------------------------------------------
clear all
clc

global A B thetas A0 c1 c2 d1 d2 Gamma gamma kp a w e1 e2 k;

kp = 5;
Z = [1];
P = [1 2 1];

thetas = [kp P(2) P(3)]';
B = [0 kp]';

e1 = [1 0]';
e2 = [0 1]';
k = [1 1]';
A = [0 1;0 0];
A0 = A - k*e1';

a = [1 1];
w = [1 3];
c1 = 1;
c2 = 1;
d1 = 1;
d2 = 1;
Gamma = eye(3);
gamma = 1;
tfinal = 50;

% Initialization
y0  = [0 0]';
theta0 = [0 0 0]';
eta0 = [0 0]';
lambda0 = [0 0]';
rho0 = 0.5;
init = [y0' theta0' lambda0' eta0' rho0]';

%% Plots
[T,X] = ode23s('backstepping_obs',tfinal,init,'');

y      = X(:,1);

yr = a(1)*sin(w(1).*T) + a(2)*sin(w(2).*T);
e =  y - yr;

%Set matlab interpreter to latex
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');
set(groot, 'defaultTextInterpreter','latex');

figure(1)
clf
plot(T,y,T,yr);grid;shg
legend('y','yr','Location','SouthEast')
title('$\epsilon$')
print -depsc2 en3t0
%---------------------------------------------------------------------
