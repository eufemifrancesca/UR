function y  = input_for_training_experiments(experiment_index, experiment_duration, T)
    amplitude = floor(T/6) + 1;
    y = 0;
    switch experiment_index
        case 1
            initial_y = sin(T);
            y = amplitude .* initial_y;
        case 2
            initial_y = amplitude .* T; %ramp with variable slope [positive or negative] and start position
            sign = (mod(amplitude, 2) ./ 5) - 0.1;
            y = sign .* initial_y;
        case 3
            y = amplitude.*(sin(T).^2);
        case 4
            sign = repelem([1, 0], floor(size(T,2)/2));
            y = sign .* T + (sign - 1) .* (T - experiment_duration - 1.2) ;
        case 5
            y = amplitude.*square(pi/4*T);
        case 6
            y = amplitude.*sawtooth(pi/4*T);
        case 7
            y = amplitude.*atan(T);
        case 8
            y = log(T + 1).*sin(T).*cos(T);
        case 9
            y = amplitude.*sawtooth(pi/4*T).*sin(T);
        case 10
            y = amplitude.*square(pi/4*T).*sin(T);
        case 11
            y = square(pi/4*T).*sqrt(T);
        case 12
            y = 1 - square(pi*T);
        case 13
            y = sqrt(T) - amplitude.*square(pi/2*T);
    end
end