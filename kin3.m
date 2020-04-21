%Variable definitons
phi = deg2rad(9); %anti-dive angle (deg)
zeta = deg2rad(0); %yaw angle of upper wishbone
%theta = deg2rad(10); %lower wishbone angle
theta = deg2rad(transpose([-10:10]));
%chi = deg2rad(8); %angular dispacement of upper wishbone
ll =330; %length of lower wishbone
lu = 260; %upper wishbone length (mm)
lk =240; %length of upright
%tr =10; % tie rod length
% sa = 10; %steering arm length
l_hub = 60; %length of hub
%la = 2; %|LA|
lh = 120; %|AH|
c0 = 0; % caster offset
lhbut = 2; %perp len hub
Rw = 305; %effective radius of tire
g = 32; %len perp to Y
p = 210;
f = -12;
E0 = [260 -120 173];
F0 = [16 -59 150];
e0 = deg2rad(-0.25);

chi = zeros(size(theta));
for i = 1:length(theta)
    t = theta(i);
    syms x
    eqn = lk^2 == (g+lu*cos(x)*cos(zeta) + lu*sin(x)*sin(phi)*sin(zeta) - ll*cos(t))^2 + (f+lu*cos(x)*sin(zeta)-lu*sin(x)*sin(phi)*cos(zeta))^2 + (p+lu*sin(x)*cos(phi)-ll*sin(t))^2;
    v = vpasolve(eqn,x);
    chi(i) = v;
end
disp(chi)

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
      ll.*[-cos(theta) zeros(size(theta)) -sin(theta)] )

AB = lk*ek

el = [cos(theta) zeros(size(theta)) sin(theta)]


%[E, all_error] = find_E(n,E0,F0,OA,OB,ll,el,ek,search,step);

e_hub0 = [cos(e0) 0 -sin(e0)]

l_hubt0 = c0*[0 -1 0] + l_hub*e_hub0
e_hubt0 = l_hubt0./norm(l_hubt0)

e_k0 = ek(1,1:3)
ek0 = [e_k0(1)*ones(size(theta)) e_k0(2)*ones(size(theta)) e_k0(3)*ones(size(theta))]

ek_lambda = cross(ek0,ek)./transpose(vecnorm(transpose(cross(ek0,ek))))
ek_lambda(1,1:3) = [0 0 0]

lambda = asin(transpose(dot(transpose(cross(ek0,ek)),transpose(ek_lambda))))
lambda(1) = 0;


ea0 = cross(ek(1,1:3), cross(ek(1,1:3),ek(2,1:3)))
ea0 = ea0/norm(ea0)
 

ea0_lambda = cross(ek,cross(ek0,ek))

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

l_hub_t = e_hub_t.*norm(l_hubt0)

e_tr = [-e_hub(:,3)./e_hub(:,1).*sqrt(1./((e_hub(:,3)./e_hub(:,1)).^2+1)), zeros(size(theta)),  sqrt(1./((e_hub(:,3)./e_hub(:,1)).^2+1))];

dOJ = (ll*el+lh*ek+l_hub_t+Rw*e_tr) - (ll*el(1,1:3)+lh*ek(1,1:3)+Rw*e_tr(1,1:3))

wheel_travel = dOJ(:,3)
track_variation = 2*dOJ(:,1)

camber = acos(e_hub(:,3))-pi/2

e_caster = [-e_hub(:,2)./e_hub(:,1).*sqrt(1./((e_hub(:,2)./e_hub(:,1)).^2+1)), sqrt(1./((e_hub(:,2)./e_hub(:,1)).^2+1)), zeros(size(theta))];
caster = acos(transpose(dot(transpose(ek),transpose(e_caster))))-pi/2

l_hub_p = [e_hub(:,1),e_hub(:,2) ,zeros(size(theta))]
e_hub_p = l_hub_p/norm(l_hub_p)

kpi_angle = acos(transpose(dot(transpose(ek),transpose(e_hub_p))))-pi/2

toe = pi/2 - acos(e_hub_p(:,2))



