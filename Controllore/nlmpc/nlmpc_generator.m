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
    
    %Output generator
    y = [x(3) x(4)];
    %State savings
    xHistory = [xHistory x];
end

plot(Duration, xHistory(1,:),'b')
plot(Duration, xHistory(2,:),'r')






