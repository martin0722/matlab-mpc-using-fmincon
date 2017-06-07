function [] = plotlane(numlane)

x = [0 0 nan -12 12 nan 7 7 nan -7 -7 nan -12 12 nan -12 12];
y = [-12 12 nan 0 0 nan -12 12 nan -12 12 nan 7 7 nan -7 -7];
x_ = [-3.5 -3.5 nan 3.5 3.5 nan -12 12 nan -12 12];
y_ = [-12 12 nan -12 12 nan -3.5 -3.5 nan 3.5 3.5];

switch numlane
    case 1
        xc = [0 0 -12 nan 7 7 -12];
        yc = [-12 0 0 nan -12 7 7];
    case 2
        xc = [0 0 -12 nan 7 7 -12];
        yc = [-12 0 0 nan -12 7 7];
    case 3
        xc = [0 0 nan 7 7];
        yc = [-12 12 nan -12 12];
    case 4
        xc = [0 0 nan 7 7];
        yc = [-12 12 nan -12 12];
    case 5
        xc = [0 0 12 nan 7 7 12];
        yc = [-12 0 0 nan -12 -7 -7];
    case 6
        xc = [0 0 12 nan 7 7 12];
        yc = [-12 0 0 nan -12 -7 -7];
    otherwise
        xc = [];
        yc = [];
end
plot(x,y,'k',x_,y_,'--k')
plot(xc,yc,'r','LineWidth',2)


end

