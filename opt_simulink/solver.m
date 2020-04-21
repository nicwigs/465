
syms k u x z y j t f p g

eqn = k^2 == (g+u*cos(x)*cos(z) + u*sin(x)*sin(y)*sin(z) - j*cos(t))^2 + (f+u*cos(x)*sin(z)-u*sin(x)*sin(y)*cos(z))^2 + (p+u*sin(x)*cos(y)-j*sin(t))^2
s = solve(eqn,x);



%theta = deg2rad(10); %lower wishbone angle



u = 260; %upper wishbone length (mm)
g = 32; %len perp to Y
p = 210;
f = -12;
k =240; %length of upright
z = deg2rad(0); %yaw angle of upper wishbone
y = deg2rad(9); %anti-dive angle (deg)
t = deg2rad(-10);
j =330; %length of lower wishbone

eqn = k^2 == (g+u*cos(x)*cos(z) + u*sin(x)*sin(y)*sin(z) - j*cos(t))^2 + (f+u*cos(x)*sin(z)-u*sin(x)*sin(y)*cos(z))^2 + (p+u*sin(x)*cos(y)-j*sin(t))^2
v = vpasolve(eqn,x);

syms a b c d e f x
eqn = 0 == a +b*cos(x)+c*sin(x) + (cos(x))^2*d + e*(sin(x))^2 +cos(x)*sin(x)*f
s2 = solve(eqn,x)

syms a b c x
eqn = 0 == a+b*cos(x)+c*sin(x)
s3 = solve(eqn,x)


syms tr sa ex ey ez fx fy fz dx dy dz c1 c2 c3 c4
eqns = [tr^2 == (ex-fx)^2+(ey-fy)^2+(ez-fz)^2,...
        sa^2 == (ex-dx)^2+(ey-dy)^2+(ez-dz)^2,...
        c1*ex + c2*ey +c3*ez + c4 == 0];
S = solve(eqns,[ex ey ez])

tr =10; 
sa = 10;
E0 = [260 -120 173];
% ex = E0(1);
% ey = E0(2);
% ez = E0(3);
F0 = [16 -59 150];
fx = E0(1);
fy = E0(2);
fz = E0(3);
c1 = 2;
c2 = 4;
c3 = 3;
c4 = 4;
dx = 50;
dy = 23;
dz = 87;

eqns = [tr^2 == (ex-fx)^2+(ey-fy)^2+(ez-fz)^2,...
        sa^2 == (ex-dx)^2+(ey-dy)^2+(ez-dz)^2,...
        c1*ex + c2*ey +c3*ez + c4 == 0];

vpasolve(eqns,[ex ey ez])


