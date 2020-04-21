%Variable definitons
phi = deg2rad(9); %anti-dive angle (deg)
zeta = deg2rad(0); %yaw angle of upper wishbone
%theta = deg2rad(10); %lower wishbone angle
theta = deg2rad(transpose([-10:10]));
%chi = deg2rad(8); %angular dispacement of upper wishbone
ll =330; %length of lower wishbone
lu = 260; %upper wishbone length (mm)
lk =240; %length of upright
tr =10; % tie rod length
% sa = 10; %steering arm length
l_hub = 60; %length of hub
la = 2; %|LA|
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


a = g^2-2*g*ll*cos(theta) + ll^2*cos(theta)+f^2-lk^2+p^2-2*p*ll*sin(theta) +ll^2*sin(theta)+lu^2;
b = 2*g*lu*cos(zeta)-2*lu*ll*cos(zeta)*cos(theta)+2*f*lu*sin(zeta);
c = 2*g*lu*sin(phi)*sin(zeta)-2*ll*lu*sin(phi)*sin(zeta)*cos(theta)-2*f*lu*sin(phi)*cos(zeta)+2*p*lu*cos(phi)-2*lu*ll*cos(phi)*sin(theta);

chi_1 = 2*atan((-2*c+sqrt(4*c.^2-4*(a-b).*(a+b)))./(2.*(a-b)))
chi_2 = 2*atan((-2*c-sqrt(4*c.^2-4*(a-b).*(a+b)))./(2.*(a-b)))

if chi_1 > chi_2
    chi = chi_1
else
    chi = chi_2
end

chi = 0.32276115028197452275231980610549;
chi = deg2rad(18.4929)
chi = -0.1168762227979525267359524948275;

rad2deg(chi_1)
rad2deg(chi_2)

OA = ll*[cos(theta) zeros(size(theta)) sin(theta)];
OC = [g f p];
CB = lu*[cos(chi)*cos(zeta) + sin(chi)*sin(phi)*sin(zeta) ...
    cos(chi)*sin(zeta)-sin(chi)*sin(phi)*cos(zeta) ...
    sin(chi)*cos(phi)];
OB = OC+CB;

% find ea
% BA = OB(1,1:3)-OA(1,1:3);
% EA = E0-OA(1,1:3);
% ea0 = E0 - OA(1,1:3) - (dot(EA,BA)/dot(BA,BA))*BA

ek = 1./lk.*(OC + ...
      lu.*[cos(chi)*cos(zeta)+sin(chi)*sin(phi)*sin(zeta) ...
          cos(chi)*sin(zeta)-sin(chi)*sin(phi)*cos(zeta) ...
          sin(chi)*cos(phi)] + ...
      ll.*[-cos(theta) zeros(size(theta)) -sin(theta)] )

AB = lk*ek

ea0 = cross(ek(1,1:3), cross(ek(1,1:3),ek(2,1:3)))
ea0 = ea0/norm(ea0)
 
el = [cos(theta) zeros(size(theta)) sin(theta)]

e_hub0 = [cos(e0) 0 -sin(e0)]

l_hubt0 = c0*[0 -1 0] + l_hub*e_hub0

e_k0 = ek(1,1:3)
ek0 = [e_k0(1)*ones(size(theta)) e_k0(2)*ones(size(theta)) e_k0(3)*ones(size(theta))]

ekl = cross(ek0,ek)./transpose(vecnorm(transpose(cross(ek0,ek))))

l = asin(transpose(dot(transpose(cross(ek0,ek)),transpose(ekl))))

ea0l = cross(ek,cross(ek0,ek))

sa = norm(cross(OB(1,1:3)-OA(1,1:3),E0 - OA(1,1:3))) / norm(OB(1,1:3)-OA(1,1:3));
AE = OA(1,1:3) - E0(1,1:3);
la = sqrt(norm(AE)^2-sa^2)

D = ll*el+la*ek



