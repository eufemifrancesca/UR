clc,clear
format long e

%NLMPC generator
nlobj = nlmpc(4,4,2);

%To check controller state,output and input dimensions and indices
nlobj.Dimensions

%Controller parameters
Ts = 0.02;
p = 15;
m = 3;
nlobj.Ts = Ts;
nlobj.PredictionHorizon = p;
nlobj.ControlHorizon = m;

%Specify prediction model state and output function
nlobj.Model.StateFcn = 'pendustateFcn';
nlobj.Model.OutputFcn = 'penduoutputFcn';
nlobj.Model.IsContinuousTime = false;

%Closed-loop initialization
x0 = [-pi/2 -pi/2 0 0];
u0 = [0 0];
mv = [0 0];
yref = [pi/4 pi/4 0 0];
nloptions = nlmpcmoveopt;
nloptions.Parameters = {Ts};
nloptions.StateMax = [2*pi 2*pi pi/30 pi/30];
nloptions.StateMin = -[2*pi 2*pi pi/30 pi/30];

% Validate the prediction model functions using the initial 
% operating point as the nominal condition for testing
validateFcns(nlobj,x0,u0,[],[],yref);

%Closed-loop simulation
Duration = 30;
x = x0;
xHistory = x;
mv_history = mv;
ddx_history = [];
q1_current = x0(1);
q2_current = x0(2);
dq1_current = x0(3);
dq2_current = x0(4);

for i = 1:(Duration/Ts)
    [mv_sol,nloptions] = nlmpcmove(nlobj,x,mv,yref,[],nloptions);
    mv = mv_sol;
    [ddx] = pendustateFcn(x,mv);
    dq1 = dq1_current + ddx(3)*Ts;
    dq2 = dq2_current + ddx(4)*Ts;
    q1 = q1_current + dq1*Ts + 0.5*ddx(3)*Ts^2;
    q2 = q2_current + dq2*Ts + 0.5*ddx(4)*Ts^2;
    x = [q1 q2 dq1 dq2];
    xHistory = [xHistory ; x];
    mv_history = [mv_history ; mv'];
    ddx_history = [ddx_history ; ddx];
    q1_current = q1;
    q2_current = q2;
    dq1_current = dq1;
    dq2_current = dq2;
end

display(rad2deg(q1)-floor(rad2deg(q1)/360)*360)
% display(rad2deg(q2))

