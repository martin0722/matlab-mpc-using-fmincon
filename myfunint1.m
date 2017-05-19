function f = myfunint1( x0,Np,Nc,ts,dvar,optODE )
%MYFUNINT1 integration function for piecewise constant control
z0 = x0;
u = dvar(Nc)*ones(1,Np);
u(1:Nc) = dvar(1:Nc);
theta = dvar(2*Nc)*ones(1,Np);
theta(1:Nc) = dvar(Nc+1:2*Nc);
f = zeros(length(x0),Np);
for ks = 1:Np
    [~,zs] = ode15s( @(t,x)dyneqn1(t,x,u,theta,ks), ...
        [ts(ks),ts(ks+1)], z0, optODE );
    z0 = zs(end,:)';
    f(:,ks) = z0;
end

end