function J = costfun1( x0, xt, ts, dvar, rho, Np, Nc, optODE )
%COSTFUN1 cost function for piecewise constant control
f = myfunint1( x0,Np,Nc,ts,dvar,optODE );
x1T = dvar(2*Nc+10:2*Nc+Np);
x2T = dvar(2*Nc+Np+10:2*Nc+2*Np);
x3T = dvar(2*Nc+2*Np+1:2*Nc+3*Np);
dx1T = x1T - xt(1);
dx2T = x2T - xt(2);
dx3T = x3T - xt(3);


J = rho*(dx1T*dx1T' + dx2T*dx2T' + 0*(dx3T*dx3T')) + sum(f(end,:));

end