
function [E, all_error] = find_E(n,E0,F0,OA,OB,ll,el,ek,search,step)
    
    desired_error = 1e-10;
    E = zeros([n 3]);
    all_error = zeros([n 1]);
    
    for i=1:n
        error = 100000000;
        eval_times = 0;
        
        disp(i)
        
        while error > desired_error
            if eval_times > 0
                disp("could not find in inital search space")
                disp(error)
                break %save time
            end
            surrounding = search + eval_times*50;
            [best_cord, error,~] = findEsingle(E0,F0,OA(i,1:3),OB(i,1:3),ll,el(i,1:3),ek(i,1:3),surrounding,step);
            eval_times = eval_times + 1; % if couldnt find within search space - open up search space
        end
        
        E(i,1:3) = best_cord;
        all_error(i) = error;

        
        
    end
end
