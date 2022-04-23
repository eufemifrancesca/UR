%% Plot Training experiments
TrainingExperimentsTitle = [" 1. Input = A(t)*sin(t)",...
                            " 2. Input = sign(t)*t",...
                            " 3. Input = A(t)*(sin(t)^2)",...
                            " 4. Input = Triangle Wave",...
                            " 5. Input = A(t)*square(t*pi/4)",...
                            " 6. Input = A(t)*sawtooth(t*pi/4)",...
                            " 7. Input = A(t)*atan(t)",...
                            " 8. Input = log(t + 1).*sin(t).*cos(t)",...
                            " 9. Input = A(t)*sawtooth(t*pi/4)*sin(t)",...
                            " 10. Input = A(t)*square(t*pi/4)*sin(t)",...
                            " 11. Input = square(t*pi/4)*sqrt(t)",...
                            " 12. Input = 1 - square(t*pi)",...
                            " 13. Input = sqrt(t) - A(t)*square(t*pi/2)",];
for index = 1:13
    x = train{index}.x(:,1);
    y = train{index}.x(:,2);
    figure;
    plot(x,y);
    title( strcat("Experiment",TrainingExperimentsTitle(index)) );
    xlabel('Position');
    ylabel('Velocity');
end

%% Plot Validation experiments
ValidationExperimentsTitle = [" 1. Input = A*sinc(t)",...
                              " 2. Input = A*barthannwin(t)",...
                              " 3. Input = cos(t)",...
                              " 4. Input = A*rand"];
for index = 1:4
    x = val{index}.x(:,1);
    y = val{index}.x(:,2);
    figure
    plot(x,y);
    title( strcat("Experiment",ValidationExperimentsTitle(index)) );
    xlabel('Position');
    ylabel('Velocity');
end

%%
training_input = [];
for index = 1:13
    training_input = [training_input; train{index}.u];
end
figure
plot(training_input);
title( "Input force profile (13 training experiments)" );
xlabel('Time [s]');
ylabel('Input Force [N]');
%%
training_input = [];
for index = 1:4
    training_input= [training_input; val{index}.u];
end
figure
plot(training_input);
title( "Input force profile (4 validation experiments)" );
xlabel('Time [s]');
ylabel('Input Force [N]');
