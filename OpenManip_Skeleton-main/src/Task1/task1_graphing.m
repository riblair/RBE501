clc;
clear;
close all;

load Task1Data0.5sec.mat
j2_c = j_currents;
j2_t = t_values;
j2_i = iters-1;

figure;
hold on;
grid on;
plot(j2_t(1, 1:j2_i(1)), j2_c(1, 1:j2_i(1)), 'DisplayName', '100% (0.5 Travel Time)', 'Color', 'red');
plot(j2_t(2, 1:j2_i(2)), j2_c(2, 1:j2_i(2)), 'DisplayName', '80% (0.625 Travel Time)', 'Color', 'green');
plot(j2_t(3, 1:j2_i(3)), j2_c(3, 1:j2_i(3)), 'DisplayName', '60% (0.833 Travel Time)', 'Color', 'blue');
plot(j2_t(4, 1:j2_i(4)), j2_c(4, 1:j2_i(4)), 'DisplayName', '40% (1.25 Travel Time)', 'Color', 'black');

title("Current vs Time of Joint 2")
xlabel("Time (s)")
ylabel("CUrrent (mA)")
legend