function [dxdt]=eq_dinamica(t,X)

m1 = 11; 
m2 = 7; 
L1 = 1; 
d1 = 0.5; 
d2 = 0.5; 
I1zz = 11/12; 
I2zz = 7/12; 
g0 = 9.81;
tau1 = X(5);
tau2 = X(6);
    
dxdt = [X(3); (I2zz*tau1 - I2zz*tau2 + d2^2*m2*tau1 - d2^2*m2*tau2 - L1*d2^2*g0*m2^2*cos(X(1)) - I2zz*L1*g0*m2*cos(X(1)) - I2zz*d1*g0*m1*cos(X(1)) - L1*d2*m2*tau2*cos(X(2)) + L1*d2^3*X(3)^2*m2^2*sin(X(2)) + L1*d2^3*X(4)^2*m2^2*sin(X(2)) + L1^2*d2^2*X(3)^2*m2^2*cos(X(2))*sin(X(2)) + L1*d2^2*g0*m2^2*cos(X(1) + X(2))*cos(X(2)) + I2zz*L1*d2*X(3)^2*m2*sin(X(2)) + I2zz*L1*d2*X(4)^2*m2*sin(X(2)) - d1*d2^2*g0*m1*m2*cos(X(1)) + 2*L1*d2^3*X(3)*X(4)*m2^2*sin(X(2)) + 2*I2zz*L1*d2*X(3)*X(4)*m2*sin(X(2)))/(- L1^2*d2^2*m2^2*cos(X(2))^2 + L1^2*d2^2*m2^2 + I2zz*L1^2*m2 + m1*d1^2*d2^2*m2 + I2zz*m1*d1^2 + I1zz*d2^2*m2 + I1zz*I2zz);X(4);-(I2zz*tau1 - I1zz*tau2 - I2zz*tau2 - d1^2*m1*tau2 + d2^2*m2*tau1 - d2^2*m2*tau2 - L1^2*m2*tau2 + L1^2*d2*g0*m2^2*cos(X(1) + X(2)) - L1*d2^2*g0*m2^2*cos(X(1)) + I1zz*d2*g0*m2*cos(X(1) + X(2)) - I2zz*L1*g0*m2*cos(X(1)) - I2zz*d1*g0*m1*cos(X(1)) + L1*d2*m2*tau1*cos(X(2)) - 2*L1*d2*m2*tau2*cos(X(2)) + L1*d2^3*X(3)^2*m2^2*sin(X(2)) + L1^3*d2*X(3)^2*m2^2*sin(X(2)) + L1*d2^3*X(4)^2*m2^2*sin(X(2)) + 2*L1^2*d2^2*X(3)^2*m2^2*cos(X(2))*sin(X(2)) + L1^2*d2^2*X(4)^2*m2^2*cos(X(2))*sin(X(2)) + L1*d2^2*g0*m2^2*cos(X(1) + X(2))*cos(X(2)) - L1^2*d2*g0*m2^2*cos(X(1))*cos(X(2)) + d1^2*d2*g0*m1*m2*cos(X(1) + X(2)) + I1zz*L1*d2*X(3)^2*m2*sin(X(2)) + I2zz*L1*d2*X(3)^2*m2*sin(X(2)) + I2zz*L1*d2*X(4)^2*m2*sin(X(2)) - d1*d2^2*g0*m1*m2*cos(X(1)) + 2*L1*d2^3*X(3)*X(4)*m2^2*sin(X(2)) + 2*L1^2*d2^2*X(3)*X(4)*m2^2*cos(X(2))*sin(X(2)) + L1*d1^2*d2*X(3)^2*m1*m2*sin(X(2)) + 2*I2zz*L1*d2*X(3)*X(4)*m2*sin(X(2)) - L1*d1*d2*g0*m1*m2*cos(X(1))*cos(X(2)))/(- L1^2*d2^2*m2^2*cos(X(2))^2 + L1^2*d2^2*m2^2 + I2zz*L1^2*m2 + m1*d1^2*d2^2*m2 + I2zz*m1*d1^2 + I1zz*d2^2*m2 + I1zz*I2zz); 0; 0];

end