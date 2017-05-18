function J = costfun2( x0, ts, dvar, rho, N, beta, optODE )
%COSTFUN2 cost function for continuous linear spline control
f = myfunint2( x0,N,ts,dvar,beta,optODE );
x1T = dvar(2*(N+1)+1);
x2T = dvar(2*(N+1)+2);
J = rho*((x1T-4)^2+(x2T-4)^2) + f(end);
end