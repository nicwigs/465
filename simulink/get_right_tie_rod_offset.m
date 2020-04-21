function offset_right = get_right_tie_rod_offset()
    global max_angle
    global hand_wheel_angle
    
    if isempty(hand_wheel_angle)
        offset_right = 35
    else
        offset_right = 35+20/tan(deg2rad(max_angle))*tan(deg2rad(hand_wheel_angle(-1)))
    end
  
    
    
end
