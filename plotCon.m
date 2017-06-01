function [] = plotCon(x,y)

theta = 0:2*pi/100:2*pi;
R = 3^0.5;
plot(R*cos(theta)+x,R*sin(theta)+y)


end

