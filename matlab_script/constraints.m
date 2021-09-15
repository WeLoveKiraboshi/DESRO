function [C,Ceq] = fun(x)
h = x(5);
b = x(4);
r = x(2);
Lb = x(3);
R = x(1);
Ey = 210*1.0e9;  % N/m^2
d = 7850;   % kg/m^3
phi_max = pi/3; %detla phi = 2*max_angle
Rw = 0.1; %m

min_inv_inv_J = 1.0;
min_inv_fwd_J = 1.0;

%sample 15 points from regular workspace 
for phi = -phi_max:phi_max/3:phi_max
   for x = -Rw:Rw:Rw
       for y = -Rw:Rw:Rw
           if x^2+y^2 > Rw^2
               continue
           end
           [ro1, ro2, ro3, beta1, beta2, beta3] = IGM(x, y,phi,R,r,Lb, phi_max);
           %[ro1, beta1] = calc_IGM_arm1(x,y,phi,r,R,Lb);
           %[ro2, beta2] = calc_IGM_arm2(x,y,phi,r,R,Lb);
           %[ro3, beta3] = calc_IGM_arm3(x,y,phi,r,R,Lb);
           if ro1 == 0 | ro2 == 0 | ro3 == 0
               continue
           end
           [foward_J, inverse_J] = calc_Jacobian(ro1,ro2,ro3,beta1,beta2,beta3, phi, r);
           inv_cond_inv_J = 1/cond(inverse_J/norm(inverse_J));
           inv_cond_fwd_J = 1/cond(foward_J/norm(foward_J));
           if min_inv_inv_J > inv_cond_inv_J
               min_inv_inv_J = inv_cond_inv_J;
           end
           if min_inv_fwd_J > inv_cond_fwd_J
               min_inv_fwd_J = inv_cond_fwd_J;
           end          
           
       end
   end
end

Ceq = [];

%condition for conditioning number of J
C(1) = 0.1-min_inv_fwd_J;
C(2) = 0.1-min_inv_inv_J;

%conditions about stifness and cross-section of arms
C(3) = 1.e5 - (3*Ey/(Lb+r)^3)*(b*h^3/12);
C(4) = h - b;

%conditions about geometric architecture
C(5) = R/2 - (Lb+r);
%C(6) = 0.1 - (R+Lb+r);
%C(7) = r - R;

