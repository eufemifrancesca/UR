%NLMPC generator
nlobj = nlmpc(4,2,2);

%To check controller state,output and input dimensions and indices
nlobj.Dimensions

%Controller parameters
Ts = 0.01;
p = 3;
nlobj.Ts = Ts;
nlobj.PredictionHorizon = p;
nlobj.ControlHorizon = p;

%Specify prediction model state and output function
nlobj.Model.StateFcn = 'pendustateFcn';
nlobj.Model.OutputFcn = 'penduoutputFcn';
% nlobj.Jacobian.StateFcn = 'pendustatejacobianFcn';

nlobj.Model.IsContinuousTime = false;

%Specify the manipulated variable constraints and output parameters
% nlobj.Weights.OutputVariables = ;
% nlobj.Weights.ManipulatedVariablesRate = ;
% nlobj.MV.Min = ;
% nlobj.MV.Max = ;

%Closed-loop initialization
x0 = [0 0 0 0];
u0 = [0 0];
mv = [0 0];
yref = [0.2 0.2];
nloptions = nlmpcmoveopt;
nloptions.Parameters = {Ts};

% Validate the prediction model functions using the initial 
% operating point as the nominal condition for testing
validateFcns(nlobj,x0,u0');

%Closed-loop simulation
Duration = 1;
x = [0 0 0 0];
xHistory = x;
mv_history = mv;
X0 = x;
tspan = linspace(0,Duration,Duration/Ts + 1);
options = odeset('AbsTol',1.e-5,'RelTol',1.e-5);


for i = 1:(Duration/Ts)
    %Compute optimal control moves
    [mv_sol,nloptions] = nlmpcmove(nlobj,x,mv,yref,[],nloptions);
    mv = mv_sol;
    %Implement optimal control move
    x_0_dinamica = [x,mv'];
    [t,sol] = ode45('eq_dinamica',tspan,x_0_dinamica,options);
    x = sol(i+1,1:4);
    %Savings data
    xHistory = [xHistory ; x];
    mv_history = [mv_history ; mv'];
end







