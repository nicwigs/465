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

len_up_for = 2*chas_upfor(2);
len_low_for = 2*chas_lowfor(2);
h_for = chas_upfor(3)-chas_lowfor(3);

len_up_aft = 2*chas_upaft(2);
len_low_aft = 2*chas_lowaft(2);
h_aft = chas_upaft(3)-chas_lowaft(3);

link_upper = chas_upfor(1)-chas_upaft(1);
link_low = chas_lowfor(1)-chas_lowaft(1);

%%%%%%%%%%%%%%%%%%%%%%%%
Ts = 60;
rack_travel = 20;
max_angle = 35;

% Names
back_frame_up = intocm(len_up_aft); %100
back_frame_low = intocm(len_low_aft); %75
back_frame_height = intocm(h_aft); %40
back_frame_rad = intocm(0.25); %2
back_frame_thick_frame = intocm(0.25); %2
back_frame_thick_frame_bar = intocm(0.5); %5

front_frame_up = intocm(len_up_for); %100
front_frame_low = intocm(len_low_for); %75
front_frame_height = intocm(h_for); %40
front_frame_rad = intocm(0.25); %2
front_frame_thick_frame = intocm(0.25); %2
front_frame_thick_frame_bar = intocm(0.5); %5

upper_left_link_len = intocm(link_upper); %30
upper_right_link_len = intocm(link_upper); %30

lower_left_link_len = intocm(link_upper); %30
lower_right_link_len = intocm(link_upper); %30

%%%%%%%%%%%%%%%%

tire_radius = intocm(9);
tire_width = intocm(7.5);
tire_chamfer = 1;
tire_density = 1000;

hub_radius = intocm(2);
outer_radius_spokes = intocm(5);
num_spokes = 4;
thickness_spokes = intocm(1);
width_hub = intocm(4.5);
shaft_len = intocm(8);
shaft_rad = intocm(1.5);
brake_disk_rad = intocm(3);
brake_disk_thick = intocm(0.25);

upright_height = 43;%intocm(9);
upright_len = 8;%intocm(4);
upright_thickness = 1;%intocm(0.5);
upright_hub_thick = 2.5;%intocm(2);
upright_heigh_wheel = 8;%intocm(9);
upright_width_wishbone = 10;%intocm(2);
upright_shaft_rad = 2.5;%shaft_rad;
upright_bearing_housing = 6;%intocm(6);
upright_chamfer = 0.3;%intocm(0.25);
upright_trans_rad_to_wheel = 2;%intocm(1);

steering_ball_rad = 1;%intocm(0.5);
steering_pin_rad = 0.5;%intocm(0.25);
steering_pin_height = 3;%intocm(2);

steer_arm_len = 20;%intocm(8);
steer_arm_width = 2;%intocm(1);
steer_arm_thick = 1;%intocm(0.5);
steer_arm_height_forked = 13;%intocm(5);
steer_arm_len_forked = 4;%intocm(1);
steer_arm_offset_forked = 3;%intocm(2);
steer_arm_pin_rad = 0.25;%intocm(0.3);
steer_arm_chamfer = 0.25;%intocm(0.2);


