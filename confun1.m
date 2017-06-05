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

g_lim = 0.6*9.81;
c0 = -g_lim./dvar(1:Nc) + dvar(Nc+1:2*Nc);
c1 = -g_lim./dvar(1:Nc) - dvar(Nc+1:2*Nc);
c2 = lanecon(dvar,Nc,Np,4);

xc = -9.5:6.5/(Np-1):-3;
c3 = 4 - (dvar(2*Nc+1:2*Nc+Np)-10.5/2).^2 - (dvar(2*Nc+Np+1:2*Nc+2*Np)-xc).^2;

c = [c0 c1 c2 c3];
end