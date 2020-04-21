

min_error = 100000000000;
n = 0;

search = 100;
for ex = E0(1)-search:E0(1)+search
    for ey = E0(2)-search:E0(2)+search
        for ez = E0(3)-search:E0(3)+search
            e1 = norm(F0 - E0)^2 - ((ex-F0(1))^2 + (ey-F0(2))^2 + (ez -F0(3))^2);
            e2 = ex*-sqrt(norm([ex ey ez] - OA(1,1:3))^2-(norm(cross(OA(1,1:3) - [ex ey ez], OB(1,1:3) - [ex ey ez])) / norm(OA(1,1:3) - OB(1,1:3)))^2)*ek(1,1) + ...
                 ey*-sqrt(norm([ex ey ez] - OA(1,1:3))^2-(norm(cross(OA(1,1:3) - [ex ey ez], OB(1,1:3) - [ex ey ez])) / norm(OA(1,1:3) - OB(1,1:3)))^2)*ek(1,2) +...
                 ez*-sqrt(norm([ex ey ez] - OA(1,1:3))^2-(norm(cross(OA(1,1:3) - [ex ey ez], OB(1,1:3) - [ex ey ez])) / norm(OA(1,1:3) - OB(1,1:3)))^2)*ek(1,3) + ...
                 (sqrt(norm([ex ey ez] - OA(1,1:3))^2-(norm(cross(OA(1,1:3) - [ex ey ez], OB(1,1:3) - [ex ey ez])) / norm(OA(1,1:3) - OB(1,1:3)))^2))^2 + ...
                 ll*sqrt(norm([ex ey ez] - OA(1,1:3))^2-(norm(cross(OA(1,1:3) - [ex ey ez], OB(1,1:3) - [ex ey ez])) / norm(OA(1,1:3) - OB(1,1:3)))^2)*...
                (ek(1,1)*el(1,1)+ek(1,2)*el(1,2)+ek(1,3)*el(1,3));

            e3 = (norm(cross(OA(1,1:3) - [ex ey ez], OB(1,1:3) - [ex ey ez])) / norm(OA(1,1:3) - OB(1,1:3)))^2 -(...
                ((ll*el(1,1)+sqrt(norm([ex ey ez] - OA(1,1:3))^2-(norm(cross(OA(1,1:3) - [ex ey ez], OB(1,1:3) - [ex ey ez])) / norm(OA(1,1:3) - OB(1,1:3)))^2)*ek(1,1))- ... 
                ex)^2 + ...
                ((ll*el(1,2)+sqrt(norm([ex ey ez] - OA(1,1:3))^2-(norm(cross(OA(1,1:3) - [ex ey ez], OB(1,1:3) - [ex ey ez])) / norm(OA(1,1:3) - OB(1,1:3)))^2)*ek(1,2))-...
                ey)^2 + ...
                ((ll*el(1,3)+sqrt(norm([ex ey ez] - OA(1,1:3))^2-(norm(cross(OA(1,1:3) - [ex ey ez], OB(1,1:3) - [ex ey ez])) / norm(OA(1,1:3) - OB(1,1:3)))^2)*ek(1,3))-...
                ez)^2);
            n = n+1;
            error = abs(e1)+abs(e2)+abs(e3);
            if error < min_error
                disp(error)
                disp(ex)
                disp(ey)
                disp(ez)
                disp(e1)
                disp(e2)
                disp(e3)
                disp(n)
                min_error = error;
                if error < 1e-10
                    found = 1;
                    disp("found")
                    break
                end  
            end   
        end
        if found ==1
            break
        end
    end
    if found ==1
        break
    end
end

            
     
