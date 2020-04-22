function motion = kin4(input, testing_e)

    % Definition
    phi = deg2rad(input.phi_deg); %anti-dive angle (deg)
    zeta = deg2rad(input.zeta_deg); %yaw angle of upper wishbone
    ll =input.ll; %length of lower wishbone
    lu = input.lu; %upper wishbone length (in)
    lk =input.lk; %length of upright (in)
    l_hub = input.lhub; %length of hub
    lh = input.lh; %|AH|
    c0 = input.co; % caster offset
    Rw = input.Rw; %effective radius of tire
    g = input.OC(1); %len perp to Y
    f = input.OC(2);
    p = input.OC(3);
    E0 = input.EO;
    F0 = input.FO;
    e0 = deg2rad(input.init_camber_deg);
    
    % Sim params
    theta = deg2rad(transpose([input.theta_0-10:input.theta_0+10]));
    init_index = fix(length(theta)/2)+1;
    search = 4;
    step = 0.05;

    %Solving for chi - angular dispacement of upper wishbone
    chi = zeros(size(theta));
    for i = 1:length(theta)
        t = theta(i);
        syms x
        eqn = lk^2 == (g+lu*cos(x)*cos(zeta) + lu*sin(x)*sin(phi)*sin(zeta) - ll*cos(t))^2 + (f+lu*cos(x)*sin(zeta)-lu*sin(x)*sin(phi)*cos(zeta))^2 + (p+lu*sin(x)*cos(phi)-ll*sin(t))^2;
        y = vpasolve(eqn,x);
        chi(i) = y;
    end

    OA = ll*[cos(theta) zeros(size(theta)) sin(theta)];
    OC = [g f p];
    CB = lu*[cos(chi)*cos(zeta) + sin(chi)*sin(phi)*sin(zeta) ...
        cos(chi)*sin(zeta)-sin(chi)*sin(phi)*cos(zeta) ...
        sin(chi)*cos(phi)];
    OB = OC+CB;

    ek = 1./lk.*(OC + ...
          lu.*[cos(chi)*cos(zeta)+sin(chi)*sin(phi)*sin(zeta) ...
              cos(chi)*sin(zeta)-sin(chi)*sin(phi)*cos(zeta) ...
              sin(chi)*cos(phi)] + ...
          ll.*[-cos(theta) zeros(size(theta)) -sin(theta)] );

    AB = lk*ek;

    el = [cos(theta) zeros(size(theta)) sin(theta)];

    % Commented to save time if E is still in workspace
    if isempty(testing_e)
        %[E, all_error] = find_E(length(theta),E0,F0,OA,OB,ll,el,ek,search,step);
        E = zeros(length(theta),3);
        for i = 1:length(theta)
            E(i,:)=E0;
        end

    else
        E = testing_e;
    end
    
    disp(E)

    e_hub0 = [cos(e0) 0 -sin(e0)];

    l_hubt0 = c0*[0 -1 0] + l_hub*e_hub0;
    e_hubt0 = l_hubt0./norm(l_hubt0);

    e_k0 = ek(init_index,1:3);
    ek0 = [e_k0(1)*ones(size(theta)) e_k0(2)*ones(size(theta)) e_k0(3)*ones(size(theta))];

    ek_lambda = cross(ek0,ek)./transpose(vecnorm(transpose(cross(ek0,ek))));
    ek_lambda(init_index,1:3) = [0 0 0]; %fix NAN

    lambda = asin(transpose(dot(transpose(cross(ek0,ek)),transpose(ek_lambda))));
    lambda(init_index) = 0; %fix error


    ea0 = cross(ek(init_index,1:3), cross(ek(init_index,1:3),ek(init_index+1,1:3)));
    ea0 = ea0/norm(ea0);


    ea0_lambda = cross(ek,cross(ek0,ek));

    ea = E-OA;
    ea = ea./transpose(vecnorm(transpose(ea)));

    lambda_p = asin(transpose(dot(transpose(cross(ea0_lambda,ea)),transpose(ek))));

    e_hub = zeros([length(theta) 3]);
    e_hub_t = zeros([length(theta) 3]);
    for i = 1:length(theta)
        e_hub_temp = transpose(get_rotation(ek(i,1:3),lambda_p(i))*get_rotation(ek_lambda(i,1:3),lambda(i))*transpose(e_hub0));
        e_hub(i,1:3) = e_hub_temp;

        e_hub_t_temp = transpose(get_rotation(ek(i,1:3),lambda_p(i))*get_rotation(ek_lambda(i,1:3),lambda(i))*transpose(e_hubt0));
        e_hub_t(i,1:3) = e_hub_t_temp;

    end

    l_hub_t = e_hub_t.*norm(l_hubt0);

    e_tr = [-e_hub(:,3)./e_hub(:,1).*sqrt(1./((e_hub(:,3)./e_hub(:,1)).^2+1)), zeros(size(theta)),  sqrt(1./((e_hub(:,3)./e_hub(:,1)).^2+1))];

    dOJ = (ll*el+lh*ek+l_hub_t+Rw*e_tr) - (ll*el(1,1:3)+lh*ek(1,1:3)+Rw*e_tr(1,1:3));

    wheel_travel = dOJ(:,3)-dOJ(init_index,3);
    track_variation = 2*dOJ(:,1) - 2*dOJ(init_index,1);

    camber = acos(e_hub(:,3))-pi/2;

    e_caster = [-e_hub(:,2)./e_hub(:,1).*sqrt(1./((e_hub(:,2)./e_hub(:,1)).^2+1)), sqrt(1./((e_hub(:,2)./e_hub(:,1)).^2+1)), zeros(size(theta))];
    caster = acos(transpose(dot(transpose(ek),transpose(e_caster))))-pi/2;

    l_hub_p = [e_hub(:,1),e_hub(:,2) ,zeros(size(theta))];
    e_hub_p = l_hub_p/norm(l_hub_p);

    kpi_angle = acos(transpose(dot(transpose(ek),transpose(e_hub_p))))-pi/2;

    toe = pi/2 - acos(e_hub_p(:,2));
    
    motion.wheel_travel = wheel_travel;
    motion.track_variation = track_variation;
    motion.camber = camber;
    motion.caster = caster;
    motion.kpi_angle = kpi_angle;
    motion.toe = toe;
end
