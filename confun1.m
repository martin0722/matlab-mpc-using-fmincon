function [c, ceq] = confun1( x0, dvar, ts, N, optODE)
%CONFUN1 constraint function for piecewise constant control
f = myfunint1( x0,N,ts,dvar,optODE );

ceq(1) = dvar(2*N+1) - f(1);
ceq(2) = dvar(2*N+2) - f(2); % for final position, the value of design 
ceq(3) = dvar(2*N+3) - f(3);
% ceq = [];
% varialbes must be the same as the ones come out from integration
c = [];

end