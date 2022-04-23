function y  = input_for_validation_experiments(experiment_index, experiment_duration, T)
    switch experiment_index
        case 1
            linear_interval = linspace(-experiment_duration/2, (experiment_duration+0.01)/2, (experiment_duration+0.01)*100);
            sinc_function = sinc(linear_interval);
            amplitude = 10;
            y = amplitude.*sinc_function(floor((T+0.01)*100));
        case 2
            amplitude = 5;
            barthan = barthannwin((experiment_duration+0.01)*100);
            y = amplitude*barthan(floor((T+0.02)*100))';
        case 3
            y = cos(T);
        case 4
            amplitude = 2.5;
            y = amplitude*rand(size(T, 2), 1)';
    end
end