clc;
clear;
close all;

load Task2Data10sec.mat
j_20_c = j_angles;
j_20_t = t_values - 10;
j_20_i = iter;

load Task2Data2sec.mat
j_3_c = j_angles;
j_3_t = t_values -2;
j_3_i = iter;



figure;
hold on;
grid on;
plot(j_20_t(1:(j_20_i-1)),j_20_c(1,1:(j_20_i-1)), 'DisplayName', '20s Travel Time J1')
plot(j_20_t(1:(j_20_i-1)),j_20_c(2,1:(j_20_i-1)), 'DisplayName', '20s Travel Time J2')
plot(j_20_t(1:(j_20_i-1)),j_20_c(3,1:(j_20_i-1)), 'DisplayName', '20s Travel Time J3')
plot(j_20_t(1:(j_20_i-1)),j_20_c(4,1:(j_20_i-1)), 'DisplayName', '20s Travel Time J4')
% plot(j_3_t(1:(j_3_i-1)),j_3_c(1,1:(j_3_i-1)), 'DisplayName', '3s Travel Time J1')
% plot(j_3_t(1:(j_3_i-1)),j_3_c(2,1:(j_3_i-1)), 'DisplayName', '3s Travel Time J2')
% plot(j_3_t(1:(j_3_i-1)),j_3_c(3,1:(j_3_i-1)), 'DisplayName', '3s Travel Time J3')
% plot(j_3_t(1:(j_3_i-1)),j_3_c(4,1:(j_3_i-1)), 'DisplayName', '3s Travel Time J4')


title("Joing Angle vs Time LSPB")
xlabel("Time (s)")
ylabel("Joint Angle")
legend