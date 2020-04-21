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



% normal_to_plane = cross(chas_lowfor-chas_lowaft,chas_lowfor-chas_upfor);
% normal_to_plane = normal_to_plane/norm(normal_to_plane);
% 
% dot(up_lowp-chas_lowfor, normal_to_plane)
% dot(up_lowp-chas_lowaft, normal_to_plane)
% 
% dot(up_upp-chas_upfor, normal_to_plane)
% dot(up_upp-chas_upaft, normal_to_plane)