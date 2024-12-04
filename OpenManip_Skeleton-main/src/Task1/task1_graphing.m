clc;
clear;
close all;

load maxSpeed.mat
load max_iter.mat
load maxt.mat
j2_100_c = j2_current;
j2_100_t = t_values;
j2_100_i = iter;

load 80Speed.mat 
load 80_iter.mat
load 80t.mat
j2_80_c = j2_current;
j2_80_t = t_values;
j2_80_i = iter;

load 60Speed.mat 
load 60_iter.mat
load 60t.mat
j2_60_c = j2_current;
j2_60_t = t_values;
j2_60_i = iter;

load 40Speed.mat 
load 40_iter.mat
load 40t.mat
j2_40_c = j2_current;
j2_40_t = t_values;
j2_40_i = iter;

figure;
hold on;
grid on;
plot(j2_100_t(1:(j2_100_i-1)),j2_100_c(1:(j2_100_i-1)), 'DisplayName', '100% (0.5 Travel Time)')
plot(j2_80_t(1:(j2_80_i-1)),j2_80_c(1:(j2_80_i-1)), 'DisplayName', '80% (0.625 Travel Time)')
plot(j2_60_t(1:(j2_60_i-1)),j2_60_c(1:(j2_60_i-1)), 'DisplayName', '60% (0.833 Travel Time)')
plot(j2_40_t(1:(j2_40_i-1)),j2_40_c(1:(j2_40_i-1)), 'DisplayName', '40% (1.25 Travel Time)')

title("Current vs Time of Joint 2")
xlabel("Time (s)")
ylabel("CUrrent (mA)")
legend