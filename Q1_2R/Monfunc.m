function f=fun(x)
Ey = 2.e11;  % N/m^2
ro = 7860;   % kg/m^3
l1 = x(1); %m
l2 = x(2); %m
b = x(3); %m
h = x(4); %m
f = ro*b*h*(l1+l2);
