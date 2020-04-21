function init = get_init_struct(theta_0, ll,ex,ey,ez,bx,by,bz,cx,cy,cz,phi_deg,zeta_deg,camber_deg)
    % Defaults
    Rw = 9;
    FO = [-1.1952 3.6250 1.0601]; %constant
    lhub = 4;
    co = 0;
    O = [6.8952 -0.1250 4.7899];

    OA = ll*[cos(deg2rad(theta_0)), 0, sin(deg2rad(theta_0))];
    OB = [bx, by, bz];
    OC = [cx,cy,cz];
    EO = [ex,ey,ez];
    
    AB = OB-OA;
    lk = norm(AB);

    CB = OB - OC;
    lu = norm(CB);
    
    height_of_A = OA(3) + O(3);
    val_up_AB = [0,0,Rw - height_of_A];
    AH_vec = (dot(val_up_AB,AB)/norm(AB)^2)*AB;
    lh = norm(AH_vec);
    
    init.EO = EO;
    init.FO = FO;
    init.CB = CB;
    init.OB = OB;
    init.OC = OC;
    init.ll = ll;
    init.lu = lu;
    init.lk = lk;
    init.lh = lh;
    init.phi_deg = phi_deg;
    init.zeta_deg = zeta_deg;
    init.init_camber_deg = camber_deg;
    init.lhub = lhub;
    init.co = co;
    init.theta_0 = theta_0;
    init.Rw = Rw;
    init.O = O;

end



