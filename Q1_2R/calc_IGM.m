function [theta1, theta2]=calc_IGM(x, y, l1, l2)
eps = 1.e-12;
theta2 = double((x^2+y^2-l1^2-l2^2)/(2*l1*l2));
theta1 = double(atan(y/(x+eps)) - atan(l2*sin(theta2)/(l1+l2*cos(theta2))));
end