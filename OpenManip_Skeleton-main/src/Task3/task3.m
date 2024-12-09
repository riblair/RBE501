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

tf = 2;
tb = 0.3333;

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

% data recording vars
j_angles     = zeros(4, 1000);
j_angles_des = zeros(4, 1000);
j_velos  = zeros(4, 1000);
j_velos_des = zeros(4, 1000);
t_values = zeros(1, 1000);
iter = 1;

[qf, success] = robot.IkinSpace501(Places(:,:,1), guesses(:,1));

robot.writeJoints(qf)
pause(travelTime) % pause to ensure we are truely stopped before starting next movement

robot.writeMode('v')
robot.writeMotorState(true); % Write position mode
% 
% w0 =  [0,0,0,0];
% w1 = [-44.7, -8.8, 28.74, -19.88];
% w2 = [42.8, 33.06, 44.3, -77.36];
% w3 = [      0,  -44.7606,   28.1950,   16.5656];
% waypoints = [w0;w1;w3;w2];
% 
% setPointTravelTime = 0.005;
% robot.writeTime(0.005);
q1_interim_velo = 15;
qdot_inits = [[0;0;0;0], [0;0;0;0], [q1_interim_velo;0;0;0]];
qdot_finals = [[0;0;0;0], [q1_interim_velo;0;0;0], [0;0;0;0]];

for i = 2:size(Places,3) % Iterate through waypoints
    jvs = robot.getJointsReadings();
    q0 = transpose(jvs(1,:));
    [qf, success] = robot.IkinSpace501(Places(:,:,i), guesses(:,i));
    disp(qf)

    path = LSPB(q0,qf,tf,tb, qdot_inits(:, i), qdot_finals(:, i));
     % Start timer
    tic;
    while toc < tf
        [q,qdot] = path.curr_increment(toc);
        jvs = robot.getJointsReadings(); % Read joint values
        robot.writeVelocities(transpose(qdot));
        t_values(iter) = toc+(i-2)*tf;
        j_angles(:,iter) = jvs(1,:);
        j_angles_des(:, iter) = q;
        j_velos(:,iter) = jvs(2,:);
        j_velos_des(:, iter) = qdot;
        iter = iter + 1;
    end
end
robot.writeVelocities(0);
saveString = "Task3/Task3DataStiched" + num2str(tf) + "sec.mat";
save(saveString, "j_angles", "j_velos", "iter", "t_values", "j_angles_des", "j_velos_des")

