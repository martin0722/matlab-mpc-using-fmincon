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
xc = [10 9.5 9 8.5 8 7.5 7 6.5 6 5.5 5 4.5 4 3.5 3 2.5 2 1.5 1 0.5]+3;
c0 = 3 - (dvar(2*Nc+1:2*Nc+Np)-xc).^2 - (dvar(2*Nc+Np+1:2*Nc+2*Np)-5).^2;
g_lim = 0.3*9.81;
c1 = -g_lim./dvar(1:Nc) + dvar(Nc+1:2*Nc);
c2 = -g_lim./dvar(1:Nc) - dvar(Nc+1:2*Nc);
xc1 = [2.5 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21];
c3 = 3 - (dvar(2*Nc+1:2*Nc+Np)-xc1).^2 - (dvar(2*Nc+Np+1:2*Nc+2*Np)).^2;
c = [c0 c1 c2 c3];% dvar(2*Nc+1:2*Nc+Np)-10.1];
end