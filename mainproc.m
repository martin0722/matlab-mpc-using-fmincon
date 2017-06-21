clear
clc
%% Parameter Configurations

T = 8; % terminal time
Np = 20;
Nc = 15;
Ts = T/Np;
rho = 1; % weight on missing the final target
x0 = [3.5/2;-12;0.5*pi;0;3]; % initial state
ts = 0:Ts:T;
xt = lanedest(2);
% Options for ODE & NLP Solvers
optODE = odeset( 'RelTol', 1e-5, 'AbsTol', 1e-5 );
optNLP = optimset( 'LargeScale', 'off', 'GradObj','off', 'GradConstr','off',...
    'DerivativeCheck', 'off', 'Display', 'iter', 'TolX', 1e-4,...
    'TolFun', 1e-4, 'TolCon', 1e-6, 'MaxFunEvals',5000,...
    'DiffMinChange',1e-4,'Algorithm','interior-point');

%% Piecewise constant control 

dvar0 = [4*ones(1,Nc),zeros(1,Nc),x0(1)*ones(1,Np),x0(2)*ones(1,Np),x0(5)*ones(1,Np),x0(3)]; % design variables contains $N$ pieces of 
% dvar0 = [4*ones(1,Nc),zeros(1,Nc),x0(1)*ones(1,Np),x0(2)*ones(1,Np),x0(3)];
% $u$, $N$ pieces of $\theta$ and the final position
lb = -Inf(1,2*Nc+3*Np+1); 
lb(1:Nc) = -1000; %Min Torque
lb(Nc+1:2*Nc) = -45/180*pi; %Min steer
lb(2*Nc+2*Np+1:2*Nc+3*Np) = 0; %Min speed
ub = Inf(1,2*Nc+3*Np+1);
ub(1:Nc) = 1000; %Max Torque
ub(Nc+1:2*Nc) = 45/180*pi; %Max steer
ub(2*Nc+2*Np+1:2*Nc+3*Np) = 5; %Max speed

topt = [];
xopt = [];
uopt = [];
thetaopt = [];
z0 = x0;

% Sequential Approach of Dynamic Optimization
[dvarO,JO] = fmincon(@(dvar) costfun1(z0,xt,ts,dvar,rho,Np,Nc,optODE),...
    dvar0,[],[],[],[],lb,ub,...
    @(dvar) confun1(z0, dvar, ts, Np, Nc, optODE),optNLP);


uO = dvarO(Nc)*ones(1,Np);
uO(1:Nc) = dvarO(1:Nc);
thetaO = dvarO(2*Nc)*ones(1,Np);
thetaO(1:Nc) = dvarO(Nc+1:2*Nc);
for i = 1:T/Ts
    u = uO(i);
    theta = thetaO(i);
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
