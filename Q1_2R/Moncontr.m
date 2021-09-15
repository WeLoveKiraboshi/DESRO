function [C,Ceq] = fun(x)
Ey = 2.e11;  % N/m^2
ro = 7860;   % kg/m^3
l1 = x(1); %m
l2 = x(2); %m
b = x(3); %m
h = x(4); %m

min_invJ = 1.0;

%sample 25 points from regular workspace (0.5 * 0.5 planar grid)
for x = 0.0:0.1:0.5
   for y = 0.0:0.1:0.5
       [theta1, theta2]= calc_IGM(x,y,l1,l2);
       if check_workspace(theta1, theta2, l1, l2) == 0
           continue;
       else
           s1 = sin(theta1);
           c1 = cos(theta1);
           s12 = sin(theta1+theta2);
           c12 = cos(theta1+theta2);
           J(1,1)=-l1*s1-l2*s12;
           J(1,2)=-l2*s12;
           J(2,1)=l1*c1+l2*c12;
           J(2,2)=l2*c12;
           disp(J)
           inv_condJ = 1/cond(J);
           if min_invJ > inv_condJ
               min_invJ = inv_condJ;
           end
       end
           
   end
end

%condition for conditioning number of J
C(1) = 0.2-min_invJ;

%comndition for Stiffness
C(2) = 0.5*sqrt(2) - (l1+l2);
C(3) = 1.0e6 - ((3*Ey*b*h^3/12) / (l1+l2)^3);
C(4) = h - b;

%condition of moving workspace
Ceq = [];

