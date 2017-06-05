function [] = plotlane()

x = [0 0 nan -12 12 nan 7 7 nan -7 -7 nan -12 12 nan -12 12];
y = [-12 12 nan 0 0 nan -12 12 nan -12 12 nan 7 7 nan -7 -7];
x_ = [-3.5 -3.5 nan 3.5 3.5 nan -12 12 nan -12 12];
y_ = [-12 12 nan -12 12 nan -3.5 -3.5 nan 3.5 3.5];

plot(x,y,'k',x_,y_,'--k')

end

