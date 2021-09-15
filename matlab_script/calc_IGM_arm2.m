function[ro2, beta2] = calc_IGM_arm2(x,y,phi,r,R,Lb)
phi2 = phi + 2*pi/3;
%beta2 = acos((y - r*sin(phi2+pi/6)+R/2+sqrt(3)*x-sqrt(3)*r*cos(phi2+pi/6)-3*R/2)/(2*Lb)) + pi/6
%ro2 = 2*(Lb*cos(beta2) - x + r*cos(phi2+pi/6) + R*sqrt(3)/2);

syms ro2_;
equations = [Lb^2==(x-r*cos(phi2+pi/6)-R*cos(pi/6)-ro2_*cos(2*pi/3))^2+(y-r*sin(phi2+pi/6)+R*sin(pi/6)-ro2_*sin(2*pi/3))^2;];
vars = [ro2_];
[T2,paramams,conditions]=solve(equations, vars(1,1),'Real',true, 'ReturnConditions', true);

beta2 = 0;
ro2 = 0;
for i = 1:size(T2)
    if isreal(T2(i)) & 0 < T2(i) & T2(i) < sqrt(3)*R
        sin_beta2 = (y-r*sin(phi2+pi/6)+R*sin(pi/6)-T2(i)*sin(2*pi/3)) / Lb;
        cos_beta2 = (x-r*cos(phi2+pi/6)-R*cos(pi/6)-T2(i)*cos(2*pi/3)) / Lb;
        beta2 = double(atan(sin_beta2/cos_beta2));
        ro2 = double(T2(i));
        return
    end
end
    


end