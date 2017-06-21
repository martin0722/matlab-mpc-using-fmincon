function J = costfun1( x0, xt, ts, dvar, rho, Np, Nc, optODE )
%COSTFUN1 cost function for piecewise constant control
f = myfunint1( x0,Np,Nc,ts,dvar,optODE );

dx1T = (dvar(2*Nc+Np) - xt(1))^2;
dx2T = (dvar(2*Nc+2*Np) - xt(2))^2;
dx3T = (dvar(2*Nc+3*Np+1) - xt(3))^2;

J = rho*(dx1T + dx2T + dx3T) + 10*f(4,end);

end