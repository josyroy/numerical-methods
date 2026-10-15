clear;
clc;

% a)

% solved in desmos
% H = 6.6049 when v = 8 m/s and t = 3.5 s

% b)

% Bisection

iter_bis = 0; % initialize total number of iterations
for vel = 4:0.5:7 % for loops for v and t increments
    for t = 2:0.5:4
        % function handle for velocity equation to plug values into
        velocity = @(x) 0.8*sqrt(2*9.81*x)*tanh((0.8*sqrt(2*9.81*x)*t)/(2*(9+0.4*x))) - vel;
        n1 = 0; % initialize iteration number for each case
        a = -1; b = 30;
        c = (a+b)/2; % c formula for bisection method
        va = velocity(a);
        vb = velocity(b);
        err = 0.1; % condition when to stop iterating
        while abs(velocity(c)) > err % while error still higher than stopping condition
            c = (a+b)/2;
            vc = velocity(c);
            if va*vc > 0 % if product positive, set a = c
                a = c;
            else % vice versa
                b = c;
            end
            n1 = n1 + 1; % add one to iteration count
        end
        fprintf('The computed head value for v = %d m/s and t = %d s is %2.5f m in %d iterations\n', vel, t, c, n1)
        iter_bis = iter_bis + n1; % add iterations to total count
    end
end
fprintf('The total number of iterations is %d\n\n', iter_bis)

% c)

% Regula Falsi

iter_reg = 0; % initialize total number of iterations
for vel = 4:0.5:7 % for loops for v and t increments
    for t = 2:0.5:4
        % function handle for velocity equation to plug values into
        velocity = @(x) 0.8*sqrt(2*9.81*x)*tanh((0.8*sqrt(2*9.81*x)*t)/(2*(9+0.4*x))) - vel;
        n2 = 0; % initialize iteration number for each case
        a = -1; b = 30;
        va = velocity(a);
        vb = velocity(b);
        c = (a*vb - b*va)/(vb - va); % c formula for Regula Falsi method
        err = 0.1; % condition when to stop iterating
        while abs(velocity(c)) > err % while error still higher than stopping condition
            c = (a*vb - b*va)/(vb - va);
            vc = velocity(c);
            if va*vc > 0 % if product positive, set a = c
                a = c;
            else % vice versa
                b = c;
            end
            n2 = n2 + 1; % add one to iteration count
        end
        fprintf('The computed head value for v = %d m/s and t = %d s is %2.5f m in %d iterations \n', vel, t, c, n2)
        iter_reg = iter_reg + n2; % add iterations to total count
    end
end
fprintf('The total number of iterations is %d\n', iter_reg)