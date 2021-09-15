


%Z = zeros(10,10)
step_theta1 = pi/180;
step_theta2 = pi/180;
max_iteration_theta1 = 10;
max_iteration_theta2 = 10;

for i = 1:max_iteration_theta1
    for j = 1:max_iteration_theta2
        z=sin(i)+sin(j);
        Z(i,j) = z;
    end
end

x = 1:max_iteration_theta1;
y = 1:max_iteration_theta2;
[X,Y] = meshgrid(x,y);
surf(X,Y,Z);