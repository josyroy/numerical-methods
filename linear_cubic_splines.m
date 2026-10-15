clear;
clc;

% alg for linear splines, derive coefficients for a)
% fi(x) = yi + ci(x-xi),
% ci = yi+1 - yi / xi+1 - xi
% then predict f(x) values based on range and x given
% xE[xi,xi+1]

xi = [1 3 5 7 9 12]; % x data points
yi = [4.5 15.8 52.6 130.4 290.7 610.2]; % f(x) data points
coeff = [0 0 0 0 0]; % initialize c vector
fx = [0 0 0]; % initialize predicted f(x) values vector
xa = [2.2 4.6 10.5]; % x values to use

figure
for j = 1:3 % for x given
    for i = 1:5 % for x and y points from 1 to 5
        coeff(i) = (yi(i+1)-yi(i))/(xi(i+1)-xi(i)); % c_i forumla
        x = xi(i):0.5:xi(i+1); % x axis for each equation/spline found
        plot(x,yi(i) + coeff(i)*(x-xi(i)), 'Color','w') % plot spline
        if xa(j) > xi(i) && xa(j) < xi(i+1) % if x value is in the domain of two x points then plot point on that spline
            fx(j) = yi(i) + coeff(i)*(xa(j)-xi(i)); % using the minimum of the domain and its corresponding y
            line(xa(j),fx(j),"Marker",".","MarkerSize",15,"Color",'m')
        end
        hold on;
    end
end
hold off;
disp(coeff)
disp(fx)

% cubic splines
% aix^3 + bix+2 + cix + di
% first set, i = [1:n-1]
% yi = aixi^3 + bixi^2 + cixi^2 + di
% yi+1 = aixi+1^3 + bixi+1^2 + cixi+1 + di
% second set - first derivative, i starts at 2
% 3ai-1xi^2 + 2bi-1xi + ci-1 = 3aixi^2 + 2bixi + ci
% third set - second derivative, i starts at 2
% 6ai-1xi + 2bi-1 = 6aixi + 2bi
% last set
% 6a1x1 + 2b1 = 0
% 6n-1xn + 2bn-1 = 0
% solve matrix

A = zeros(20); % initialize matrix
% constant vector
y = [4.5 15.8 52.6 130.4 290.7 15.8 52.6 130.4 290.7 610.2 0 0 0 0 0 0 0 0 0 0];
sol = y.'; % make into column vector

% matrix layout, equations in order from first set of conditions (i = 1:5) to last
%              a1 a2 a3 ... d4 d5
% f1(x1)
% f2(x2)
% ...          [coefficient values]
% 6a1x1 + 2b1
% 6a5x5 + 2b5

for i = 1:5 % first set, then plug coefficients into matrix
    % variables of same letter next to each other, so offset horizontally
    % based on letter
    % offset equations vertically based on which set of equations and which f(x)i it is
    A(i,i) = xi(i).^3;
    A(i,i+5) = xi(i).^2;
    A(i,i+10) = xi(i);
    A(i,i+15) = 1;
    A(i+5,i) = xi(i+1).^3;
    A(i+5,i+5) = xi(i+1).^2;
    A(i+5,i+10) = xi(i+1);
    A(i+5,i+15) = 1;
end

for i = 2:5 % for second and third sets of equations
    A(i+9,i-1) = 3*xi(i)^2;
    A(i+9,i) = -3*xi(i)^2;
    A(i+9,i+4) = 2*xi(i);
    A(i+9,i+5) = -2*xi(i);
    A(i+9,i+9) = 1;
    A(i+9,i+10) = -1;

    A(i+13,i-1) = 6*xi(i);
    A(i+13,i) = -6*xi(i);
    A(i+13,i+4) = 2;
    A(i+13,i+5) = -2;
end
% fourth set
A(19,1) = 6*xi(1);
A(19,6) = 2;
A(20,5) = 6*xi(6);
A(20,10) = 2;
% solve
coeff = A\sol;
% split up based on letter
a = coeff(1:5);
b = coeff(6:10);
c = coeff(11:15);
d = coeff(16:20);

figure
for j = 1:3 % for x given
    for i = 1:5
        x = xi(i):0.5:xi(i+1); % x axis for each equation/spline found
        plot(x,a(i)*x.^3 + b(i)*x.^2 + c(i)*x + d(i),'Color','w') % plot with coefficients solved
        hold on;
        if xa(j) > xi(i) && xa(j) < xi(i+1) % if x value is in the domain of two x points then plot point on that spline
            x = xa(j);
            fx(j) = a(i)*x.^3 + b(i)*x.^2 + c(i)*x + d(i); % using the minimum of the domain and its corresponding y
            line(x,fx(j),"Marker",".","MarkerSize",15,"Color",'m')
        end
    end
end
hold off;
disp(coeff)
disp(fx)