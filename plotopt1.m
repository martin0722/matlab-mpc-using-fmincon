function []=plotopt1( x0,xt,topt,xopt,uopt,thetaopt,Np,Nc,rho )
%PLOTOPT1 plot function for piecewise constant control

% Display Optimal Cost


figure; % control signal $u$
plot(topt,uopt,'k-','LineWidth',2)
xlabel('t','fontsize',14)
ylabel('Torque(t)','fontsize',14)
set(gca,'FontSize',12)
title([' Np=',int2str(Np),' Nc=',int2str(Nc),' \rho=',int2str(rho)])
%saveas(gcf,['u(t)_',int2str(ns),'stg.eps'], 'psc2')

figure; % control signal $\theta$
plot(topt,thetaopt,'k-','LineWidth',2)
xlabel('t','fontsize',14)
ylabel('\theta(t)','fontsize',14)
set(gca,'FontSize',12)
title([' Np=',int2str(Np),' Nc=',int2str(Nc),' \rho=',int2str(rho)])

figure; % control signal $\theta$
plot(topt,xopt(:,5),'k-','LineWidth',2)
xlabel('t','fontsize',14)
ylabel('speed(t)','fontsize',14)
set(gca,'FontSize',12)
title([' Np=',int2str(Np),' Nc=',int2str(Nc),' \rho=',int2str(rho)])

figure; % control signal $\theta$
plot(topt,xopt(:,3),'k-','LineWidth',2)
xlabel('t','fontsize',14)
ylabel('\phi(t)','fontsize',14)
set(gca,'FontSize',12)
title([' Np=',int2str(Np),' Nc=',int2str(Nc),' \rho=',int2str(rho)])
end

