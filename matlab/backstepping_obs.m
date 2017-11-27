%----------------------------------------------------------------------
%
%  COE-835  Controle adaptativo
%
%  Script para simular o trabalho 7
%
%  Backstepping  :  n  = 2     Second and third order plant
%                   n* = 2     Relative degree
%                   np = 3     Adaptive parameters
% Caso com observador completo
%----------------------------------------------------------------------

function dx = backstepping_obs(t,x)

global A B thetas A0 c1 c2 d1 d2 Gamma gamma kp a w e1 e2 k;

y           = x(1:2);
theta       = x(3:5);
lambda      = x(6:7);
eta         = x(8:9);
rho         = x(10);

%% Input
yr = a(1) * sin(w(1)*t) + a(2) * sin(w(2)*t);
dyr = a(1) * w(1) * cos(w(1)*t) + a(2) * w(2) * cos(w(2)*t);
ddyr = -a(1) * w(1)^2 * sin(w(1)*t) - a(2) * w(2)^2 * sin(w(2)*t);

Phi = [-y(1) 0;0 -y(1)];

%% Variables 1
xi = -A0^2 * eta;
Xi = -[A0*eta eta];
v1 = lambda(1);
v2 = lambda(2);
omega_bar = [0, (Xi(2,:) - y(1)*e1')]';
omega = [v2, (Xi(2,:) - y(1)*e1')]';

%% Z
z1 = y(1) - yr;
alpha_bar = -c1*z1 - d1*z1 - xi(2) - omega_bar'*theta;
alpha_1 = rho * alpha_bar;
z2 = v2 - rho*dyr - alpha_1;

%% Filtro eta
deta = A0*eta + e2*y(1);

%% dalpha/dt
dady = rho * (- c1 - d1 + [0,e1']*theta);
dadeta_deta = rho * (e2' * A0^2 * deta + [0,e2'*A0*deta, e2'*eye(2)*deta]*theta);
dadyr = rho*(c1 + d1);
dadtheta = - rho * omega_bar';
dadrho = -(c1 + d1)*z1 - e2'*xi - omega_bar'*theta;


%% Variables 2
tau_1 = (omega - rho*(dyr + alpha_bar)*[e1',0]')*z1;
tau_2 = tau_1 - z2 * (dady * omega); 


%% Atualização dos parâmetros
dtheta = Gamma * tau_2;
drho = - gamma * z1 * sign(kp) * (dyr + alpha_bar);
beta = k(2)*v1 + dady * (xi(2) + omega'*theta) + ...
    dadeta_deta + dadyr * dyr + (dyr + dadrho) * drho;
u = -c2*z2 + beta + rho*ddyr + dadtheta*dtheta - d2*z2*(dady)^2 - ...
    z1*theta(1);

%% Filtros
dlambda = A0*lambda + e2*u;



%% Planta
F = [B*u Phi];
dy = A*y + F*thetas;

%% Translation
dx = [dy' dtheta' dlambda' deta' drho]';    
