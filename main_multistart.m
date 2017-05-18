% Options for ODE & NLP Solvers
optODE = odeset( 'RelTol', 1e-9, 'AbsTol', 1e-9 );
optNLP = optimset( 'LargeScale', 'off', 'GradObj','off', 'GradConstr','off',...
    'DerivativeCheck', 'off', 'Display', 'iter', 'TolX', 1e-9,...
    'TolFun', 1e-9, 'TolCon', 1e-9, 'MaxFunEvals',10000,...
    'DiffMinChange',1e-5,'Algorithm','interior-point');

T = 6;
N = 3;
rho = 100;
beta = 1;
x0 = zeros(5,1);
ts = 0:(T/N):T;

%% 
dvar0 = [repmat(0.5,1,2*N),4,4];
lb = -Inf(1,2*N+2);
lb(1:N) = -1;
ub = Inf(1,2*N+2);
ub(1:N) = 1;

problem = createOptimProblem('fmincon',...
    'objective',@(dvar)costfun1(x0,ts,dvar,rho,N,beta,optODE),...
    'x0',dvar0,'options',optNLP,'lb',lb,'ub',ub,...
    'nonlcon',@(dvar) confun1(x0, dvar, ts, N, beta, optODE));

% [dvarO,JO] = fmincon(problem);

ms = MultiStart('StartPointsToRun','bounds');
stpoints = RandomStartPointSet('NumStartPoints',10, ...
    'ArtificialBound',10);

[dvarO,JO,flag,outpt,allmins] = run(ms,problem,stpoints);

%% 
dvar0 = [repmat(0.2,1,2*(N+1)),4,4];
lb = -Inf(1,2*(N+1)+2);
lb(1:N+1) = -1;
ub = Inf(1,2*(N+1)+2);
ub(1:N+1) = 1;

problem = createOptimProblem('fmincon',...
    'objective',@(dvar)costfun2(x0,ts,dvar,rho,N,beta,optODE),...
    'x0',dvar0,'options',optNLP,'lb',lb,'ub',ub,...
    'nonlcon',@(dvar) confun2(x0, dvar, ts, N, beta, optODE));
 
% [dvarO,JO] = fmincon(problem);

ms = MultiStart('StartPointsToRun','bounds');
stpoints = RandomStartPointSet('NumStartPoints',10, ...
    'ArtificialBound',10);

[dvarO,JO,flag,outpt,allmins] = run(ms,problem,stpoints);