
clear all
tic
% init values come from design output
fsae = get_struct_from_sheet('points.xlsx','Front Suspension');
% specify init values
theta_0 = fsae.init_opt_vals(1);
ll = fsae.init_opt_vals(2);
ex = fsae.init_opt_vals(3);
ey = fsae.init_opt_vals(4);
ez = fsae.init_opt_vals(5);
bx = fsae.init_opt_vals(6);
by = fsae.init_opt_vals(7);
bz = fsae.init_opt_vals(8);
cx = fsae.init_opt_vals(9);
cy = fsae.init_opt_vals(10);
cz = fsae.init_opt_vals(11);
phi_deg = fsae.init_opt_vals(12);
zeta_deg = fsae.init_opt_vals(13);
camber_deg = fsae.init_opt_vals(14);

% Save time in heeds - dont read excel just write this
% theta_0 = -0.3941;
% ll = 15.9832;
% ex = 16.3048;
% ey = 2.2250;
% ez = 1.4101;
% bx = 15.4548;
% by = -0.3750;
% bz = 6.7601;
% cx = 3.0008;
% cy = 0.2450;
% cz = 5.4351;
% phi_deg = 1.2519;
% zeta_deg = 0;
% camber_deg = -0.2000;

%fsae = get_init_struct(-0.3941,15.9832,16.3048,2.2250,1.4101,15.4548,-0.3750,6.7601,3.0008,0.2450,5.4351,1.2519,0,-0.2000);

input_struct = get_init_struct(theta_0, ll, ex, ey, ez,...
    bx,by,bz,cx,cy,cz,phi_deg,zeta_deg,camber_deg);

motion = kin4(input_struct, []);

plot_results(motion)

% Ouputs specified for HEEDS

wheel_travel = motion.wheel_travel;
track_variation = motion.track_variation;
camber = rad2deg(motion.camber);
caster = rad2deg(motion.caster);
kpi_angle = rad2deg(motion.kpi_angle);
toe = rad2deg(motion.toe);


% Some constraints calculated for HEEDS
wheel_rad_safe = 9/2;
% bx should be with 2 of ax, i.e track width direction upper and lower ball
% joint should be somewhat close, should be negative
ball_joint_delta_x = abs(bx-ll*cos(deg2rad(theta_0)))-2;

% Upper ball joint needs to be withing the radius of the wheel shell -
% should be greater than 0
lbj_rad = wheel_rad_safe - ...
    ((by-input_struct.OH(2))^2+(bz-input_struct.OH(3))^2)^(1/2);

% Lower ball joint needs to be withing the radius of the wheel shell -
% should be greater than 0
ubj_rad = wheel_rad_safe - ...
    ((0-input_struct.OH(2))^2+...
    (ll*sin(deg2rad(theta_0))-input_struct.OH(3))^2)^(1/2);

% upper ball joint z must be larger than hub center
ubj_positive = bz - input_struct.OH(3);

toc

