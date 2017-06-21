function dx = dyneqn1( t,x,u,theta,ks )
%DYNEQN1 dynmaic equation of the system with piecewise constant control

M = 1376;
Re = 0.274;
Lf = 1.5;
Lr = 1.115;

% dx = zeros(4,1);
% dx(1) = cos(x(3))*u(ks);
% dx(2) = sin(x(3))*u(ks);
% dx(3) = theta(ks);
% dx(4) = theta(ks)^2;

dx = zeros(5,1);
dx(1) = x(5)*cos(x(3));
dx(2) = x(5)*sin(x(3));
dx(3) = x(5)*tan(theta(ks))/(Lf+Lr);
dx(4) = theta(ks)^2;
dx(5) = u(ks)/Re/M;


end