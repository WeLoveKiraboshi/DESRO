% changable variable: R r L1 L2 phi xp yp
x=[100 30 70];
% constant variables
R = x(1); % mm
r = x(2);
L = x(3);
alp = [11*pi/6, pi/2,7*pi/6];
Ax(1) = R*cos(alp(1));Ay(1) = R*sin(alp(1));
Ax(2) = R*cos(alp(2));Ay(2) = R*sin(alp(2));
Ax(3) = R*cos(alp(3));Ay(3) = R*sin(alp(3));
Ax(4) = Ax(1);Ay(4) = Ay(1); %non sense, for drawing figure
plot(Ax,Ay,'k--o','LineWidth',1);hold on % plot A1A2A3

for phi = 0:0.5:1*pi;
xp = 10*cos(phi);
yp = 10*sin(phi);
Cx(1) = xp+cos(alp(1)+phi)*r; Cy(1) = yp+sin(alp(1)+phi)*r;
Cx(2) = xp+cos(alp(2)+phi)*r; Cy(2) = yp+sin(alp(2)+phi)*r;
Cx(3) = xp+cos(alp(3)+phi)*r; Cy(3) = yp+sin(alp(3)+phi)*r;
Cx(4) = Cx(1);  Cy(4) = Cy(1);
plot(Cx,Cy,'g-o','LineWidth',1);hold on % plot C1C2C3

alpha = [pi, pi+2*pi/3, pi+4*pi/3];
% IGM, solve alpha\beta\gamma with constrain xp/yp/phi
[Xp,Yp] = I_transfrom(Cx(1),Cy(1),alpha(1)-pi,r,Ax(1),Ay(1));
[q1(1),q2(1),q3(1)]=solve(Xp,Yp,R,r,phi,L,alpha(1));
[Xp,Yp] = I_transfrom(Cx(2),Cy(2),alpha(2)-pi,r,Ax(2),Ay(2));
[q1(2),q2(2),q3(2)]=solve(Xp,Yp,R,r,phi,L,alpha(2));
[Xp,Yp] = I_transfrom(Cx(3),Cy(3),alpha(3)-pi,r,Ax(3),Ay(3));
[q1(3),q2(3),q3(3)]=solve(Xp,Yp,R,r,phi,L,alpha(3));

% plot A1A2A3\B1B2B3\C1C2C3\P
xf1(1,1) = Ax(1);xf1(2,1) = xf1(1,1)+q1(1)*cos(alpha(1));xf1(3,1) = xf1(2,1)+L*cos(q2(1));
xf1(1,2) = Ay(1);xf1(2,2) = xf1(1,2)+q1(1)*sin(alpha(1));xf1(3,2) = xf1(2,2)+L*sin(q2(1));
plot(xf1(:,1),xf1(:,2),'k-o','LineWidth',2);hold on
xf2(1,1) = Ax(2);xf2(2,1) = xf2(1,1)+q1(2)*cos(alpha(2));xf2(3,1) = xf2(2,1)+L*cos(q2(2)+2*pi/3);
xf2(1,2) = Ay(2);xf2(2,2) = xf2(1,2)+q1(2)*sin(alpha(2));xf2(3,2) = xf2(2,2)+L*sin(q2(2)+2*pi/3);
plot(xf2(:,1),xf2(:,2),'b-o','LineWidth',2);hold on
xf3(1,1) = Ax(3);xf3(2,1) = xf3(1,1)+q1(3)*cos(alpha(3));xf3(3,1) = xf3(2,1)+L*cos(q2(3)+4*pi/3);
xf3(1,2) = Ay(3);xf3(2,2) = xf3(1,2)+q1(3)*sin(alpha(3));xf3(3,2) = xf3(2,2)+L*sin(q2(3)+4*pi/3);
plot(xf3(:,1),xf3(:,2),'r-o','LineWidth',2);hold on
 
legend('A1A2A3','C1C2C3','limb1','limb2','limb3')
u1 = [cos(alpha(1)); sin(alpha(1))];
u2 = [cos(alpha(2)); sin(alpha(2))];
u3 = [cos(alpha(3)); sin(alpha(3))];
v1 = [cos(q2(1)); sin(q2(1))];
v2 = [cos(q2(2)+2*pi/3); sin(q2(2)+2*pi/3)];
v3 = [cos(q2(3)+4*pi/3); sin(q2(3)+4*pi/3)];
k1 = [cos(alp(1)+phi); sin(alp(1)+phi)];
k2 = [cos(alp(2)+phi); sin(alp(2)+phi)];
k3 = [cos(alp(3)+phi); sin(alp(3)+phi)];
p1=[Ax(1);Ay(1)]+q1(1)*u1+L*v1%+k1*r;
p2=[Ax(2);Ay(2)]+q1(2)*u2+L*v2%+k2*r;
p3=[Ax(3);Ay(3)]+q1(3)*u3+L*v3%+k3*r;
plot(p1(1),p1(2),'k*','MarkerSize',10);hold on
plot(p2(1),p2(2),'b*','MarkerSize',10);hold on
plot(p3(1),p3(2),'r*','MarkerSize',10);hold on
end

function [x,y] = I_transfrom(xp,yp,phi,r,Ax,Ay)
OP = [1 0 0 xp;
    0 1 0 yp;
    0 0 1 0;
    0 0 0 1];
OA = [1 0 0 Ax;
    0 1 0 Ay;
    0 0 1 0;
    0 0 0 1];
T_ao = [cos(phi) -sin(phi) 0 Ax; % A坐标系下表示AO
    sin(phi) cos(phi) 0 Ay;
    0 0 1 0;
    0 0 0 1];% transform matrix
AP = inv(T_ao)*(OP-OA);
x = AP(1,4);
y = AP(2,4);
end

function [q1,q2,q3]=solve(Xp,Yp,R,r,phi,L,alpha)
q2 = real(asin(Yp/L));
q1 = abs(Xp-L*cos(q2)); %from direction, we know q1<0.
% if q1>0
%     q2 = pi/2-q2
%     q1 = Xp-L*cos(q2) 
% end
q3 = phi-q2;
end