function plot_results(motion)


    % Desired curves
    for_fitting = [motion.wheel_travel(1) motion.wheel_travel(end)];
    for_fitting_y = [0.15 -0.5];
    poly_for_toe = polyfit(for_fitting, for_fitting_y, 1);
    desired_toe = polyval(poly_for_toe, motion.wheel_travel);
    
    %csvwrite('desired_toe.csv',[motion.wheel_travel,desired_toe])

%     for_fitting_camber = [motion.wheel_travel(1) -2.5  -2 -1 0 1 2 2.5 motion.wheel_travel(end)];
%     for_fitting_camber_y = [0 0 0 -.5 -3 -.5 0 0 0];
    for_fitting_camber = [motion.wheel_travel(1)  0 motion.wheel_travel(end)];
    for_fitting_camber_y = [0 -1 0];
    poly_for_camber = polyfit(for_fitting_camber, for_fitting_camber_y, 2);
    desired_camber = polyval(poly_for_camber, motion.wheel_travel);

    %csvwrite('desired_camber_4.csv',[motion.wheel_travel,desired_camber])
    
    % Plot
    subplot(2,3,1)
    plot(motion.wheel_travel,rad2deg(motion.kpi_angle))
    title('kpi angle')
    ylabel('deg')
    xlabel('wheel travel')

    subplot(2,3,2)
    plot(motion.wheel_travel,rad2deg(motion.caster))
    title('caster')
    ylabel('deg')
    xlabel('wheel travel')

    subplot(2,3,3)
    plot(motion.wheel_travel,rad2deg(motion.camber))
    hold on
    plot(motion.wheel_travel, desired_camber)
    title('camber')
    ylabel('deg')
    xlabel('wheel travel')

    subplot(2,3,4)
    plot(motion.wheel_travel,rad2deg(motion.toe))
    hold on
    plot(motion.wheel_travel, desired_toe)
    title('toe')
    ylabel('deg')
    xlabel('wheel travel')

    subplot(2,3,5)
    plot(motion.wheel_travel, motion.track_variation)
    title('track variation')
    ylabel('track variation (in)')
    xlabel('wheel travel')

    saveas(gcf,'output.png')

end
