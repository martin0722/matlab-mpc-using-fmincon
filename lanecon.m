function c = lanecon(dvar,Nc,Np,numlane)

x = dvar(2*Nc+1:2*Nc+Np);
y = dvar(2*Nc+Np+1:2*Nc+2*Np);

switch numlane
    case 1
        F(1,:) = parlcon(x,0,3.5);
        F(2,:) = parlcon(y,0,3.5);
        c = min(F);
    case 2
        F(1,:) = parlcon(x,0,3.5);
        F(2,:) = parlcon(y,3.5,7);
        c = min(F);
    case 3
        c = parlcon(x,0,3.5);
    case 4
        c = parlcon(x,3.5,7);
    case 5
        F(1,:) = parlcon(x,3.5,7);
        F(2,:) = parlcon(y,-3.5,0);
        c = min(F);
    case 6
        F(1,:) = parlcon(x,3.5,7);
        F(2,:) = parlcon(y,-7,-3.5);
        c = min(F);
    otherwise
        c = [];

end

