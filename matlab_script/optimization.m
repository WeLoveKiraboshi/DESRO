%x = [R,r,Lb,b, h].T
R_init = 0.6;
r_init = 0.6;
Lb_init = 0.6;
b_init = 0.01;
h_init = 0.01;
Param_opt = [R_init,r_init,Lb_init,b_init,h_init]
lb = [0.5, 0.5, 0.5, 0, 0];  % lower bounds of end effector pos
ub = [4, 4, 4, 0.1, 0.1];  % upper bounds of end effector pos
x0 = [R_init, r_init, Lb_init, b_init, h_init];


%options = optimset('Display', 'Iter', 'Tolx', 1e-6,'Tolfun', 1e-10,'MaxFunEvals', 100,'MaxIter', 1000);
options = optimset( 'Display','Iter',...
                    'TolX',1e-5,...
                    'TolFun',1e-5,...
                    'MaxIter',100,...
                    'MaxfunEval',10000);
P_opt = fmincon(@(Param_opt)objective(Param_opt), x0,[],[],[],[],lb,ub,@(Param_opt)constraints(Param_opt),options)
disp('optimized parameters:')
R = P_opt(1)
r = P_opt(2)
Lb= P_opt(3)
b= P_opt(4)
h= P_opt(5)
f = objective(P_opt);
disp('optimized moving mass:')
disp(f)
