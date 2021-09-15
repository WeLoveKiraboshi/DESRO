function [ro1, beta1] = calc_IGM_arm1(x,y,phi,r,R,Lb)

syms ro1_;
equations = [Lb^2==(x-r*cos(phi+pi/6)+R*cos(pi/6)-ro1_)^2+(y-r*sin(phi+pi/6)+R*sin(pi/6))^2;];
vars = [ro1_];
[T1,paramams,conditions]=solve(equations, vars(1,1),'Real',true, 'ReturnConditions', true);

beta1 = 0;
ro1 = 0;
for i = 1:size(T1)
    if isreal(T1(i)) & 0 < T1(i) & T1(i) < sqrt(3)*R
        sin_beta1 = (y-r*sin(phi+pi/6)+R*sin(pi/6)) / Lb; 
        cos_beta1 = (x-r*cos(phi+pi/6)+R*cos(pi/6)-T1(i)) / Lb;
        beta1 = double(atan(sin_beta1/cos_beta1));
        ro1 = double(T1(i));
        return
    end
end
    
end