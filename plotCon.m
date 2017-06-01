function [] = plotCon()

theta = 0:2*pi/100:2*pi;
R = 3^0.5;
plot(R*cos(theta)+8,R*sin(theta)+8)


end

