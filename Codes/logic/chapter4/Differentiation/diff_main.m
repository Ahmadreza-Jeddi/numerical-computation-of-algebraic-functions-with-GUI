function [steps, res] = diff_main(F_str, pt, deg, err_order, h, FPD)
%DIFF_MAIN Summary of this function goes here
%   Detailed explanation goes here

digits(FPD);
syms x;

switch err_order
    case 4
        [steps, res] = central_oh4(F_str, pt, deg, h, FPD);
    case 2
        if deg == 1
            [steps_3p, res_3p] = threepoint(F_str, pt, h, FPD);
            [steps_c, res_c] = central_oh2(F_str, pt, deg, h, FPD);
            
            exact_ans = vpa(eval(subs(diff(subs(F_str)), pt)));
            
            if abs(exact_ans-res_3p) < abs(exact_ans-res_c)
                steps = steps_3p;
                res = res_3p;
            else
                steps = steps_c;
                res = res_c;
            end
            
        else
            [steps, res] = central_oh2(F_str, pt, deg, h, FPD);
        end
        
end


end

