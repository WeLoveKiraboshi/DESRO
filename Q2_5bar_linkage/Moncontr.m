function [C,Ceq] = fun(x)
Ey = 2.e11;  % N/m^2
ro = 7860;   % kg/m^3
l0 = x(1); %m
l1 = x(2); %m
l2 = x(3); %m
l3 = x(4); %m
l4 = x(5); %m
b = x(6); %m
h = x(7); %m

min_invJ_left = 1.0;
min_invJ_right = 1.0;

           
%sample 25 points from regular workspace (0.5 * 0.5 planar grid)
for x = 0.0:0.1:0.5
   for y = 0.0:0.1:0.5
       [theta1, theta2, theta3, theta4, cond]= calc_IGM(x,y,l0,l1,l2,l3,l4);
       if cond == 0
           continue;
       end
       
       try
           J_left = [-l1*sin(theta1),-l2*sin(theta2); l1*cos(theta1),l2*cos(theta2)]
           inv_condJ_left = 1/cond(J_left);
       catch
           continue;
       end
       if min_invJ_left > inv_condJ_left
           min_invJ_left = inv_condJ_left;
       end
       
       
       try
           J_right = [-l3*sin(theta3),-l4*sin(theta4); l3*cos(theta3),l4*cos(theta4)]
           inv_condJ_right = 1/cond(J_right);
       catch
           continue;
       end
       if min_invJ_right > inv_condJ_right
           min_invJ_right = inv_condJ_right;
       end
           
   end
end

%condition for conditioning number of J
C(1) = 0.2-min_invJ_left;
C(2) = 0.2-min_invJ_right;

%comndition for Stiffness
C(3) = 1.0e6 - (3*Ey*b*h^3/12) / (l1+l2)^3;
C(4) = 1.0e6 - (3*Ey*b*h^3/12) / (l0+l3+l4)^3;

%condition of moving workspace
C(5) = 0.5*sqrt(2)-(l1 + l2);
C(6) = 0.5*sqrt(2)-(l0 + l3 + l4);
C(7) = h - b;

Ceq = [];

