clc;clear;

% trapezoid approx
function [trap_value] = trap(f,a,b,n)

h = (b-a)/n;
trap_it = 0; % initialize

for i = 0:n % loop to sum based on terms and coefficient for f(x) (ith) term
    if i == 0 || i == n
        trap_i = h/2*f(a+i*h);
    else
        trap_i = h*f(a+i*h);
    end
    trap_it = trap_it + trap_i; % add iteration
end
trap_value = vpa(trap_it);
end

% simpson approx
function [simp_value] = simp(f,a,b,n)

h = (b-a)/n;
simp_it = 0; % initialize

for i = 0:n  %loop to sum based on terms and coefficient for f(x) (ith) term
    if i == 0 || i == n
        simp_i = h/3*f(a+i*h);
    elseif mod(i,2) == 0 && i~=0 && i~=n
        simp_i = 2*h/3*f(a+i*h);
    else
        simp_i = 4*h/3*f(a+i*h);
    end
    simp_it = simp_it + simp_i; % add iteration
end
simp_value = vpa(simp_it);
end

% function and integral bounds
func = @(x) sin(x)+cos(x);
a = 0;
b = pi/3;

% allow user to choose summation/integral approximation method
choice = menu('Select a summation method', 'trapezoidal rule approximation', 'simpsons rule approximation');

bool = 1; % True

while bool

    n = input('input the number of terms ');

    if choice == 1
        trap(func,a,b,n)
        fprintf('the value for the trap approx is %f\n',trap(func,a,b,n));
        bool = 0;
    elseif choice == 2 && mod(n,2) == 0 % n must be even for simpson rule
        simp(func,a,b,n)
        fprintf('the value for the simp approx is %f\n',simp(func,a,b,n));
        bool = 0;
    elseif n <= 0
        disp('n must be a natural number, try again.')
        fprintf('n must be a natural number, try again\n');
        continue
    elseif mod(n,2) ~= 0
        disp('n must be even. try again.') % if n odd
        fprintf('n must be even, try again\n');
        continue
    else
        disp('try again.')
        fprintf('try again\n');
        continue
    end
end