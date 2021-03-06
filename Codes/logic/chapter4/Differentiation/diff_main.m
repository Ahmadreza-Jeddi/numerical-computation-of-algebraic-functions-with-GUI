function [steps, res, resR] = diff_main(F_str, pt, deg, err_order, h, FPD)
%DIFF_MAIN Summary of this function goes here
%   Detailed explanation goes here

digits(FPD);
syms x;

switch err_order
    case 4
        [steps, res] = central_oh4(F_str, pt, deg, h, FPD);
        [~, reshalfh] = central_oh4(F_str, pt, deg, h/2, FPD);
    case 2
        if deg == 1
            [steps_3p, res_3p] = threepoint(F_str, pt, h, FPD);
            [~, res_3phalfh] = threepoint(F_str, pt, h/2, FPD);
            
            [steps_c, res_c] = central_oh2(F_str, pt, deg, h, FPD);
            [~, res_chalfh] = central_oh2(F_str, pt, deg, h/2, FPD);
            
            exact_ans = vpa(eval(subs(diff(subs(F_str)), pt)));
            
            if abs(exact_ans-res_3p) < abs(exact_ans-res_c)
                steps = steps_3p;
                res = res_3p;
            else
                steps = steps_c;
                res = res_c;
            end
            
            if abs(exact_ans-res_3phalfh) < abs(exact_ans-res_chalfh)
                reshalfh = res_3phalfh;
            else
                reshalfh = res_chalfh;
            end
            
        else
            [steps, res] = central_oh2(F_str, pt, deg, h, FPD);
            [~, reshalfh] = central_oh2(F_str, pt, deg, h/2, FPD);
        end
        
end

[stepsR, resR] = richardson_extrapol(h, reshalfh, res, err_order, FPD);

steps = [steps; stepsR];


end

