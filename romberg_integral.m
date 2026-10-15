
clc; clear;

function num_sol = romberg(f,a,b)
% function to calculate the Romberg iterative integral
% inputs integral limits and function to be integrated
% outputs final result to a tolernace of 0.1%

I = zeros(6); % initialize matrix to hold iterations

true_sol = vpa(integral(f,a,b)); % true solution of integral

I(1,1) = (b-a)*(f(a)+f(b))/2; % I(0,0) term

% since Romberg n and m terms start from n = 0, m = 0, but matlab
% indices start from 1 so shift n, m values by 1 when used in formulas
% computes only up to I(n,n) values in each row then moves to next row

for n = 2:6 % loop to calculate other values

    h = (b-a)/(2^(n-1)); % general h formula
    sum = 0; % initialize sum for sum part of I(n,0) values

    for i = 1:(2^(n-1) - 1) % sum part of first column equation
        sum = sum + f(a + i*h);
    end
    I(n,1) = h*(f(a) + f(b))/2 + h*sum; % first column I(n,0)

    for m = 2:n % to move to next item in each row starting with 2nd column
        I(n,m) = 1/(4^(m-1) - 1)*(4^(m-1)*I(n,m-1) - I(n-1,m-1));
    end

    if abs(vpa(true_sol) - vpa(I(n,m))) <= 0.1 % if tolerance <= 0.1
        num_sol = vpa(I(n,m)); % save result and stop loop
        break
    end

end
disp(I)
disp(true_sol)

end

% function to integrate
M = @(t) (1+2.*(sin(0.6.*t)).^2).*(5.*exp(0.15.*t)+2.*exp(-0.24.*t));

% call function for M and different t values (a = t1, b = t2)
romberg(M,2,6)
romberg(M,4,9)
romberg(M,5,11)