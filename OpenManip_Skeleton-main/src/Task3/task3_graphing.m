clc;
clear;
close all;

load Task3DataStiched10sec.mat
j_10_q = j_angles;
j_10_qdot = j_velos;
j_10_t = t_values;
j_10_i = iter;
j_10_q_des = j_angles_des;
j_10_qdot_des = j_velos_des;

load Task3DataStiched5sec.mat
j_2_q = j_angles;
j_2_qdot = j_velos;
j_2_t = t_values;
j_2_i = iter;
j_2_q_des = j_angles_des;
j_2_qdot_des = j_velos_des;

figure;
subplot(1,2,1);
hold on;
grid on;
plot(j_10_t(1:(j_10_i-1)),j_10_q(1,1:(j_10_i-1)), 'DisplayName', 'Joint 1 Angle', "Color", "red")
plot(j_10_t(1:(j_10_i-1)),j_10_q_des(1,1:(j_10_i-1)), 'DisplayName', 'Joint 1 Angle Des', "Color", "red", 'LineStyle','--')
plot(j_10_t(1:(j_10_i-1)),j_10_q(2,1:(j_10_i-1)), 'DisplayName', 'Joint 2 Angle', "Color", "green")
plot(j_10_t(1:(j_10_i-1)),j_10_q_des(2,1:(j_10_i-1)), 'DisplayName', 'Joint 2 Angle Des', "Color", "green", 'LineStyle','--')
plot(j_10_t(1:(j_10_i-1)),j_10_q(3,1:(j_10_i-1)), 'DisplayName', 'Joint 3 Angle', "Color", "blue")
plot(j_10_t(1:(j_10_i-1)),j_10_q_des(3,1:(j_10_i-1)), 'DisplayName', 'Joint 3 Angle Des', "Color", "blue", 'LineStyle','--')
plot(j_10_t(1:(j_10_i-1)),j_10_q(4,1:(j_10_i-1)), 'DisplayName', 'Joint 4 Angle', "Color", "black")
plot(j_10_t(1:(j_10_i-1)),j_10_q_des(4,1:(j_10_i-1)), 'DisplayName', 'Joint 4 Angle Des', "Color", "black", 'LineStyle','--')
hold off;
xlabel("Time (s)")
ylabel("Joint Angle (degree)")
legend

subplot(1,2,2);
hold on;
plot(j_10_t(1:(j_10_i-1)),j_10_qdot(1,1:(j_10_i-1)), 'DisplayName', 'Joint 1 Velocity', "Color", "red")
plot(j_10_t(1:(j_10_i-1)),j_10_qdot_des(1,1:(j_10_i-1)), 'DisplayName', 'Joint 1 Velocity Des', "Color", "red", 'LineStyle','--')
plot(j_10_t(1:(j_10_i-1)),j_10_qdot(2,1:(j_10_i-1)), 'DisplayName', 'Joint 2 Velocity', "Color", "green")
plot(j_10_t(1:(j_10_i-1)),j_10_qdot_des(2,1:(j_10_i-1)), 'DisplayName', 'Joint 2 Velocity Des', "Color", "green", 'LineStyle','--')
plot(j_10_t(1:(j_10_i-1)),j_10_qdot(3,1:(j_10_i-1)), 'DisplayName', 'Joint 3 Velocity', "Color", "blue")
plot(j_10_t(1:(j_10_i-1)),j_10_qdot_des(3,1:(j_10_i-1)), 'DisplayName', 'Joint 3 Velocity Des', "Color", "blue", 'LineStyle','--')
plot(j_10_t(1:(j_10_i-1)),j_10_qdot(4,1:(j_10_i-1)), 'DisplayName', 'Joint 4 Velocity', "Color", "black")
plot(j_10_t(1:(j_10_i-1)),j_10_qdot_des(4,1:(j_10_i-1)), 'DisplayName', 'Joint 4 Velocity Des', "Color", "black", 'LineStyle','--')
hold off;
xlabel("Time (s)")
ylabel("Joint Velocity (degree/sec)")
legend
sgtitle("Joint Angle and Velocities vs Time (LSPB w/ 10sec Travel Time)")

figure;
subplot(1,2,1);
hold on;
grid on;
plot(j_2_t(1:(j_2_i-1)),j_2_q(1,1:(j_2_i-1)), 'DisplayName', 'Joint 1 Angle', "Color", "red")
plot(j_2_t(1:(j_2_i-1)),j_2_q_des(1,1:(j_2_i-1)), 'DisplayName', 'Joint 1 Angle Des', "Color", "red", 'LineStyle','--')
plot(j_2_t(1:(j_2_i-1)),j_2_q(2,1:(j_2_i-1)), 'DisplayName', 'Joint 2 Angle', "Color", "green")
plot(j_2_t(1:(j_2_i-1)),j_2_q_des(2,1:(j_2_i-1)), 'DisplayName', 'Joint 2 Angle Des', "Color", "green", 'LineStyle','--')
plot(j_2_t(1:(j_2_i-1)),j_2_q(3,1:(j_2_i-1)), 'DisplayName', 'Joint 3 Angle', "Color", "blue")
plot(j_2_t(1:(j_2_i-1)),j_2_q_des(3,1:(j_2_i-1)), 'DisplayName', 'Joint 3 Angle Des', "Color", "blue", 'LineStyle','--')
plot(j_2_t(1:(j_2_i-1)),j_2_q(4,1:(j_2_i-1)), 'DisplayName', 'Joint 4 Angle', "Color", "black")
plot(j_2_t(1:(j_2_i-1)),j_2_q_des(4,1:(j_2_i-1)), 'DisplayName', 'Joint 4 Angle Des', "Color", "black", 'LineStyle','--')
hold off;
xlabel("Time (s)")
ylabel("Joint Angle (degree)")
legend

subplot(1,2,2);
hold on;
plot(j_2_t(1:(j_2_i-1)),j_2_qdot(1,1:(j_2_i-1)), 'DisplayName', 'Joint 1 Velocity', "Color", "red")
plot(j_2_t(1:(j_2_i-1)),j_2_qdot_des(1,1:(j_2_i-1)), 'DisplayName', 'Joint 1 Velocity Des', "Color", "red", 'LineStyle','--')
plot(j_2_t(1:(j_2_i-1)),j_2_qdot(2,1:(j_2_i-1)), 'DisplayName', 'Joint 2 Velocity', "Color", "green")
plot(j_2_t(1:(j_2_i-1)),j_2_qdot_des(2,1:(j_2_i-1)), 'DisplayName', 'Joint 2 Velocity Des', "Color", "green", 'LineStyle','--')
plot(j_2_t(1:(j_2_i-1)),j_2_qdot(3,1:(j_2_i-1)), 'DisplayName', 'Joint 3 Velocity', "Color", "blue")
plot(j_2_t(1:(j_2_i-1)),j_2_qdot_des(3,1:(j_2_i-1)), 'DisplayName', 'Joint 3 Velocity Des', "Color", "blue", 'LineStyle','--')
plot(j_2_t(1:(j_2_i-1)),j_2_qdot(4,1:(j_2_i-1)), 'DisplayName', 'Joint 4 Velocity', "Color", "black")
plot(j_2_t(1:(j_2_i-1)),j_2_qdot_des(4,1:(j_2_i-1)), 'DisplayName', 'Joint 4 Velocity Des', "Color", "black", 'LineStyle','--')

hold off;
xlabel("Time (s)")
ylabel("Joint Velocity (degree/sec)")
legend
sgtitle("Joint Angle and Velocities vs Time (LSPB w/ 5sec Travel Time)")