%% Setup robot
travelTime = 2; % Defines the travel time
robot = Robot(); % Creates robot object
robot.writeTime(travelTime); % Write travel time
robot.writeMotorState(true); % Write position mode
addpath("~/RBE501/ModernRobotics-master/packages/MATLAB/mr");

%% Program 

robot.writeJoints(0); % Write joints to zero position
pause(travelTime); % Wait for trajectory completion

baseWayPoints = [-45, 45, 0]; % Define base waypoints

for baseWayPoint = baseWayPoints % Iterate through waypoints

    robot.writeJoints([baseWayPoint, 0, 0, 0]); % Write joint values

    tic; % Start timer

    while toc < travelTime
        disp(robot.getJointsReadings()); % Read joint values
    end

end

robot.writeGripper(false);

pause(1);