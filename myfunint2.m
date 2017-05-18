function f = myfunint2( x0,N,ts,dvar,beta,optODE )
%MYFUNINT2 integration function for continuous linear spline control
z0 = x0;
u = dvar(1:N+1);
theta = dvar(N+2:2*(N+1));
for ks = 1:N
    [tspan,zs] = ode15s( @(t,x)dyneqn2(t,x,u,theta,beta,ts,ks), ...
        [ts(ks),ts(ks+1)], z0, optODE );
    z0 = zs(end,:)';
end
f = zs(end,:)';

end