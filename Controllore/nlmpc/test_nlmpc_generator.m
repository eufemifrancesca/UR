%NLMPC generator
nlobj = nlmpc(4,2,2);

%To check controller state,output and input dimensions and indices
nlobj.Dimensions

%Controller parameters
Ts = 0.01;
nlobj.Ts = Ts;
nlobj.PredictionHorizon = 6;
nlobj.ControlHorizon = 3;

%Specify prediction model state and output function
nlobj.Model.StateFcn = 'pendustateFcn';
nlobj.Model.OutputFcn = 'penduoutputFcn';
nlobj.Model.IsContinuousTime = false;

%Specify the manipulated variable constraints and output parameters
% nlobj.Weights.OutputVariables = ;
% nlobj.Weights.ManipulatedVariablesRate = ;
% nlobj.MV.Min = ;
% nlobj.MV.Max = ;

%The optimal cost and trajectories are returned as part of the info output argument.
% [~,~,info] = nlmpcmove(nlobj,x0,u0);

%Closed-loop initialization
x0 = [0 0 0 0];
u0 = [0 0];
mv = [0 0];
yref = [0 0];
nloptions = nlmpcmoveopt;
nloptions.Parameters = {Ts};

% Validate the prediction model functions using the initial 
% operating point as the nominal condition for testing
validateFcns(nlobj,x0,u0');

%Closed-loop simulation
Duration = 50;
xHistory = x;
x = [0 0 0 0];

for i = 1:(Duration/Ts)
    %Compute optimal control moves
    [mv,nloptions] = nlmpcmove(nlobj,x,mv,yref,[],nloptions);
    %Implement optimal control move
    % Initial Conditions
    X0 = [0 0 0 0];
    tspan = linspace(0,20,1000);
    
    %parameters
    m1 = 11;
    m2 = 7;
    L1 = 1;
    d1 = 0.5;
    d2 = 0.5;
    I1zz = 11/12;
    I2zz = 7/12;
    g0 = 9.81;
    tau1 = 1;
    tau2 = 1;
    
    options = odeset('AbsTol',1.e-10,'RelTol',1.e-10);
    
    [t,X]=ode45('prova_mathworks',tspan,X0,options);
    
    function [dxdt]=prova_mathqo(t,X,mv)
    
    m1 = 11;
    m2 = 7;
    L1 = 1;
    d1 = 0.5;
    d2 = 0.5;
    I1zz = 11/12;
    I2zz = 7/12;
    g0 = 9.81;
    tau1 = mv(1);
    tau2 = mv(2);
    % tau1 = 1;
    % tau2 = 1;
    
    dxdt = [X(3); (I2zz*tau1 - I2zz*tau2 + d2^2*m2*tau1 - d2^2*m2*tau2 - L1*d2^2*g0*m2^2*cos(X(1)) - I2zz*L1*g0*m2*cos(X(1)) - I2zz*d1*g0*m1*cos(X(1)) - L1*d2*m2*tau2*cos(X(2)) + L1*d2^3*X(3)^2*m2^2*sin(X(2)) + L1*d2^3*X(4)^2*m2^2*sin(X(2)) + L1^2*d2^2*X(3)^2*m2^2*cos(X(2))*sin(X(2)) + L1*d2^2*g0*m2^2*cos(X(1) + X(2))*cos(X(2)) + I2zz*L1*d2*X(3)^2*m2*sin(X(2)) + I2zz*L1*d2*X(4)^2*m2*sin(X(2)) - d1*d2^2*g0*m1*m2*cos(X(1)) + 2*L1*d2^3*X(3)*X(4)*m2^2*sin(X(2)) + 2*I2zz*L1*d2*X(3)*X(4)*m2*sin(X(2)))/(- L1^2*d2^2*m2^2*cos(X(2))^2 + L1^2*d2^2*m2^2 + I2zz*L1^2*m2 + m1*d1^2*d2^2*m2 + I2zz*m1*d1^2 + I1zz*d2^2*m2 + I1zz*I2zz);X(4);-(I2zz*tau1 - I1zz*tau2 - I2zz*tau2 - d1^2*m1*tau2 + d2^2*m2*tau1 - d2^2*m2*tau2 - L1^2*m2*tau2 + L1^2*d2*g0*m2^2*cos(X(1) + X(2)) - L1*d2^2*g0*m2^2*cos(X(1)) + I1zz*d2*g0*m2*cos(X(1) + X(2)) - I2zz*L1*g0*m2*cos(X(1)) - I2zz*d1*g0*m1*cos(X(1)) + L1*d2*m2*tau1*cos(X(2)) - 2*L1*d2*m2*tau2*cos(X(2)) + L1*d2^3*X(3)^2*m2^2*sin(X(2)) + L1^3*d2*X(3)^2*m2^2*sin(X(2)) + L1*d2^3*X(4)^2*m2^2*sin(X(2)) + 2*L1^2*d2^2*X(3)^2*m2^2*cos(X(2))*sin(X(2)) + L1^2*d2^2*X(4)^2*m2^2*cos(X(2))*sin(X(2)) + L1*d2^2*g0*m2^2*cos(X(1) + X(2))*cos(X(2)) - L1^2*d2*g0*m2^2*cos(X(1))*cos(X(2)) + d1^2*d2*g0*m1*m2*cos(X(1) + X(2)) + I1zz*L1*d2*X(3)^2*m2*sin(X(2)) + I2zz*L1*d2*X(3)^2*m2*sin(X(2)) + I2zz*L1*d2*X(4)^2*m2*sin(X(2)) - d1*d2^2*g0*m1*m2*cos(X(1)) + 2*L1*d2^3*X(3)*X(4)*m2^2*sin(X(2)) + 2*L1^2*d2^2*X(3)*X(4)*m2^2*cos(X(2))*sin(X(2)) + L1*d1^2*d2*X(3)^2*m1*m2*sin(X(2)) + 2*I2zz*L1*d2*X(3)*X(4)*m2*sin(X(2)) - L1*d1*d2*g0*m1*m2*cos(X(1))*cos(X(2)))/(- L1^2*d2^2*m2^2*cos(X(2))^2 + L1^2*d2^2*m2^2 + I2zz*L1^2*m2 + m1*d1^2*d2^2*m2 + I2zz*m1*d1^2 + I1zz*d2^2*m2 + I1zz*I2zz)];
    
    %Output generator
    y = [x(3) x(4)];
    %State savings
    xHistory = [xHistory x];
end






