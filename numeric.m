
u = 260; %upper wishbone length (mm)
g = 32; %len perp to Y
p = 210;
f = -12;
k =240; %length of upright
z = deg2rad(0); %yaw angle of upper wishbone
y = deg2rad(9); %anti-dive angle (deg)
t = deg2rad(-10);
j =330; %length of lower wishbone


x_deg =0;
%x=0.32276115028197452275231980610549;
final = 1e200;
n = 0;

while (abs(final - k) > 0.001) & (x_deg < 360)
    x_deg = x_deg + 0.00001;
    x = deg2rad(x_deg);
    final = sqrt((g+u*cos(x)*cos(z) + u*sin(x)*sin(y)*sin(z) - j*cos(t))^2 + (f+u*cos(x)*sin(z)-u*sin(x)*sin(y)*cos(z))^2 + (p+u*sin(x)*cos(y)-j*sin(t))^2);
    n = n+1;
end
disp(final)
disp(x_deg)
% 
% for x_deg =0:.00001:360
%     x = deg2rad(x_deg);
%     final = sqrt((g+u*cos(x)*cos(z) + u*sin(x)*sin(y)*sin(z) - j*cos(t))^2 + (f+u*cos(x)*sin(z)-u*sin(x)*sin(y)*cos(z))^2 + (p+u*sin(x)*cos(y)-j*sin(t))^2);
%     if (abs(final - k) < 0.00001)
%         disp(x_deg)
%     end
% end

for x_deg =0:.00001:360
    x = deg2rad(x_deg);
    
    OA = j*[cos(t) 0 sin(t)];
    OC = [g f p];
    CB = u*[cos(x)*cos(z) + sin(x)*sin(y)*sin(z) ...
        cos(x)*sin(z)-sin(x)*sin(y)*cos(z) ...
        sin(x)*cos(y)];
    OB = OC+CB;
    
    final = norm(OB-OA);
    
    if (abs(final - k) < 0.00001)
        disp(x_deg)
        disp(OB-OA)
    end
end 

