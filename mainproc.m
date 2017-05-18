%% Optimal Control Using Control Vector Parameterization
% Control vector parameterization, also known as direct sequential method, 
% is one of the direct optimization methods for solving optimal control 
% problems. The basic idea of direct optimization methods is to discretize
% the control problem, and then apply nonlinear programming (NLP) 
% techniques to the resulting finite-dimensional optimization problem.

%% Problem Statement
% The problem is that you wish to steer from point $A=(0,0)$ at time 
% $t = 0$ to close to point $B=(4,4)$ at time T. The motion takes place in 
% the $x_1, x_2$ plane. Your control variables are thrust $u$ and angle of 
% thrust $\theta$. The angle $\theta$ is measured from the $x_1$ axis. 
% To make life interesting there is large mass at (3,0) that exerts a 
% force proportional to the inverse of the square of the distance you are 
% from the mass. The force points toward the large mass. This force has a 
% parameter $\beta$. The Newtonian formulation in Cartesian coordinates, 
% assuming your mass is 1 and there is no resistance is:
%
% $$\dot{x}_1 = x_3$$
%
% $$\dot{x}_2 = x_4$$
%
% $$\dot{x}_3 = \cos(\theta)u + q_1(x)$$
% 
% $$\dot{x}_4 = \sin(\theta)u + q_2(x)$$
% 
% where 
% 
% $$q_1(x) =
% \frac{\beta(3-x_1)}{(x_2^2+(x_1-3)^2)^{3/2}}, \quad q_2(x) =
% \frac{\beta(-x_2)}{(x_2^2+(x_1-3)^2)^{3/2}}$$
% 
% The cost functional is:
%
% $$J=\rho((x_1(T)-4)^2+(x_2-4)^2)+\int_0^T(10u^2+4\theta^2)dt$$
%
% In addtion, trust is bounded, $|u|\leq 1$, no bound on $\theta$. $T=6$.
clear
clc
%% Parameter Configurations
%
% Remarks: $N$, $\rho$ and $\beta$ are chosen arbitrarily. One can vary 
% these parameters to see its impact on the results.
%
T = 10; % terminal time
N = 5; % number of control stages
rho = 100; % weight on missing the final target
x0 = zeros(4,1); % initial state
ts = 0:(T/N):T;
xt = [5,3,-1*pi];
% Options for ODE & NLP Solvers
optODE = odeset( 'RelTol', 1e-9, 'AbsTol', 1e-9 );
optNLP = optimset( 'LargeScale', 'off', 'GradObj','off', 'GradConstr','off',...
    'DerivativeCheck', 'off', 'Display', 'iter', 'TolX', 1e-9,...
    'TolFun', 1e-9, 'TolCon', 1e-9, 'MaxFunEvals',5000,...
    'DiffMinChange',1e-5,'Algorithm','interior-point');

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

dvar0 = [repmat(0.5,1,N),repmat(-0.1,1,N),xt(1),xt(2),xt(3)]; % design variables contains $N$ pieces of 
% $u$, $N$ pieces of $\theta$ and the final position
lb = -Inf(1,2*N+3); 
lb(1:N) = 0.5; % enforce lower bound on control signal $u$
ub = Inf(1,2*N+3);
ub(1:N) = 10; % enforce upper bound on control signal $u$

% Sequential Approach of Dynamic Optimization
[dvarO,JO] = fmincon(@(dvar) costfun1(x0,xt,ts,dvar,rho,N,optODE),...
    dvar0,[],[],[],[],lb,ub,...
    @(dvar) confun1(x0, dvar, ts, N, optODE),optNLP);
% [dvarO,JO] = fmincon(@(dvar) costfun1(x0,xt,ts,dvar,rho,N,optODE),...
%     dvar0,[],[],[],[],lb,ub,[],optNLP);
% plot
[topt,xopt,uopt,thetaopt] = plotopt1( x0,xt,N,ts,dvarO,rho,optODE );
% animation
M = animateopt( x0,xt,topt,xopt,uopt,thetaopt,N,rho );

%% Continuous linear spline control
% % In this section, control $u$ and $\theta$ are assumed to be continuous 
% % linear spline in each stage of uniform length.
% dvar0 = [repmat(0.5,1,N+1),repmat(-0.1,1,N+1),4,4]; % design variables contains $N+1$ 
% % start and end points of control signal $u$, $\theta$ and the final 
% % position
% lb = -Inf(1,2*(N+1)+2);
% lb(1:N+1) = -1; % enforce lower bound on control signal $u$
% ub = Inf(1,2*(N+1)+2);
% ub(1:N+1) = 1; % enforce upper bound on control signal $u$
% 
% % Sequential Approach of Dynamic Optimization
% [dvarO,JO] = fmincon(@(dvar) costfun2(x0,ts,dvar,rho,N,beta,optODE),...
%     dvar0,[],[],[],[],lb,ub,...
%     @(dvar) confun2(x0, dvar, ts, N, beta, optODE),optNLP);
% 
% % plot
% [topt,xopt,uopt,thetaopt] = plotopt2( x0,N,ts,dvarO,beta,rho,optODE );
% % animation
% M = animateopt( topt,xopt,uopt,thetaopt,beta,N,rho );
