%% real parameters
m = 1; % kg
k = 10; % N/m
c = sqrt(2*k*m); %Ns/m^2

%% experiment parameters
sampling_time = 0.01; %for both training and validation dataset
experiment_duration = [34.70, 20]; %[for training, for validation]
number_of_experiments = [13, 4]; %[for training, for validation] 

%% definition of model with real parameter; dataset for training ('train') and validation ('val')
% model state dimension = 2 [position, velocity]
A = [0 1; -k/m -c/m];
B = [0; 1/m];
C = [1 0; 0 1];
D = 0;
initial_condition = [0; 0];
system_model = ss(A,B,C,D);
pole(system_model);
dcgain(system_model);
train = perform_experiments(sampling_time, experiment_duration(1), number_of_experiments(1), system_model, initial_condition, true);
val = perform_experiments(sampling_time, experiment_duration(2), number_of_experiments(2), system_model, initial_condition, false);
%% perform an experiment to create dataset = {t, x, u, y}
function dataset = perform_experiments(sampling_time, experiment_duration, number_of_experiments, model, initial_condition, training_phase)
    dataset = cell(1, number_of_experiments);
    for experiment_index = 1 : number_of_experiments
        X0 = initial_condition;
        T = 0 : sampling_time : (experiment_duration-sampling_time);
        if (training_phase)
            U = input_for_training_experiments(experiment_index, experiment_duration, T);
        else
            U = input_for_validation_experiments(experiment_index, experiment_duration, T);
        end
        Y = lsim(model,U,T,X0);
        dataset{experiment_index} = struct('t', double.empty(0,0), 'x', double.empty(0,0), 'u', double.empty, 'y', double.empty(0,0)); 
        dataset{experiment_index}.t = T';
        dataset{experiment_index}.x = [X0'; Y(1:end-1, :)];
        dataset{experiment_index}.u = U';
        dataset{experiment_index}.y = Y;
    end
end
