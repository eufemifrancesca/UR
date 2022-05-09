X0 = [0 0 0 0];
tspan = linspace(0,1,100);

%parameters
m1 = 11; 
m2 = 7; 
L1 = 1; 
d1 = 0.5; 
d2 = 0.5; 
I1zz = 11/12; 
I2zz = 7/12; 
g0 = 9.81;

options = odeset('AbsTol',1.e-10,'RelTol',1.e-10);

[t,X] = ode45('eq_dinamica_prova',tspan,X0,options);





