function [ro1, ro2, ro3, beta1, beta2, beta3] = IGM(x, y,phi,R,r,Lb, max_angle)
syms ro1_ ro2_ ro3_;
phi2 = phi + 2*pi/3;
phi3 = phi + 4*pi/3;
equations = [Lb^2==(x-r*cos(phi+pi/6)+R*cos(pi/6)-ro1_)^2+(y-r*sin(phi+pi/6)+R*sin(pi/6))^2;
    Lb^2==(x-r*cos(phi2+pi/6)-R*cos(pi/6)-ro2_*cos(2*pi/3))^2+(y-r*sin(phi2+pi/6)+R*sin(pi/6)-ro2_*sin(2*pi/3))^2;
    Lb^2==(x-r*cos(phi3+pi/6)-R*cos(pi/2)-ro3_*cos(4*pi/3))^2+(y-r*sin(phi3+pi/6)-R*sin(pi/2)-ro3_*sin(4*pi/3))^2;
    ];
vars = [ro1_, ro2_, ro3_];
[T1, T2, T3,paramams,conditions]=solve(equations, vars,'Real',true, 'ReturnConditions', true);
solutions = [double(T1) double(T2) double(T3)];
beta1 = 0;
ro1 = 0;
beta2 = 0;
ro2 = 0;
beta3 = 0;
ro3 = 0;
%detla phi = 2*max_angle

for i = 1:size(solutions, 1)
    if isreal(solutions(i, 1)) & 0 < solutions(i, 1) & solutions(i, 1) < sqrt(3)*R & isreal(solutions(i, 2)) & 0 < solutions(i, 2) & solutions(i, 2) < sqrt(3)*R & isreal(solutions(i, 3)) & 0 < solutions(i, 3) & solutions(i, 3) < sqrt(3)*R 
        %{
        sin_beta1 = (y-r*sin(phi+pi/6)+R*sin(pi/6)) / Lb; 
        cos_beta1 = (x-r*cos(phi+pi/6)+R*cos(pi/6)-solutions(i, 1)) / Lb;
        beta1 = double(atan(sin_beta1/cos_beta1));
        ro1 = solutions(i, 1);
        sin_beta2 = (y-r*sin(phi2+pi/6)+R*sin(pi/6)-solutions(i, 2)*sin(2*pi/3)) / Lb;
        cos_beta2 = (x-r*cos(phi2+pi/6)-R*cos(pi/6)-solutions(i, 2)*cos(2*pi/3)) / Lb;
        beta2 = double(atan(sin_beta2/cos_beta2));
        ro2 = solutions(i, 2);
        beta2 = beta2+pi;
        sin_beta3 = (y-r*sin(phi3+pi/6)-R*sin(pi/2)-solutions(i, 3)*sin(4*pi/3)) / Lb;
        cos_beta3 = (x-r*cos(phi3+pi/6)-R*cos(pi/2)-solutions(i, 3)*cos(4*pi/3)) / Lb;
        beta3 = double(atan(sin_beta3/cos_beta3));
        ro3 = solutions(i, 3);
        beta3 = beta3+pi;
        %}
        if -max_angle < beta1 & beta1 < max_angle
            sin_beta2 = (y-r*sin(phi2+pi/6)+R*sin(pi/6)-solutions(i, 2)*sin(2*pi/3)) / Lb;
            cos_beta2 = (x-r*cos(phi2+pi/6)-R*cos(pi/6)-solutions(i, 2)*cos(2*pi/3)) / Lb;
            beta2 = double(atan(sin_beta2/cos_beta2));
            ro2 = solutions(i, 2);
            beta2 = beta2+pi;
            if -max_angle+2*pi/3 < beta2 & beta2 < max_angle+2*pi/3
                sin_beta3 = (y-r*sin(phi3+pi/6)-R*sin(pi/2)-solutions(i, 3)*sin(4*pi/3)) / Lb;
                cos_beta3 = (x-r*cos(phi3+pi/6)-R*cos(pi/2)-solutions(i, 3)*cos(4*pi/3)) / Lb;
                beta3 = double(atan(sin_beta3/cos_beta3));
                ro3 = solutions(i, 3);
                beta3 = beta3+pi;
                if -max_angle+4*pi/3 < beta3 & beta3 < max_angle+4*pi/3
                    return;
                else
                    continue;
                end
            else
                continue;
            end
        else
            continue;
        end
        
        
       
    end
end


%disp('could not find solutions of IGM');
beta1 = 0;
ro1 = 0;
beta2 = 0;
ro2 = 0;
beta3 = 0;
ro3 = 0;
end