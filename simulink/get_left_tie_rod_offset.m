function offset_left = get_left_tie_rod_offset()
    global max_angle
    global hand_wheel_angle

    if isempty(hand_wheel_angle)
        offset_left = 35
    else
        offset_left = 35 - 20/tan(deg2rad(max_angle))*tan(deg2rad(hand_wheel_angle.Data(end)))
    end
    
end
