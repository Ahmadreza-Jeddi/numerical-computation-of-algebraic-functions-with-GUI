function [steps, anss] = Runge_kutta_4order(f, y0, x0, n, h)

    syms x y;
    func = @(xTmp, yTmp) vpa(subs(f, [x y], [xTmp yTmp]));
    k1 = @(xTmp, yTmp) vpa(h*func(xTmp, yTmp));
    k2 = @(xTmp, yTmp, k1Tmp) vpa(h*func(xTmp+h/2, yTmp+k1Tmp/2));
    k3 = @(xTmp, yTmp, k2Tmp) vpa(h*func(xTmp+h/2, yTmp+k2Tmp/2));
    k4 = @(xTmp, yTmp, k3Tmp) vpa(h*func(xTmp+h, yTmp+k3Tmp));
    out = cell(5*n, 1);
    steps = cell(5*n, 1);

    xTmp = x0;
    yTmp = y0;
    for i=1:n
        k1Tmp = k1(xTmp, yTmp);
        k2Tmp = k2(xTmp, yTmp, k1Tmp);
        k3Tmp = k3(xTmp, yTmp, k2Tmp);
        k4Tmp = k4(xTmp, yTmp, k3Tmp);
        yTmp = vpa(yTmp + (k1Tmp+2*k2Tmp+2*k3Tmp+k4Tmp)/6);
        xTmp = xTmp+h;
        out{5*i-4} = k1Tmp;
        out{5*i-3} = k2Tmp;
        out{5*i-2} = k3Tmp;
        out{5*i-1} = k4Tmp;
        out{5*i-0} = yTmp;
    end
    
    anss = out{5*n};
    
    for i=0:5:5*n-5
        steps{i+1} = ['k1(', num2str(x0+h*(i/5+1)), ') = ', num2str(double(out{i+1}))];
        steps{i+2} = ['k2(', num2str(x0+h*(i/5+1)), ') = ', num2str(double(out{i+2}))];
        steps{i+3} = ['k3(', num2str(x0+h*(i/5+1)), ') = ', num2str(double(out{i+3}))];
        steps{i+4} = ['k4(', num2str(x0+h*(i/5+1)), ') = ', num2str(double(out{i+4}))];
        steps{i+5} = ['y(', num2str(x0+h*(i/5+1)), ') = ', num2str(double(out{i+5}))];
    end

end

