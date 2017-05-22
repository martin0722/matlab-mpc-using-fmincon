function [c, ceq] = confun1( x0, dvar, ts, Np, Nc, optODE)
%CONFUN1 constraint function for piecewise constant control
f = myfunint1( x0,Np,Nc,ts,dvar,optODE );

% for final position, the value of design 
ceq = zeros(1,3*Np);
ceq(1:Np) = dvar(2*Nc+1:2*Nc+Np) - f(1,:);
ceq(Np+1:2*Np) = dvar(2*Nc+Np+1:2*Nc+2*Np) - f(2,:);
ceq(2*Np+1:3*Np) = dvar(2*Nc+2*Np+1:2*Nc+3*Np) - f(3,:);

% varialbes must be the same as the ones come out from integration
% c = [];
c = 3 - (dvar(2*Nc+1:2*Nc+Np)-4).^2 - (dvar(2*Nc+Np+1:2*Nc+2*Np)-2).^2;

end