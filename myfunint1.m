function f = myfunint1( x0,N,ts,dvar,optODE )
%MYFUNINT1 integration function for piecewise constant control
z0 = x0;
u = dvar(1:N);
theta = dvar(N+1:2*N);

for ks = 1:N
    [tspan,zs] = ode15s( @(t,x)dyneqn1(t,x,u,theta,ks), ...
        [ts(ks),ts(ks+1)], z0, optODE );
    z0 = zs(end,:)';
end
f = zs(end,:)';

end