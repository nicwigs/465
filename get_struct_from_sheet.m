function init = get_struct_from_sheet(name,sheet)

    %name = 'points.xlsx'
    %sheet = 'Front Suspension'
    T = xlsread(name,sheet);
    
    init_camber_deg = -0.2;
    % reads excel different if PC
    if ispc()
        table_offset = 12;
    else
        table_offset = 0;
    end
    
    % y is trackwidth, x is wheel base
    chas_lowfor = T(13-table_offset,1:3);
    chas_lowaft = T(14-table_offset,1:3);
    chas_upfor = T(15-table_offset,1:3);
    chas_upaft = T(16-table_offset,1:3);
    up_lowp = T(17-table_offset,1:3);
    up_upp = T(18-table_offset,1:3);
    chas_tie = T(19-table_offset,1:3);
    up_tie = T(20-table_offset,1:3);
    chas_pull = T(25-table_offset,1:3);
    up_pull = T(24-table_offset,1:3);

    % find a point on line connecting chas_lowaft and chas_lowfor that has same
    % x value as point A, so in plane. 
    % line connecting points is (chas_lowfor-chas_lowaft)*t + chas_lowaft = l
    t = (up_lowp(1)-chas_lowaft(1))/(chas_lowfor(1) - chas_lowaft(1));
    O = (chas_lowfor-chas_lowaft)*t+chas_lowaft; %becomes origin
    
    OA = up_lowp-O;
    ll = norm(OA);

    theta_0 = rad2deg(atan(OA(3)/(OA(2))));

    AB = up_upp-up_lowp;
    lk = norm(AB);

    C = (chas_upfor+chas_upaft)/2;
    chas_upper_line = (chas_upfor -O) - (chas_upaft - O);
    zeta_deg = rad2deg(atan(chas_upper_line(2)/chas_upper_line(1)));
    phi_deg = rad2deg(atan(chas_upper_line(3)/chas_upper_line(1)));

    OC = C-O;
    OB = up_upp - O;

    CB = OB - OC;
    lu = norm(CB);


    EO = up_tie-O;  %upright tie point rel to new origin
    FO = chas_tie - O;  %chassis tie point rel to new origin

    Rw = 9;
    
    % find a point on line connecting lowp and uppp that has same
    % z value as Rw
    % line connecting points is (up_upp-up_lowp)*t + up_lowp = l
    t_hub = (Rw-up_lowp(3))/(up_upp(3) - up_lowp(3));
    point_hub = (up_upp-up_lowp)*t_hub+up_lowp;

    %val_up_AB = [0,0,Rw - up_lowp(3)]
    val_up_AB = point_hub - up_lowp;
    AH_vec = (dot(val_up_AB,AB)/norm(AB)^2)*AB;
    lh = norm(AH_vec);
    OH = point_hub - O;

    % switch y and x coordinates

    EO_s = swap_coords(EO);
    FO_s = swap_coords(FO);
    CB_s = swap_coords(CB);
    OB_s = swap_coords(OB);
    OC_s = swap_coords(OC);
    O_s = swap_coords(O);
    OH_s = swap_coords(OH);
    
    init.EO = EO_s;
    init.FO = FO_s;
    init.CB = CB_s;
    init.OB = OB_s;
    init.OC = OC_s;
    init.ll = ll;
    init.lu = lu;
    init.lk = lk;
    init.lh = lh;
    init.phi_deg = phi_deg;
    init.zeta_deg = zeta_deg;
    init.init_camber_deg = init_camber_deg;
    init.lhub = 4;
    init.co = 0;
    init.theta_0 = theta_0;
    init.Rw = Rw;
    init.O = O_s;
    init.OH = OH_s;
    %theta_0, ll,ex,ey,ez,bx,by,bz,cx,cy,cz,phi_deg,zeta_deg,camber_deg
    init.init_opt_vals = [...
        theta_0,ll,EO_s(1),EO_s(2),EO_s(3),OB_s(1),OB_s(2),OB_s(3),OC_s(1),...
        OC_s(2),OC_s(3),phi_deg, zeta_deg, init_camber_deg];
        
    
    function a = swap_coords(a)
        temp = a(2);
        a(2) = a(1);
        a(1) = temp;
    end

end



