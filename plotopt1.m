function [topt,xopt,uopt,thetaopt]=plotopt1( x0,xt,N,ts,dvarO,rho,optODE )
%PLOTOPT1 plot function for piecewise constant control
z0 =  x0;
topt = [];
xopt = [];
uopt = [];
thetaopt = [];
u = dvarO(1:N);
theta = dvarO(N+1:2*N);

% forward state integration
for ks = 1:N
    [tspan,zs] = ode15s( @(t,x)dyneqn1(t,x,u,theta,ks), ...
        [ts(ks),ts(ks+1)], z0, optODE );
    z0 = zs(end,:)';
    topt = [ topt; tspan ];
    xopt = [ xopt; zs ];
    uopt = [ uopt; u(ks)*ones(length(tspan),1) ];
    thetaopt = [thetaopt; theta(ks)*ones(length(tspan),1) ];
end

% Display Optimal Cost
disp(sprintf('Optimal cost for N=%d: %d', N, zs(end,4)));
figure(1) % state trajectory
plot(xopt(:,1),xopt(:,2),'k-',[x0(1) xt(1)],[x0(2) xt(2)],'ko','LineWidth',2)
hold on
scale_lim = [xopt(:,1);xopt(:,2)];
xlim([min(scale_lim)-1 max(scale_lim)+1]);ylim([min(scale_lim)-1 max(scale_lim)+1]);
xlabel('x_1(t)','fontsize',14)
ylabel('x_2(t)','fontsize',14)
set(gca,'FontSize',12)
title([' N=',int2str(N),' \rho=',num2str(rho)])
hold off
%saveas(gcf,['x2(x1)_',int2str(ns),'stg.eps'], 'psc2')

figure(2) % control signal $u$
plot(topt,uopt,'k-','LineWidth',2)
xlabel('t','fontsize',14)
ylabel('u(t)','fontsize',14)
set(gca,'FontSize',12)
title([' N=',int2str(N),' \rho=',num2str(rho)])
%saveas(gcf,['u(t)_',int2str(ns),'stg.eps'], 'psc2')

figure(3) % control signal $\theta$
plot(topt,thetaopt,'k-','LineWidth',2)
xlabel('t','fontsize',14)
ylabel('\theta(t)','fontsize',14)
set(gca,'FontSize',12)
title([' N=',int2str(N),' \rho=',num2str(rho)])
end

