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

Places=cat(3,T_1,T_3, T_2);

theta0_1 = [-0.78;0;0;0];
theta0_2 = [0.7432;0;0;0];
theta0_3 = [0;0;0;0];
guesses = [theta0_1, theta0_3, theta0_2];

% currents = [];

% for i = 1:size(Places,3) % Iterate through waypoints
%     [angles, success] = robot.IkinSpace501(Places(:,:,i), guesses(:,i));
%     disp(angles)
%     robot.writeJoints(angles)
%     tic; % Start timer
%     % iter = 1;
%     while toc < travelTime
%        
%         jvs = robot.getJointsReadings(); % Read joint values
%         currents = [currents; jvs(3, :)];
% %         t_values(iter) = toc+(i-1)*travelTime;
% %         j2_current(iter) = jvs(2,2);
% %         iter = iter + 1;
%     end
%     disp(jvs(3, :))
%     pause(2)
% 
% end

home_pos = [0 0 0 0];
A_pos = [-44.7, -8.8, 28.74, -19.88];
B_pos = [42.8, 33.06, 44.3, -77.36];

robot.writeJoints(A_pos);
pause(2)

while true
    jointVals = robot.getJointsReadings();
    calcWrench(robot, jointVals)
end


function F = calcWrench(robot, jointValues)
    currents = jointValues(3, :);
    pos = jointValues(1, :);
    torque = transpose(currents * robot.K);
    jb = JacobianBody(robot.BList, pos);
    F = pinv(transpose(jb))*torque;
    % disp(F)
end


