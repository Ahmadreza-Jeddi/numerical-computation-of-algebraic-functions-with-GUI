function [steps, res] = central_oh2(F_str, pt, deg, h, FPD)
%CENTRAL_OH2 Summary of this function goes here
%   Detailed explanation goes here

digits(FPD);
steps = cell(6, 1);

fpp = vpa(eval(subs(F_str, pt-2*h)));
fp = vpa(eval(subs(F_str, pt-h)));
f = vpa(eval(subs(F_str, pt)));
fn = vpa(eval(subs(F_str, pt+h)));
fnn = vpa(eval(subs(F_str, pt+2*h)));

steps{1} = 'The best method (with the lowest error) here';
steps{2} = 'is the Central Differencing with O(h^2) error :';
steps{3} = '';

switch deg
    case 1
        res = vpa((fn-fp)/(2*h));
        
        steps{4} = 'f''_i = (f_(i+1) - f_(i-1)) / (2*h)';
        steps{5} = ['      = (', char(fn), ' - (', char(fp), ')) / ', ...
            char(vpa(2*h))];
        steps{6} = ['      = ', char(res)];
        
    case 2
        res = vpa((fn-2*f+fp)/(h^2));
        
        steps{4} = 'f''_i = (f_(i+1) - 2f_i + f_(i-1)) / (h^2)';
        steps{5} = ['      = (', char(fn), ' -2* ', char(f), ...
            ' + (', char(fp), ') / ', char(vpa(h^2))];
        steps{6} = ['      = ', char(res)];
        
    case 3
        res = vpa((fnn-2*fn+2*fp-fpp)/(2*h^3));
        
        steps{4} = ['f''''''_i = (f_(i+2) - 2f_(i+1) + 2f_(i-1) - f_(i-2))', ...
            ' / (2*h^3)'];
        steps{5} = ['      = (', char(fnn), ' - 2*', char(fn), ' + 2*', ...
            char(fp), ' - (', char(fpp), ')) / ', char(vpa(2*h^3))];
        steps{6} = ['      = ', char(res)];
        
    case 4
        res = vpa((fnn-4*fn+6*f-4*fp+fpp)/(h^4));
        
        steps{4} = ['f_4th_i = (f_(i+2) - 4f_(i+1) + 6f_i - 4f_(i-1)', ...
            ' + f_(i-2)) / (h^4)'];
        steps{5} = ['      = (', char(fnn), ' - 4*', char(fn), ' + 6*', ...
            char(f), ' - 4*', char(fp), ' + (', char(fpp) ')) / ', ...
            char(vpa(h^4))];
        steps{6} = ['      = ', char(res)];
        
end

end

