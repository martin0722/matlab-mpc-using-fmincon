function dx = dyneqn2( t,x,u,theta,beta,ts,ks )
%DYNEQN2 dynmaic equation of the system with continuous linear spline control
dx = zeros(5,1);
ui = interp1([ts(ks) ts(ks+1)],[u(ks) u(ks+1)],t);
thetai = interp1([ts(ks) ts(ks+1)],[theta(ks) theta(ks+1)],t);
dx(1) = x(3);
dx(2) = x(4);
dx(3) = cos(thetai)*ui + (beta*(3-x(1)))/(x(2)^2+(x(1)-3)^2)^(3/2);
dx(4) = sin(thetai)*ui + (-beta*x(2))/(x(2)^2+(x(1)-3)^2)^(3/2);
dx(5) = 10*ui^2+4*thetai^2;

end