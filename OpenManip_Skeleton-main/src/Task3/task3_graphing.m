clc;
clear;
close all;

load Task3Data10sec.mat
j_10_c = j_angles;
j_10_t = t_values;
j_10_i = iter;

load Task3Data2sec.mat
j_2_c = j_angles;
j_2_t = t_values;
j_2_i = iter;

figure;
hold on;
grid on;
plot(j_10_t(1:(j_10_i-1)),j_10_c(1,1:(j_10_i-1)), 'DisplayName', 'Joint 1')
plot(j_10_t(1:(j_10_i-1)),j_10_c(2,1:(j_10_i-1)), 'DisplayName', 'Joint 2')
plot(j_10_t(1:(j_10_i-1)),j_10_c(3,1:(j_10_i-1)), 'DisplayName', 'Joint 3')
plot(j_10_t(1:(j_10_i-1)),j_10_c(4,1:(j_10_i-1)), 'DisplayName', 'Joint 4')
title("Joint Angle vs Time (LSPB w/ 10sec Travel Time)")
xlabel("Time (s)")
ylabel("Joint Angle (degree)")
legend
hold off;

figure;
hold on;
grid on;
plot(j_2_t(1:(j_2_i-1)),j_2_c(1,1:(j_2_i-1)), 'DisplayName', 'Joint 1')
plot(j_2_t(1:(j_2_i-1)),j_2_c(2,1:(j_2_i-1)), 'DisplayName', 'Joint 2')
plot(j_2_t(1:(j_2_i-1)),j_2_c(3,1:(j_2_i-1)), 'DisplayName', 'Joint 3')
plot(j_2_t(1:(j_2_i-1)),j_2_c(4,1:(j_2_i-1)), 'DisplayName', 'Joint 4')
title("Joint Angle vs Time (LSPB w/ 2sec Travel Time)")
xlabel("Time (s)")
ylabel("Joint Angle (degree)")
legend