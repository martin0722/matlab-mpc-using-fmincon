function [topt,xopt,uopt,thetaopt]=plotopt2( x0,N,ts,dvarO,beta,rho,optODE )
%PLOTOPT2 plot function for continuous linear spline control
z0 =  x0;
topt = [];
xopt = [];
uopt = [];
thetaopt = [];
u = dvarO(1:N+1);
theta = dvarO(N+2:2*(N+1));
[x,y]=meshgrid(-1:0.5:5);
fx = (beta*(3-x))./((y.^2+(x-3).^2).^(3/2)); % force along x axis
fy = (-beta*y)./((y.^2+(x-3).^2).^(3/2)); % force along y axis

% forward state integration
for ks = 1:N
    [tspan,zs] = ode15s( @(t,x)dyneqn2(t,x,u,theta,beta,ts,ks), ...
        [ts(ks),ts(ks+1)], z0, optODE );
    z0 = zs(end,:)';
    topt = [ topt; tspan ];
    xopt = [ xopt; zs ];
    uopt = [ uopt; interp1([ts(ks) ts(ks+1)],[u(ks) u(ks+1)],tspan); ];
    thetaopt = [thetaopt; interp1([ts(ks) ts(ks+1)],[theta(ks) theta(ks+1)],tspan) ];
end

% Display Optimal Cost
disp(sprintf('Optimal cost for N=%d: %d', N, zs(end,5)));
figure(1) % state trajectory
plot(xopt(:,1),xopt(:,2),'k-',[0 3 4],[0 0 4],'ko','LineWidth',2)
hold on
quiver(x,y,fx,fy,1,'LineWidth',2,'Color','black') % force vector field
axis([-1 5 -1 5]);
xlabel('x_1(t)','fontsize',14)
ylabel('x_2(t)','fontsize',14)
set(gca,'FontSize',12)
title(['\beta=',int2str(beta),' N=',int2str(N),' \rho=',num2str(rho)])
hold off
%saveas(gcf,['x2(x1)_',int2str(ns),'stg.eps'], 'psc2')

figure(2) % control signal $u$
plot(topt,uopt,'k-','LineWidth',2)
xlabel('t','fontsize',14)
ylabel('u(t)','fontsize',14)
set(gca,'FontSize',12)
title(['\beta=',int2str(beta),' N=',int2str(N),' \rho=',num2str(rho)])
%saveas(gcf,['u(t)_',int2str(ns),'stg.eps'], 'psc2')

figure(3) % control signal $\theta$
plot(topt,thetaopt,'k-','LineWidth',2)
xlabel('t','fontsize',14)
ylabel('\theta(t)','fontsize',14)
set(gca,'FontSize',12)
title(['\beta=',int2str(beta),' N=',int2str(N),' \rho=',num2str(rho)])
end

