%----------------------------------------------------------------------
%
%  COE-835  Controle adaptativo
%
%  Script para simular exemplo 
%
%  Backstepping  :  n  = 2     Second and third order plant
%                   n* = 2     Relative degree
%                   np = 4, 6     Adaptive parameters
%----------------------------------------------------------------------

global Ay By gamma w A gP gPm;

sim_str = strcat('sim0',num2str(gP_1),'_');
% options = odeset('OutputFcn','odeplot');
options = '';

kp = 1;
km = 1;

Z = [7];
P = [1 -2 1];
ss_H = canon(ss(tf(kp*Z,P)), 'companion'); % Planta
[Ay,By,Cy,~,~] = ctrbf(ss_H.A,ss_H.B,ss_H.C);

Zm = [1];
Pm = [1 2 1];
ss_Hm = canon(ss(tf(km*Zm,Pm)), 'companion'); % Planta
[Aym,Bym,Cym,~,~] = ctrbf(ss_Hm.A,ss_Hm.B,ss_Hm.C);

% Initialization
y0  = 0;
ym0 = 0;
theta0 = [0 0]';
init = [y0' ym0' theta0']';

