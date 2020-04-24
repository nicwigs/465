


x = [wheel_travel(1) -2.5  -2 -1 0 1 2 2.5 wheel_travel(end)];
y = [0 0 0 -.5 -2.5 -.5 0 0 0];
p = polyfit(x, y, 5)
v = polyval(p, wheel_travel)
figure(1)
plot(x ,y,'x','MarkerEdgeColor','black')
hold on
plot(wheel_travel, v)