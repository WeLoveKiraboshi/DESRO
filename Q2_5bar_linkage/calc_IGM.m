function [theta1, theta2, theta3, theta4, cond]=calc_IGM(x, y,l0,l1,l2,l3,l4)
eps = 1.e-12;
theta1 = acos((l1^2+(x^2+y^2)-l2^2)/(2*l1*sqrt(x^2+y^2))) + acos((l1^2+x^2-(x-l0)^2)/(2*l0*sqrt(x^2+y^2)));
theta2 = theta1 - pi + acos((l1^2+l2^2-(x^2+y^2))/(2*l1*l2));

theta3 = pi - acos((l0^2+(x-l0)^2-x^2)/(2*l0*sqrt((x-l0)^2+y^2))) + acos((l3^2+(x-l0)^2+y^2-l4^2)/(2*l3*sqrt((x-l0)^2+y^2)));
theta4 = pi + theta3 - acos((l3^2+l4^2-((x-l0)^2+y^2))/(2*l3*l4));

theta1 = double(theta1);
theta2 = double(theta2);
theta3 = double(theta3);
theta4 = double(theta4);

if isnan(theta1)|| isinf(theta1) || isnan(theta2) || isinf(theta2) || isnan(theta3) || isinf(theta3) || isnan(theta4) || isinf(theta4)
    cond = 0;
else
    if isreal(theta1) & isreal(theta2) & isreal(theta3) & isreal(theta4)
        cond = 1;
    else
        cond = 0;
    end
end
end % end of this func


%if 0 <= theta1 & theta1 <= pi & 0 <= theta2 & theta2 <= pi & 0 <= theta3 & theta3 <= pi & 0 <= theta4 & theta4 <= pi %angle check