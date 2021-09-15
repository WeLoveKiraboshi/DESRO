function [A,B] = calc_Jacobian(ro1,ro2,ro3,beta1,beta2,beta3, phi, r)
b1 = [cos(beta1); sin(beta1)];
b2 = [cos(beta2); sin(beta2)];
b3 = [cos(beta3); sin(beta3)];
a1 = [cos(0); sin(0)];
a2 = [cos(2*pi/3); sin(2*pi/3)];
a3 = [cos(4*pi/3); sin(4*pi/3)];
phi2 = phi + 2*pi/3;
phi3 = phi - 2*pi/3;
e1 = [-cos(phi+pi/6); -sin(phi+pi/6)];
e2 = [-cos(phi2+pi/6); -sin(phi2+pi/6)];
e3 = [-cos(phi3+pi/6); -sin(phi3+pi/6)];
E = [0,-1;1,0];
A = [transpose(b1), r*transpose(b1)*E*e1; transpose(b2), r*transpose(b2)*E*e2; transpose(b3), r*transpose(b3)*E*e3];
B = [transpose(b1)*a1, 0, 0; 0, transpose(b2)*a2, 0; 0, 0, transpose(b3)*a3];
%J = inv(B)*A;
end

