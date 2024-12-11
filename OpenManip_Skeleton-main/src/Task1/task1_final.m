clear;
clc;
close all;

%% Setup robot
travelTime = 1.25; % Defines the travel time
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
j2_current = zeros(1, 1000);
t_values =   zeros(1, 1000);
iter = 1;

% w0 =  [0,0,0,0];
% w1 = [-44.7, -8.8, 28.74, -19.88];
% w2 = [42.8, 33.06, 44.3, -77.36];
% w3 = [      0,  -44.7606,   28.1950,   16.5656];
% waypoints = [w0;w1;w3;w2];
[A_angles, success] = robot.IkinSpace501(T_1, guesses(:,1));
disp(A_angles)
robot.writeJoints(A_angles)

pause(2)

[B_angles, success] = robot.IkinSpace501(T_2, guesses(:,2));
disp(B_angles)
robot.writeJoints(B_angles)
tic; % Start timer
% iter = 1;
while toc < travelTime
   
    jvs = robot.getJointsReadings(); % Read joint values
    t_values(iter) = toc+(i-1)*travelTime;
    j2_current(iter) = jvs(3,2);
    iter = iter + 1;
end

pause(2)

robot.writeJoints(A_angles)

pause(2)

travelTime = 0.833;

robot.writeJoints(B_angles)
tic; % Start timer
% iter = 1;
while toc < travelTime
   
    jvs = robot.getJointsReadings(); % Read joint values
    t_values(iter) = toc+(i-1)*travelTime;
    j2_current(iter) = jvs(3,2);
    iter = iter + 1;
end


pause(2)

robot.writeJoints(A_angles)

pause(2)

travelTime = 0.625;

robot.writeJoints(B_angles)
tic; % Start timer
% iter = 1;
while toc < travelTime
   
    jvs = robot.getJointsReadings(); % Read joint values
    t_values(iter) = toc+(i-1)*travelTime;
    j2_current(iter) = jvs(3,2);
    iter = iter + 1;
end

pause(2)

robot.writeJoints(A_angles)

pause(2)

travelTime = 0.5;

robot.writeJoints(B_angles)
tic; % Start timer
% iter = 1;
while toc < travelTime
   
    jvs = robot.getJointsReadings(); % Read joint values
    t_values(iter) = toc+(i-1)*travelTime;
    j2_current(iter) = jvs(3,2);
    iter = iter + 1;
end

saveString = "Task1/Task1Data" + num2str(travelTime) + "sec.mat";
save(saveString, "j_currents", "iter", "t_values")
