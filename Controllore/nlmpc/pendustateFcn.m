function [dx] = pendustateFcn(x,u)

%states
q1 = x(1);
q2 = x(2);
dq1 = x(3);
dq2 = x(4);

%inputs
tau1 = u(1);
tau2 = u(2);

%parameters
m1 = 11; 
m2 = 7; 
L1 = 1; 
d1 = 0.5; 
d2 = 0.5; 
I1zz = 11/12; 
I2zz = 7/12; 
g0 = 9.81;

%state equations 
dx = zeros(4,1);
dx(1) = x(3);
dx(2) = x(4);
dx(3) = (I2zz*tau1 - I2zz*tau2 + d2^2*m2*tau1 - d2^2*m2*tau2 - L1*d2^2*g0*m2^2*cos(q1) - I2zz*L1*g0*m2*cos(q1) - I2zz*d1*g0*m1*cos(q1) - L1*d2*m2*tau2*cos(q2) + L1*d2^3*dq1^2*m2^2*sin(q2) + L1*d2^3*dq2^2*m2^2*sin(q2) + L1^2*d2^2*dq1^2*m2^2*cos(q2)*sin(q2) + L1*d2^2*g0*m2^2*cos(q1 + q2)*cos(q2) + I2zz*L1*d2*dq1^2*m2*sin(q2) + I2zz*L1*d2*dq2^2*m2*sin(q2) - d1*d2^2*g0*m1*m2*cos(q1) + 2*L1*d2^3*dq1*dq2*m2^2*sin(q2) + 2*I2zz*L1*d2*dq1*dq2*m2*sin(q2))/(- L1^2*d2^2*m2^2*cos(q2)^2 + L1^2*d2^2*m2^2 + I2zz*L1^2*m2 + m1*d1^2*d2^2*m2 + I2zz*m1*d1^2 + I1zz*d2^2*m2 + I1zz*I2zz);
dx(4) = -(I2zz*tau1 - I1zz*tau2 - I2zz*tau2 - d1^2*m1*tau2 + d2^2*m2*tau1 - d2^2*m2*tau2 - L1^2*m2*tau2 + L1^2*d2*g0*m2^2*cos(q1 + q2) - L1*d2^2*g0*m2^2*cos(q1) + I1zz*d2*g0*m2*cos(q1 + q2) - I2zz*L1*g0*m2*cos(q1) - I2zz*d1*g0*m1*cos(q1) + L1*d2*m2*tau1*cos(q2) - 2*L1*d2*m2*tau2*cos(q2) + L1*d2^3*dq1^2*m2^2*sin(q2) + L1^3*d2*dq1^2*m2^2*sin(q2) + L1*d2^3*dq2^2*m2^2*sin(q2) + 2*L1^2*d2^2*dq1^2*m2^2*cos(q2)*sin(q2) + L1^2*d2^2*dq2^2*m2^2*cos(q2)*sin(q2) + L1*d2^2*g0*m2^2*cos(q1 + q2)*cos(q2) - L1^2*d2*g0*m2^2*cos(q1)*cos(q2) + d1^2*d2*g0*m1*m2*cos(q1 + q2) + I1zz*L1*d2*dq1^2*m2*sin(q2) + I2zz*L1*d2*dq1^2*m2*sin(q2) + I2zz*L1*d2*dq2^2*m2*sin(q2) - d1*d2^2*g0*m1*m2*cos(q1) + 2*L1*d2^3*dq1*dq2*m2^2*sin(q2) + 2*L1^2*d2^2*dq1*dq2*m2^2*cos(q2)*sin(q2) + L1*d1^2*d2*dq1^2*m1*m2*sin(q2) + 2*I2zz*L1*d2*dq1*dq2*m2*sin(q2) - L1*d1*d2*g0*m1*m2*cos(q1)*cos(q2))/(- L1^2*d2^2*m2^2*cos(q2)^2 + L1^2*d2^2*m2^2 + I2zz*L1^2*m2 + m1*d1^2*d2^2*m2 + I2zz*m1*d1^2 + I1zz*d2^2*m2 + I1zz*I2zz);
end