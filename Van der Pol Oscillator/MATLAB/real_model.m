%% Real parameter
mu = 2.0;

%% Experiment parameters
sampling_time = 0.01; %for both training and validation dataset
experiment_duration = [34.70, 20]; %[for training, for validation]
number_of_experiments = [13, 4]; %[for training, for validation] 
%% dataset for training ('train') and validation ('val')
initial_condition = [0 0];
train = perform_experiments(sampling_time, experiment_duration(1), number_of_experiments(1), initial_condition, true, mu);
val = perform_experiments(sampling_time, experiment_duration(2), number_of_experiments(2), initial_condition, false, mu);
%%
function dydt = vdp(t, y, mu, U, sampling_time)
    index = floor(t/sampling_time)+1;
    dydt = [y(2); mu*(1-y(1)^2)*y(2)-y(1)+U(index)];
end
%% perform an experiment to create dataset = {t, x, u, y}
function dataset = perform_experiments(sampling_time, experiment_duration, number_of_experiments, initial_condition, training_phase, mu)
    dataset = cell(1, number_of_experiments);
    for experiment_index = 1 : number_of_experiments
        X0 = initial_condition;
        T = 0 : sampling_time : (experiment_duration-sampling_time);
        if (training_phase)
            U = input_for_training_experiments(experiment_index, experiment_duration, T);
        else
            U = input_for_validation_experiments(experiment_index, experiment_duration, T);
        end
        
        [~,Y] = ode45(@(t,y)vdp(t, y, mu, U, sampling_time), T, X0);
        
        dataset{experiment_index} = struct('t', double.empty(0,0), 'x', double.empty(0,0), 'u', double.empty, 'y', double.empty(0,0)); 
        dataset{experiment_index}.t = T';
        dataset{experiment_index}.x = [X0; Y(1:end-1, :)];
        dataset{experiment_index}.u = U';
        dataset{experiment_index}.y = Y;
    end
end