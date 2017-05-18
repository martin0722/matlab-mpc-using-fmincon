function [c, ceq] = confun2( x0, dvar, ts, N, beta, optODE)
%CONFUN2 constraint function for continuous linear spline control
f = myfunint2( x0,N,ts,dvar,beta,optODE );

ceq(1) = dvar(2*(N+1)+1) - f(1);
ceq(2) = dvar(2*(N+1)+2) - f(2); % for final position, the value of design 
% varialbes must be the same as the ones come out from integration
c = [];
end