function [steps, res] = newtonRaphson(func_str, initial_x, iter, FPD)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%TODO checking invalid inputs or convergence conditions

digits(FPD);
steps = cell(2*iter, 1);
tmp_x = vpa(initial_x);

x_str = 'x0';
syms x

for i=1:iter,
    
    f = vpa(eval(subs(func_str, tmp_x)));
    deriv = vpa(eval(subs(diff(subs(func_str, x)), tmp_x)));
    tmp_x = vpa(tmp_x - f/deriv);
    
    % storing steps string
    substep = [x_str, ' = ', char(tmp_x)];
    steps{3*i-2} = substep;
    
    substep = ['-> x', num2str(i), ' = ', x_str, '-f(', x_str, ...
        ')/f''(', x_str, ') = ', char(tmp_x)];
    steps{3*i-1} = substep;
    
    % terminate if f(tmp_x) is zero
    if eval(subs(func_str, tmp_x)) == 0,
        substep = ['Exact root found! f(', char(tmp_x), ') = 0'];
        steps{5*i} = substep;
        break
    end
    
    steps{3*i} = '';
    
    x_str = ['x', num2str(i)];
end

res = tmp_x;
    
end

