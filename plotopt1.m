function []=plotopt1( x0,xt,topt,xopt,uopt,thetaopt,Np,Nc,rho )
%PLOTOPT1 plot function for piecewise constant control

% Display Optimal Cost

figure(1) % state trajectory
plot(xopt(:,1),xopt(:,2),'k-',[x0(1) xt(1)],[x0(2) xt(2)],'ko','LineWidth',2)
hold on
scale_lim = [xopt(:,1);xopt(:,2)];
xlim([min(scale_lim)-1 max(scale_lim)+1]);ylim([min(scale_lim)-1 max(scale_lim)+1]);
xlabel('x_1(t)','fontsize',14)
ylabel('x_2(t)','fontsize',14)
set(gca,'FontSize',12)
title([' Np=',int2str(Np),' Nc=',int2str(Nc),' \rho=',int2str(rho)])
hold off
%saveas(gcf,['x2(x1)_',int2str(ns),'stg.eps'], 'psc2')

figure(2) % control signal $u$
plot(topt,uopt,'k-','LineWidth',2)
xlabel('t','fontsize',14)
ylabel('u(t)','fontsize',14)
set(gca,'FontSize',12)
title([' Np=',int2str(Np),' Nc=',int2str(Nc),' \rho=',int2str(rho)])
%saveas(gcf,['u(t)_',int2str(ns),'stg.eps'], 'psc2')

figure(3) % control signal $\theta$
plot(topt,thetaopt,'k-','LineWidth',2)
xlabel('t','fontsize',14)
ylabel('\theta(t)','fontsize',14)
set(gca,'FontSize',12)
title([' Np=',int2str(Np),' Nc=',int2str(Nc),' \rho=',int2str(rho)])
end

