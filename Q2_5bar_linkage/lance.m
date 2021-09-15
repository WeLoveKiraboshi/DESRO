clear
clc;
%parameters for optimization
% x = [l1, l2, b, h]
lb = [1.e-2, 1.e-2, 1.e-2, 1.e-2, 1.e-2, 1.e-4, 1.e-4];  % lower bounds of end effector pos
ub = [0.5, 0.5, 0.5, 0.5, 0.5, 1.e-1, 1.e-1];  % upper bounds of end effector pos
x0 = [0.1, 0.1, 0.1, 0.1, 0.1, 1.e-3, 1.e-3];
options = optimset('Display', 'off', 'Tolx', 1e-6,'Tolfun', 1e-8,'MaxFunEvals', 400,'MaxIter', 100);
x = fmincon('Monfunc', x0,[],[],[],[],lb,ub,'Moncontr',options);
f = Monfunc(x); %weight
disp('optimized moving mass(min):')
disp(f);
disp('optimized Parameters: l0, l1, l2, l3, l4, b, h'); 
disp(x);