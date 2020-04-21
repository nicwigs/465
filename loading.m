T = xlsread('points.xlsx','Front Suspension');
% y is trackwidth, x is wheel base
chas_lowfor = T(13,1:3);
chas_lowaft = T(14,1:3);
chas_upfor = T(15,1:3);
chas_upaft = T(16,1:3);
up_lowp = T(17,1:3);
up_upp = T(18,1:3);
chas_tie = T(19,1:3);
up_tie = T(20,1:3);
chas_pull = T(25,1:3);
up_pull = T(24,1:3);

% find a point on line connecting chas_lowaft and chas_lowfor that has same
% x value as point A, so in plane. 
% line connecting points is (chas_lowfor-chas_lowaft)*t + chas_lowaft = l
t = (up_lowp(1)-chas_lowaft(1))/(chas_lowfor(1) - chas_lowaft(1));
O = (chas_lowfor-chas_lowaft)*t+chas_lowaft; %becomes origin

OA = up_lowp-O;

theta_0 = atan(OA(3)/(OA(2)));

AB = up_upp-up_lowp;
lk = norm(AB);

C = (chas_upfor+chas_upaft)/2;
chas_upper_line = (chas_upfor -O) - (chas_upaft - O);
zeta_deg = atan(chas_upper_line(2)/chas_upper_line(1));
phi_deg = atan(chas_upper_line(1)/chas_upper_line(3));

OC = C-O;
OB = up_upp - O;

CB = OB - OC;
lu = norm(CB);


EO = up_tie-O;  %upright tie point rel to new origin
FO = chas_tie - O;  %chassis tie point rel to new origin

Rw = 9;

% find a point on line connecting chas_lowaft and chas_lowfor that has same
% x value as point A, so in plane. 

val_up_AB = [0,0,Rw - up_lowp(3)];
AH_vec = (dot(val_up_AB,AB)/norm(AB)^2)*AB;
lh = norm(AH_vec);

% switch y and x coordinates

EO_s = swap_coords(EO);
FO_s = swap_coords(FO);
CB_s = swap_coords(CB);
OB_s = swap_coords(OB);
OC_s = swap_coords(OC);

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
init.init_camber_deg = -0.2;
init.co = 0;



function a = swap_coords(a)
    temp = a(2);
    a(2) = a(1);
    a(1) = temp;
end
