%% Robot Setup
travelTime = 2; % Defines the travel time
robot = Robot(); % Creates robot object
robot.writeTime(travelTime); % Write travel time
robot.writeMotorState(true); % Write position mode
addpath("~/RBE501/ModernRobotics-master/packages/MATLAB/mr");

%% Task Calcs
A = [0.185; -0.185; 0.185];
B = [0.185; 0.170; 0.070];

R_A = [0 0.71 -0.71; 
    0 0.71 0.71; 
    1 0 0];

R_B = [0 0.71 -0.71; 
    0 -0.71 -0.71; 
    1 0 0];

T_A = [R_B A; 0 0 0 1]

T_B = [R_B B; 0 0 0 1]

eomg = 0.001;
ev = 0.005;


thetalist0_A = [-0.785; 0; 0; 0];
[thetalist_A, success] = IKinBody(robot.Bs, robot.M, T_A, thetalist0_A, eomg, ev)

TA_result = FKinBody(robot.M, robot.Bs, thetalist_A)

thetalist0_B = [0.785; 0; 0; 0];
[thetalist_B, success] = IKinBody(robot.Bs, robot.M, T_B, thetalist0_B, eomg, ev)
TB_result = FKinBody(robot.M, robot.Bs, thetalist_B)

listPos = [[0, 0, 0, 0]; rad2deg(transpose(thetalist_A)); rad2deg(transpose(thetalist_B))];

robot.writeJoints(0);
pause(3);

robot.writeJoints(listPos(2, :));
pause(3)

robot.writeJoints(listPos(3, :));
pause(3)