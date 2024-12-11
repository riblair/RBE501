clc;
clear;
close all;

load Task_1_Torques.mat
j_t_g = j_torques_guess;
j_t_i = j_torques_inv;
j_10_t = t_values;
j_10_i = iter;

figure;
hold on;
grid on;
plot(j_10_t(1:(j_10_i-1)),j_t_g(1,1:(j_10_i-1)), 'DisplayName', 'Joint 1 Torque Current Estimate', "Color", "red")
plot(j_10_t(1:(j_10_i-1)),j_t_i(1,1:(j_10_i-1)), 'DisplayName', 'Joint 1 Torque Inverse Dynamics', "Color", "red", 'LineStyle','--')
plot(j_10_t(1:(j_10_i-1)),j_t_g(2,1:(j_10_i-1)), 'DisplayName', 'Joint 2 Torque Current Estimate', "Color", "green")
plot(j_10_t(1:(j_10_i-1)),j_t_i(2,1:(j_10_i-1)), 'DisplayName', 'Joint 2 Torque Inverse Dynamics', "Color", "green", 'LineStyle','--')
plot(j_10_t(1:(j_10_i-1)),j_t_g(3,1:(j_10_i-1)), 'DisplayName', 'Joint 3 Torque Current Estimate', "Color", "blue")
plot(j_10_t(1:(j_10_i-1)),j_t_i(3,1:(j_10_i-1)), 'DisplayName', 'Joint 3 Torque Inverse Dynamics', "Color", "blue", 'LineStyle','--')
plot(j_10_t(1:(j_10_i-1)),j_t_g(4,1:(j_10_i-1)), 'DisplayName', 'Joint 4 Torque Current Estimate', "Color", "black")
plot(j_10_t(1:(j_10_i-1)),j_t_i(4,1:(j_10_i-1)), 'DisplayName', 'Joint 4 Torque Inverse Dynamics', "Color", "black", 'LineStyle','--')
hold off;
xlabel("Time (s)")
ylabel("Joint Torque")
title("Joint Torque Estimates at Max Speed")
legend