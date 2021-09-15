function f=check_workspace(theta1, theta2, l1, l2)
%range musut be 0~2pi
if isnan(theta1) | isnan(theta2) | isinf(theta1) | isinf(theta2)
    f = 0;
else
    if isreal(theta1) & isreal(theta2) & 0<= theta1 & theta1 <= 2*pi & 0<= theta2 & theta2 <= 2*pi
        f = 1;
    else
        f = 0;
    end
end

f = 1;



    


