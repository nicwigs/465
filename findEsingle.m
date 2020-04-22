
function [best_cord, min_error,n] = findEsingle(E0,F0,OA,OB,ll,el,ek,search,step)
    min_error = 100000000000;
    n = 0;
    best_cord = [0 0 0];
    for ex = E0(1)-search:step:E0(1)+search
        for ey = E0(2)-search:step:E0(2)+search
            for ez = E0(3)-search:step:E0(3)+search
                e1 = norm(F0 - E0)^2 - ((ex-F0(1))^2 + (ey-F0(2))^2 + (ez -F0(3))^2);
                e2 = ex*-sqrt(norm([ex ey ez] - OA)^2-(norm(cross(OA - [ex ey ez], OB - [ex ey ez])) / norm(OA - OB))^2)*ek(1) + ...
                     ey*-sqrt(norm([ex ey ez] - OA)^2-(norm(cross(OA - [ex ey ez], OB - [ex ey ez])) / norm(OA - OB))^2)*ek(2) +...
                     ez*-sqrt(norm([ex ey ez] - OA)^2-(norm(cross(OA - [ex ey ez], OB - [ex ey ez])) / norm(OA - OB))^2)*ek(3) + ...
                     (sqrt(norm([ex ey ez] - OA)^2-(norm(cross(OA - [ex ey ez], OB - [ex ey ez])) / norm(OA - OB))^2))^2 + ...
                     ll*sqrt(norm([ex ey ez] - OA)^2-(norm(cross(OA - [ex ey ez], OB - [ex ey ez])) / norm(OA - OB))^2)*...
                    (ek(1)*el(1)+ek(2)*el(2)+ek(3)*el(3));

                e3 = (norm(cross(OA - [ex ey ez], OB - [ex ey ez])) / norm(OA - OB))^2 -(...
                    ((ll*el(1)+sqrt(norm([ex ey ez] - OA)^2-(norm(cross(OA - [ex ey ez], OB - [ex ey ez])) / norm(OA - OB))^2)*ek(1))- ... 
                    ex)^2 + ...
                    ((ll*el(2)+sqrt(norm([ex ey ez] - OA)^2-(norm(cross(OA - [ex ey ez], OB - [ex ey ez])) / norm(OA - OB))^2)*ek(2))-...
                    ey)^2 + ...
                    ((ll*el(3)+sqrt(norm([ex ey ez] - OA)^2-(norm(cross(OA - [ex ey ez], OB - [ex ey ez])) / norm(OA - OB))^2)*ek(3))-...
                    ez)^2);
                n = n+1;
                error = abs(e1)+abs(e2)+abs(e3);
                if error < min_error
                    best_cord(1) = ex;
                    best_cord(2) = ey;
                    best_cord(3) = ez;
                    min_error = error;
                    if error < 1e-10
                        disp(ex)
                        disp(ey)
                        disp(ez)
                        disp(error)
                        %return
                    end  
                end   
            end
        end
    end
end
