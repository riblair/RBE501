clear;
clc;
close all;

%% Setup robot
travelTime = 0.5; % Defines the travel time
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
j2_current = zeros(4, 1000);
t_values =   zeros(4, 1000);
iters = zeros(4,1);

[A_angles, success] = robot.IkinSpace501(T_1, guesses(:,1));
[B_angles, success] = robot.IkinSpace501(T_2, guesses(:,2));
disp(A_angles)
disp(B_angles)

angs = [A_angles, B_angles];

[t_vals, j2_currs, iter] = drive_motion(robot, angs, travelTime);
t_values(1,: ) = t_vals;
j_currents(1, :) = j2_currs;
iters(1,1) = iter;
pause(2);

[t_vals, j2_currs, iter] = drive_motion(robot, angs, travelTime/.8);
t_values(2,: ) = t_vals;
j_currents(2, :) = j2_currs;
iters(2,1) = iter;
pause(2);

[t_vals, j2_currs, iter] = drive_motion(robot, angs, travelTime/.6);
t_values(3,: ) = t_vals;
j_currents(3, :) = j2_currs;
iters(3,1) = iter;
pause(2);

[t_vals, j2_currs, iter] = drive_motion(robot, angs, travelTime/.4);
t_values(4,: ) = t_vals;
j_currents(4, :) = j2_currs;
iters(4,1) = iter;

saveString = "Task1/Task1Data" + num2str(travelTime) + "sec.mat";
save(saveString, "j_currents", "iters", "t_values", "travelTime")

function [t_vals, j2_currs, iter] = drive_motion(robot, angs, travelTime)
    robot.writeTime(travelTime);
    robot.writeJoints(angs(:,1))
    pause(travelTime*1.5)
    j2_currs = zeros(1, 1000);
    t_vals =   zeros(1, 1000);
    iter = 1;
    
    robot.writeJoints(angs(:,2))
    tic; % Start timer
    while toc < travelTime
        jvs = robot.getJointsReadings(); % Read joint values
        t_vals(iter) = toc;
        j2_currs(iter) = jvs(3,2);
        iter = iter + 1;
    end
end
