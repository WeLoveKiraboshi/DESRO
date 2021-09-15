function[ro3, beta3] = calc_IGM_arm3(x,y,phi,r,R,Lb)
phi3 = phi + 4*pi/3;
%beta3 = acos((R+r*sin(phi3+pi/6)-y+sqrt(3)*x-sqrt(3)*r*cos(phi3+pi/6))/(2*Lb)) - pi/6 + 2*pi;
%ro3 = 2*(Lb*cos(beta3)+r*cos(phi3+pi/6)-x);

syms ro3_;
equations = [Lb^2==(x-r*cos(phi3+pi/6)-R*cos(pi/2)-ro3_*cos(4*pi/3))^2+(y-r*sin(phi3+pi/6)-R*sin(pi/2)-ro3_*sin(4*pi/3))^2;];
vars = [ro3_];
[T3,paramams,conditions]=solve(equations, vars(1,1),'Real',true, 'ReturnConditions', true);

beta3 = 0;
ro3 = 0;
for i = 1:size(T3)
    if isreal(T3(i)) & 0 < T3(i) & T3(i) < sqrt(3)*R
        sin_beta3 = (y-r*sin(phi3+pi/6)-R*sin(pi/2)-T3(i)*sin(4*pi/3)) / Lb;
        cos_beta3 = (x-r*cos(phi3+pi/6)-R*cos(pi/2)-T3(i)*cos(4*pi/3)) / Lb;
        beta3 = double(atan(sin_beta3/cos_beta3));
        ro3 = double(T3(i));
        return
    end
end
    

end