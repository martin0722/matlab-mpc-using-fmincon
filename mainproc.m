clear
clc
%% Parameter Configurations

T = 8; % terminal time
Np = 20;
Nc = 20;
Ts = T/Np;
rho = 3; % weight on missing the final target
x0 = [3.5/2;-12;0.5*pi;0]; % initial state
ts = 0:Ts:T;
xt = lanedest(1);
% Options for ODE & NLP Solvers
optODE = odeset( 'RelTol', 1e-5, 'AbsTol', 1e-5 );
optNLP = optimset( 'LargeScale', 'off', 'GradObj','off', 'GradConstr','off',...
    'DerivativeCheck', 'off', 'Display', 'iter', 'TolX', 1e-2,...
    'TolFun', 1e-2, 'TolCon', 1e-2, 'MaxFunEvals',5000,...
    'DiffMinChange',1e-2,'Algorithm','interior-point');

%% Piecewise constant control 

dvar0 = [ones(1,Nc),zeros(1,Nc),x0(1)*ones(1,Np),x0(2)*ones(1,Np),x0(3)*ones(1,Np)]; % design variables contains $N$ pieces of 
% $u$, $N$ pieces of $\theta$ and the final position
lb = -Inf(1,2*Nc+3*Np); 
lb(1:Nc) = 1; % enforce lower bound on control signal $u$
ub = Inf(1,2*Nc+3*Np);
ub(1:Nc) = 5; % enforce upper bound on control signal $u$

topt = [];
xopt = [];
uopt = [];
thetaopt = [];
z0 = x0;

% Sequential Approach of Dynamic Optimization
[dvarO,JO] = fmincon(@(dvar) costfun1(z0,xt,ts,dvar,rho,Np,Nc,optODE),...
    dvar0,[],[],[],[],lb,ub,...
    @(dvar) confun1(z0, dvar, ts, Np, Nc, optODE),optNLP);

for i = 1:T/Ts
    u = dvarO(i);
    theta = dvarO(Nc+i);
    [tspan,zs] = ode15s( @(t,x)dyneqn1(t,x,u,theta,1), ...
            [ts(i),ts(i+1)], z0, optODE );
    z0 = zs(end,:)';
    topt = [ topt; tspan ];
    xopt = [ xopt; zs ];
    uopt = [ uopt; u*ones(length(tspan),1) ];
    thetaopt = [thetaopt; theta*ones(length(tspan),1) ];
end

plotopt1( x0,xt,topt,xopt,uopt,thetaopt,Np,Nc,rho);
% animation
M = animateopt( x0,xt,topt,xopt,uopt,thetaopt,Np,Nc,rho );
