function J = costfun1( x0, xt, ts, dvar, rho, N, optODE )
%COSTFUN1 cost function for piecewise constant control
f = myfunint1( x0,N,ts,dvar,optODE );
x1T = dvar(2*N+1);
x2T = dvar(2*N+2);
x3T = dvar(2*N+3);
J = rho*((x1T-xt(1))^2+(x2T-xt(2))^2+(x3T-xt(3))^2) + f(end);
% J = rho*((f(1)-xt(1))^2+(f(2)-xt(2))^2+(f(3)-xt(3))^2) + f(end);

end