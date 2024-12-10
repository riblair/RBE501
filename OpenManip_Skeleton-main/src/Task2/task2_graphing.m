clc;
clear;
close all;

load Task2Data10sec.mat
j_10_q = j_angles;
j_10_t = t_values;
j_10_i = iter;
j_10_q_des = j_angles_des;

load Task2Data2sec.mat
j_2_q = j_angles;
j_2_t = t_values;
j_2_i = iter;
j_2_q_des = j_angles_des;

figure;
hold on;
grid on;
plot(j_10_t(1:(j_10_i-1)),j_10_q(1,1:(j_10_i-1)),     'DisplayName', 'Joint 1 Angle',     "Color", "red")
plot(j_10_t(1:(j_10_i-1)),j_10_q_des(1,1:(j_10_i-1)), 'DisplayName', 'Joint 1 Angle Des', "Color", "red",   'LineStyle','--')
plot(j_10_t(1:(j_10_i-1)),j_10_q(2,1:(j_10_i-1)),     'DisplayName', 'Joint 2 Angle',     "Color", "green")
plot(j_10_t(1:(j_10_i-1)),j_10_q_des(2,1:(j_10_i-1)), 'DisplayName', 'Joint 2 Angle Des', "Color", "green", 'LineStyle','--')
plot(j_10_t(1:(j_10_i-1)),j_10_q(3,1:(j_10_i-1)),     'DisplayName', 'Joint 3 Angle',     "Color", "blue")
plot(j_10_t(1:(j_10_i-1)),j_10_q_des(3,1:(j_10_i-1)), 'DisplayName', 'Joint 3 Angle Des', "Color", "blue",  'LineStyle','--')
plot(j_10_t(1:(j_10_i-1)),j_10_q(4,1:(j_10_i-1)),     'DisplayName', 'Joint 4 Angle',     "Color", "black")
plot(j_10_t(1:(j_10_i-1)),j_10_q_des(4,1:(j_10_i-1)), 'DisplayName', 'Joint 4 Angle Des', "Color", "black", 'LineStyle','--')
title("Joint Angle vs Time (LSPB w/ 10sec Travel Time)")
xlabel("Time (s)")
ylabel("Joint Angle (degree)")
legend
hold off;

figure;
hold on;
grid on;
plot(j_2_t(1:(j_2_i-1)),j_2_q(1,1:(j_2_i-1)),     'DisplayName', 'Joint 1 Angle', "Color", "red")
plot(j_2_t(1:(j_2_i-1)),j_2_q_des(1,1:(j_2_i-1)), 'DisplayName', 'Joint 1 Angle Des', "Color", "red", 'LineStyle','--')
plot(j_2_t(1:(j_2_i-1)),j_2_q(2,1:(j_2_i-1)),     'DisplayName', 'Joint 2 Angle', "Color", "green")
plot(j_2_t(1:(j_2_i-1)),j_2_q_des(2,1:(j_2_i-1)), 'DisplayName', 'Joint 2 Angle Des', "Color", "green", 'LineStyle','--')
plot(j_2_t(1:(j_2_i-1)),j_2_q(3,1:(j_2_i-1)),     'DisplayName', 'Joint 3 Angle', "Color", "blue")
plot(j_2_t(1:(j_2_i-1)),j_2_q_des(3,1:(j_2_i-1)), 'DisplayName', 'Joint 3 Angle Des', "Color", "blue", 'LineStyle','--')
plot(j_2_t(1:(j_2_i-1)),j_2_q(4,1:(j_2_i-1)),     'DisplayName', 'Joint 4 Angle', "Color", "black")
plot(j_2_t(1:(j_2_i-1)),j_2_q_des(4,1:(j_2_i-1)), 'DisplayName', 'Joint 4 Angle Des', "Color", "black", 'LineStyle','--')
title("Joint Angle vs Time (LSPB w/ 2sec Travel Time)")
xlabel("Time (s)")
ylabel("Joint Angle (degree)")
legend