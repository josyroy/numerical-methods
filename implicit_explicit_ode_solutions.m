% 0<=t<=0.2
% h = 0.02, N = 10

clc; clear;

% set of equations
dx1dt = @(x1,x2) 1999*x1 + 2999*x2;
dx2dt = @(x1,x2) -2000*x1 - 3000*x2;

% explicit method

% initialize vectors to plot
x1 = zeros(11,1);
x2 = zeros(11,1);

% initial conditions
x1(1) = 1;
x2(1) = 1;
h = 0.02; % step size
N = 10; % number of iterations

for i = 1:N % loop to get all values up to t = 0.2

    x1(i+1) = vpa(x1(i) + h*dx1dt(x1(i),x2(i)));
    x2(i+1) = vpa(x2(i) + h*dx2dt(x1(i),x2(i)));

end

vpa(x1) % results
vpa(x2)


t = 0:0.02:0.2; % plot
figure
plot(t,x1)
hold on;
plot(t,x2)
yyaxis left

% implicit method

x1 = zeros(11,1); % initialize
x2 = zeros(11,1);
x1(1) = 1;
x2(1) = 1;

% when solving for simultaneous system of equations at each time, matrix
% coefficients stay the same for every run
A = [1999*h-1, 2999*h; -2000*h, -3000*h-1];

for i = 1:10 % loop to solve system of equations and find values

    b = [0; 0]; % constant vector
    b(1) = -x1(i);
    b(2) = -x2(i);
    c = A\b;
    x1(i+1) = c(1); % solution for next step
    x2(i+1) = c(2);

end

yyaxis right % plot with smaller axis to see on same graph
ylim([-6 6])
plot(t,x1,t,x2)

legend('explicit solution to first ode', 'explicit solution to second ode', 'implicit solution to first ode', 'implicit solution to second ode','Location','northoutside')

vpa(x1)
vpa(x2)