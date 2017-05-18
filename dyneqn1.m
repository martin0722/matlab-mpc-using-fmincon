function dx = dyneqn1( t,x,u,theta,ks )
%DYNEQN1 dynmaic equation of the system with piecewise constant control
dx = zeros(3,1);
dx(1) = cos(x(3))*u(ks);
dx(2) = sin(x(3))*u(ks);
dx(3) = theta(ks);
dx(4) = 10*u(ks)^2 + 4*theta(ks)^2;

end