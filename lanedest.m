function xt = lanedest(numlane)

switch numlane
    case 1
        xt = [-12,3.5/2,pi];
    case 2
        xt = [-12,10.5/2,pi];
    case 3
        xt = [3.5/2,12,0.5*pi];
    case 4
        xt = [10.5/2,12,0.5*pi];
    case 5
        xt = [12,-3.5/2,0];
    case 6
        xt = [12,-10.5/2,0];
    otherwise
        xt = [];

end

