%Variable definitons
phi = deg2rad(9); %anti-dive angle (deg)
zeta = deg2rad(0); %yaw angle of upper wishbone
%theta = deg2rad(10); %lower wishbone angle
theta = deg2rad(10);
chi = deg2rad(8); %angular dispacement of upper wishbone
ll =330; %length of lower wishbone
lu = 260; %upper wishbone length (mm)
lk =240; %length of upright
tr =10; % tie rod length
sa = 10; %steering arm length
l_hub = 60; %length of hub
la = 2; %|LA|
lh = 120; %|AH|
co = 0; % caster offset
lhbut = 2; %perp len hub
Rw = 305; %effective radius of tire
g = 32; %len perp to Y
p = 210;
f = -12;


OA = ll*[cos(theta) 0 sin(theta)];
OC = [g f p];
CB = lu*[cos(chi)*cos(zeta) + sin(chi)*sin(phi)*sin(zeta)
    cos(chi)*sin(zeta)-sin(chi)*sin(phi)*cos(zeta)
    sin(chi)*cos(phi)];
OB = OC+CB;

k1 = f^2+g^2+p^2+ll^2+lu^2-lk^2
k2 = 2*f*lu*sin(zeta)+2*g*lu*cos(zeta)
k3 = 2*ll*lu*cos(zeta)
k4 = 2*f*lu*cos(zeta)*sin(phi)-2*p*lu*cos(phi)-2*g*lu*sin(zeta)*sin(phi)
k5 = 2*ll*lu*cos(phi)
k6 = 2*ll*lu*sin(zeta)*sin(phi)
k7 = 2*g*ll
k8 = 2*p*ll

A = -k1 + k2 - k3*cos(theta) + k7*cos(theta)+k8*sin(theta)
B = 2*k4+2*k5*sin(theta)+2*k6*cos(theta)
C = -k1 - k2 -k3*cos(theta)+k7*cos(theta)+k8*sin(theta)

chi_1 = 2*atan((-B+sqrt(B.^2-4*A.*C))./(2.*A))
chi_2 = 2*atan((-B-sqrt(B.^2-4*A.*C))./(2.*A))

rad2deg(chi_1)
rad2deg(chi_2)

 ek = 1/lk*(OC + ...
     lu*[cos(chi_1)*cos(zeta)+sin(chi_1)*sin(phi)*sin(zeta) ...
         cos(chi_1)*sin(zeta)-sin(chi_1)*sin(phi)*cos(zeta) ...
         sin(chi_1)*cos(phi)] + ...
     ll*[-cos(theta) 0 -sin(theta)] )

AB = lk*ek
 
el = [cos(theta) 0 sin(theta)]





