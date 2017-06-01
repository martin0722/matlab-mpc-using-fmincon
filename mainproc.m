clear
clc
%% Parameter Configurations
%
% Remarks: $N$, $\rho$ and $\beta$ are chosen arbitrarily. One can vary 
% these parameters to see its impact on the results.
%
T = 4; % terminal time
Np = 20;
Nc = 20;
Ts = 0.2;
rho = 5; % weight on missing the final target
x0 = zeros(4,1); % initial state
ts = 0:Ts:T;
xt = [10,10,-1*pi];
% Options for ODE & NLP Solvers
optODE = odeset( 'RelTol', 1e-5, 'AbsTol', 1e-5 );
optNLP = optimset( 'LargeScale', 'off', 'GradObj','off', 'GradConstr','off',...
    'DerivativeCheck', 'off', 'Display', 'iter', 'TolX', 1e-1,...
    'TolFun', 1e-1, 'TolCon', 1e-1, 'MaxFunEvals',5000,...
    'DiffMinChange',1e-1,'Algorithm','interior-point');
% optNLP = optimoptions('fmincon','Algorithm','sqp','Display','iter');
%% Piecewise constant control 
% In this section, control $u$ and $\theta$ are assumed to be piecewise
% constant in each stage of uniform length.
%
% Remarks: Due to the nonconvexity of this problem, you may end up with 
% a optimal point that is local. Changing the initial guess _dvar0_, you 
% may get completely different solution. Thus to find global otpimal or 
% multiple local optimal, one can make use of the _multistart_ function 
% from Global Optimization Toolbox. main_multistart.m contains a script 
% as a starting point.

dvar0 = [ones(1,Nc),zeros(1,Nc),x0(1)*ones(1,Np),x0(2)*ones(1,Np),x0(3)*ones(1,Np)]; % design variables contains $N$ pieces of 
% $u$, $N$ pieces of $\theta$ and the final position
lb = -Inf(1,2*Nc+3*Np); 
lb(1:Nc) = 0.1; % enforce lower bound on control signal $u$
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
