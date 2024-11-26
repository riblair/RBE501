%robot = Robot();
theta = atan2(-185,185);
r1 = [cos(theta) -sin(theta) 0;sin(theta) cos(theta) 0;0 0 1];
r2 = [0 0 -1;0 1 0; 1 0 0];
r = r1*r2;
T1 = zeros(4);
T1(1:3,1:3) = r;
T1(1:4,4) = [0.185;-0.185;0.185;1];
eomg = 0.01;
ev = 0.001;

M = [0 0 -1 0.2814;0 1 0 0;1 0 0 0.224326;0 0 0 1];
%M = robot.M
Slist = [[0;0;1;0;0;0],[0;1;0;-0.096326;0;0],[0;1;0;-224326;0;0.024],[0;1;0;-0.224326;0;0.148]];
%Slist = robot.Ss

q = IKinSpace(Slist,M,T1,[theta;0;0;0],eomg,ev)
FKinSpace(M,Slist,q)