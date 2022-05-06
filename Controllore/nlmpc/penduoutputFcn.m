function y = penduoutputFcn(x,u)

y = zeros(2,1);
y(1) = x(3);
y(2) = x(4);
end