clc;
clear;
close all;

load Task3Data10sec.mat
j_10_q = j_angles;
j_10_qdot = j_velos;
j_10_t = t_values;
j_10_i = iter;

load Task3Data_stiched2sec.mat
j_2_q = j_angles;
j_2_qdot = j_velos;
j_2_t = t_values;
j_2_i = iter;

figure;
subplot(1,2,1);
hold on;
grid on;
plot(j_10_t(1:(j_10_i-1)),j_10_q(1,1:(j_10_i-1)), 'DisplayName', 'Joint 1 Angle')
plot(j_10_t(1:(j_10_i-1)),j_10_q(2,1:(j_10_i-1)), 'DisplayName', 'Joint 2 Angle')
plot(j_10_t(1:(j_10_i-1)),j_10_q(3,1:(j_10_i-1)), 'DisplayName', 'Joint 3 Angle')
plot(j_10_t(1:(j_10_i-1)),j_10_q(4,1:(j_10_i-1)), 'DisplayName', 'Joint 4 Angle')
hold off;
xlabel("Time (s)")
ylabel("Joint Angle (degree)")
legend

subplot(1,2,2);
hold on;
plot(j_10_t(1:(j_10_i-1)),j_10_qdot(1,1:(j_10_i-1)), 'DisplayName', 'Joint 1 Velo')
plot(j_10_t(1:(j_10_i-1)),j_10_qdot(2,1:(j_10_i-1)), 'DisplayName', 'Joint 2 Velo')
plot(j_10_t(1:(j_10_i-1)),j_10_qdot(3,1:(j_10_i-1)), 'DisplayName', 'Joint 3 Velo')
plot(j_10_t(1:(j_10_i-1)),j_10_qdot(4,1:(j_10_i-1)), 'DisplayName', 'Joint 4 Velo')
hold off;
xlabel("Time (s)")
ylabel("Joint Velocity (degree/sec)")
legend
sgtitle("Joint Angle and Velocities vs Time (LSPB w/ 10sec Travel Time)")

figure;
subplot(1,2,1);
hold on;
grid on;
plot(j_2_t(1:(j_2_i-1)),j_2_q(1,1:(j_2_i-1)), 'DisplayName', 'Joint 1 Angle')
plot(j_2_t(1:(j_2_i-1)),j_2_q(2,1:(j_2_i-1)), 'DisplayName', 'Joint 2 Angle')
plot(j_2_t(1:(j_2_i-1)),j_2_q(3,1:(j_2_i-1)), 'DisplayName', 'Joint 3 Angle')
plot(j_2_t(1:(j_2_i-1)),j_2_q(4,1:(j_2_i-1)), 'DisplayName', 'Joint 4 Angle')
hold off;
xlabel("Time (s)")
ylabel("Joint Angle (degree)")
legend

subplot(1,2,2);
hold on;
plot(j_2_t(1:(j_2_i-1)),j_2_qdot(1,1:(j_2_i-1)), 'DisplayName', 'Joint 1 Velo')
plot(j_2_t(1:(j_2_i-1)),j_2_qdot(2,1:(j_2_i-1)), 'DisplayName', 'Joint 2 Velo')
plot(j_2_t(1:(j_2_i-1)),j_2_qdot(3,1:(j_2_i-1)), 'DisplayName', 'Joint 3 Velo')
plot(j_2_t(1:(j_2_i-1)),j_2_qdot(4,1:(j_2_i-1)), 'DisplayName', 'Joint 4 Velo')
hold off;
xlabel("Time (s)")
ylabel("Joint Velocity (degree/sec)")
legend
sgtitle("Joint Angle and Velocities vs Time (LSPB w/ 2sec Travel Time)")