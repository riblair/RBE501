clear;
clc;
close all;

%% Setup robot
travelTime = 2; % Defines the travel time
robot = Robot(); % Creates robot object
robot.writeTime(travelTime); % Write travel time
robot.writeMotorState(true); % Write position mode
%% Program 

robot.writeJoints(0); % Write joints to zero position
pause(travelTime); % Wait for trajectory completion


T_1 = [0, .71, -.71,  1.85*10^-1;
       0, .71,  .71, -1.85*10^-1;
       1,   0,    0,  1.85*10^-1;
       0,   0,    0,           1];

T_2 = [0, -.6766, -.73,  1.85*10^-1;
       0, .73,  -.6766,  1.70*10^-1;
       1,   0,    0,   7.0*10^-2;
       0,   0,    0,           1];

T_3 = [0, 0, -1,  1.85*10^-1;
       0, 1, 0,  0;
       1, 0, 0,  2.4*10^-1;
       0, 0, 0,           1];

Places=cat(2,T_1, T_2);

theta0_1 = [-0.78;0;0;0];
theta0_2 = [0.7432;0;0;0];
theta0_3 = [0;0;0;0];
guesses = [theta0_1, theta0_3, theta0_2];
j_torques_guess = zeros(4, 1000);
j_torques_inv = zeros(4,1000);
t_values =   zeros(1, 1000);
iter = 1;

% w0 =  [0,0,0,0];
% w1 = [-44.7, -8.8, 28.74, -19.88];
% w2 = [42.8, 33.06, 44.3, -77.36];
% w3 = [      0,  -44.7606,   28.1950,   16.5656];
% waypoints = [w0;w1;w3;w2];
robot.writeJoints([-44.7, -8.8, 28.74, -19.88]);
pause(travelTime);

[angles, success] = robot.IkinSpace501(T_2, theta0_2);
disp(angles)
robot.writeJoints(angles)

tic; % Start timer
% iter = 1;
jvs = robot.getJointsReadings();
prev_j_vels = transpose(jvs(2,:));
prev_toc = zeros(4,1);
while toc < travelTime
   
    jvs = robot.getJointsReadings(); % Read joint values
    t_values(iter) = toc;
    j_angles = transpose(jvs(1,:));
    j_vels = transpose(jvs(2,:));
    j_accs = (j_vels-prev_j_vels)./(toc-prev_toc);
    j1 = [j_angles(1),j_vels(1),j_accs(1)];
    disp(j1)
    j_current = transpose(jvs(3,:));
    j_torques_guess(:,iter) = j_current.*0.0045;
    j_torques_inv(:,iter) = InverseDynamics(deg2rad(j_angles),deg2rad(j_vels),deg2rad(j_accs),[0;0;-9.8],[0;0;0;0;0;0],robot.MList, robot.GList, robot.SList);
    iter = iter + 1;

    prev_j_vels = j_vels;
end

save("Task1/Task_1_Torques", "j_torques_guess", "j_torques_inv" ,"iter", "t_values")
