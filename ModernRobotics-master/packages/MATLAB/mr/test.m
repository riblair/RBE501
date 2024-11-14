% Work for test...

clc; clear; close all;
% H is from base frame to EE
% -w X p -> use cross()
% torque = tranpose(J) * F
% Manipulability Mat -> A = J * Transpose(J)

% URDF Rotations are applied sequentially, that means a rpy in j1 will affect joint 2 -> n

% JacobianSpace(Jacobian at home configuration, Joint Angles) -> 6xn Matrix
% FKinSpace(Home Config, Space Twists, Joint Angles) -> Transpose of EE
% IKinSpace(Space Twists, Home config, Transpose Matrix, init guess, error omega, error linear velocity) -> Joint Angles


home_x = 0.175 + 1.2305 + 0.085;
home_z = 0.495 + 1.095 + 0.175;

M = [0, 0, 1, home_x; 0, 1, 0, 0; -1, 0, 0, home_z; 0, 0, 0, 1];

S1 = [0; 0; 1; 0; 0; 0];

S2o = [0; 1; 0;];
S2p = [0.175; 0; 0.495];
S2 = [S2o; cross(-S2o, S2p)];

S3o = [0; 1; 0;];
S3p = [0.175; 0;  0.495 + 1.095];
S3 = [S3o; cross(-S3o, S3p)];

S4o = [1; 0; 0;];
S4p = [0.175; 0;  home_z];
S4 = [S4o; cross(-S4o, S4p)];

S5o = [0; 1; 0;];
S5p = [0.175+1.2305; 0;  home_z];
S5 = [S5o; cross(-S5o, S5p)];

S6o = [1; 0; 0;];
S6p = [home_x; 0;  home_z];
S6 = [S6o; cross(-S6o, S6p)];

B1 = [0;0;1; cross(-[0;0;1], [0; 0; 0])];
B2 = [0;1;0; cross(-[0;1;0], [0; 0; -0.085])];
B3 = [0;0;1; cross(-[0;0;1], [0; 0; -0.085-1.2305])];
B4 = [0;1;0; cross(-[0;1;0], [0.175; 0;-0.085-1.2305])];
B5 = [0;1;0; cross(-[0;1;0], [0.175+1.095; 0;-0.085-1.2305])];
B6 = [-1;0;0; cross(-[-1;0;0],[0.175+1.095; 0;-0.085-1.2305-0.175])];

BList = [B1, B2, B3, B4, B5, B6]

T_astro = [0, 1, 0, -0.97; 0.2, 0, 1, 0.69; 1, 0, 0.2, 2.3; 0, 0, 0, 1];

SList = [S1, S2, S3, S4, S5, S6];


 % Q1
theta_0_s = [deg2rad(135);deg2rad(20);0;0;deg2rad(10);0];
eomg = 0.01;
ev = 0.001;

j_theta_0 = JacobianSpace(SList, theta_0_s);

j_theta_0 = JacobianBody(BList, theta_0_s);

[s_1, success] = IKinSpace(SList, M, T_astro, theta_0_s, eomg, ev)
[b_1, success] = IKinBody(BList, M, T_astro, theta_0_s, eomg, ev)
qs = real(s_1);
V = [0; 0; 0; -0.2; -0.38; 0];
inv_J_qs = inv(JacobianSpace(SList,qs));
% inv_J_qs = inv(JacobianBody(BList,qs));
inv_J_qs * V

% Q3
J_home = JacobianSpace(SList,zeros(6,1));

Force = [0; 0; 0; 0; 50; -100];

torque = transpose(SList) * Force;

