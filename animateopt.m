function M = animateopt( x0,xt,topt,xopt,uopt,thetaopt,Np,Nc,rho )
%ANIMATEOPT animate the optimal state trajectory
[toptu, idx] = unique(topt);
xoptu = xopt(idx,:); %unique(xopt,'rows');
uoptu = uopt(idx);
thetaoptu = thetaopt(idx); % remove duplicate values
t = 0:0.1:topt(end);
xoi = interp1(toptu,xoptu,t);
uoi = interp1(toptu,uoptu,t); % trust $u$
haoi = xoi(:,3);
toi = interp1(toptu,thetaoptu,t) + haoi'; % trust angle $\theta$

figure;
xc = [10 9 8 7 6 5 4 3 2 1 1]+3;
xc1 = [2.5 2.6 2.7 2.8 2.9 3 3.1 3.2 3.3 3.4 3.5 3.6 3.7 3.8 4 4.2 4.4 4.6 4.8 5];
xc_ = interp1(1:11,xc,1:10/length(t):11);
xc1_ = interp1(1:20,xc1,1:19/length(t):20);
for k=1:length(t)
    % contruct the shape of a boat around the point with respect to 
    % heading angle
    bx= xoi(k,1)+ [0.2*cos(haoi(k)-0.5) 0.3*cos(haoi(k)) ...
        0.2*cos(haoi(k)+0.5) 0.2*cos(haoi(k)-0.5) ...
        -0.2*cos(haoi(k)+0.5) -0.3*cos(haoi(k)) ...
        -0.2*cos(haoi(k)-0.5) -0.2*cos(haoi(k)+0.5) ...
        -0.2*cos(haoi(k)-0.5) 0.2*cos(haoi(k)+0.5)];
    by= xoi(k,2)+ [0.2*sin(haoi(k)-0.5) 0.3*sin(haoi(k)) ...
        0.2*sin(haoi(k)+0.5) 0.2*sin(haoi(k)-0.5) ...
        -0.2*sin(haoi(k)+0.5) -0.3*sin(haoi(k)) ...
        -0.2*sin(haoi(k)-0.5) -0.2*sin(haoi(k)+0.5) ...
        -0.2*sin(haoi(k)-0.5) 0.2*sin(haoi(k)+0.5)];
    plot(xoi(1:k,1),xoi(1:k,2),'b-',bx,by,'b-',[x0(1) xt(1)],[x0(2) xt(2)],'ko',...
    [xoi(k,1),xoi(k,1)+uoi(k)/max(abs(uoptu))*cos(toi(k))],...
        [xoi(k,2),xoi(k,2)+uoi(k)/max(abs(uoptu))*sin(toi(k))],...
        'r','LineWidth',2); % using red dotted line to denote direction of
    % the trust, and its length is proportional to the control effort $u$
    hold on
    plotCon(xc1_(k),0)
    plotCon(xc_(k),5)
    hold off
    xlabel('x_1(t)','fontsize',14)
    ylabel('x_2(t)','fontsize',14)
    set(gca,'FontSize',12)
    title([' Np=',int2str(Np),' Nc=',int2str(Nc),' \rho=',int2str(rho)])
    scale_lim = [xopt(:,1);xopt(:,2)];
    xlim([min(scale_lim)-1 max(scale_lim)+1]);ylim([min(scale_lim)-1 max(scale_lim)+1]);
    axis square;
    M(k) = getframe(gcf);
end
vid = VideoWriter(['simulation', num2str(rand(1,1))]);
vid.Quality = 100;
vid.FrameRate = 8;
open(vid)
writeVideo(vid,M);
close(vid)
end

