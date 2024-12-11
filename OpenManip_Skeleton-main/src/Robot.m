% (c) 2023 Robotics Engineering Department, WPI
% Skeleton Robot class for OpenManipulator-X Robot for RBE 3001
classdef Robot < OM_X_arm
    
    % Many properties are abstracted into OM_X_arm and DX_XM430_W350. classes
    % Hopefully, you should only need what's in this class to accomplish everything.
    % But feel free to poke around!
    properties
        mDim; % Stores the robot link dimentions (mm)
        mOtherDim; % Stores extraneous second link dimensions (mm)
        SList;
        M;
        MList;
        GList;
        eomg;
        ev;
        BList;
        K;
    end

    methods
        % Creates constants and connects via serial
        % Super class constructor called implicitly
        % Add startup functionality here
        function self = Robot()
            % gives us access to Modern-Robotics methods
            addpath('../../ModernRobotics-master/packages/MATLAB/mr/');
            % Change robot to position mode with torque enabled by default
            % Feel free to change this as desired
            self.writeMode('cp');
            self.writeMotorState(true);

            % Set the robot to move between positions with a 5 second profile
            % change here or call writeTime in scripts to change
            self.writeTime(2);

            % Robot Dimensions
            self.mDim = [96.326, 130.23, 124, 133.4]; % (mm)
            self.mOtherDim = [128, 24]; % (mm)

            % Space-twist creation
            S1 = [0; 0; 1;          0; 0;         0];
            S2 = [0; 1; 0; -9.6326*10^-2; 0; 0];
            S3 = [0; 1; 0; -2.24326*10^-1; 0; 2.4*10^-2];
            S4 = [0; 1; 0; -2.24326*10^-1; 0; 1.48*10^-1];
            self.SList = [S1,S2,S3,S4];
            self.BList = [[1;0;0;0;0.2814;0],[0;1;0;-0.2814;0;-0.128],[0;1;0;-0.2584;0;0],[0;1;0;-0.1334;0;0]];
            
            % Home configuration
            self.M = [  0, 0, -1,   2.814*10^-1;
                        0, 1,  0,             0;
                        1, 0,  0, 2.24326*10^-1;
                        0, 0,  0,             1];
            
            % Mass-matrix list creation
            M01 = [0.00, 0.00, 1.00, 0.00;
                   0.00, -1.0, 0.00, 2.9*10^-4;
                   1.00, 0.00, 0.00, 6.211*10^-2;
                   0.00, 0.00, 0.00, 1.00];
            
            M02 = [0.00, 0.00, 1.00, 1.8*10^-3;
                   0.00, -1.0, 0.00, -6.4*10^-4;
                   1.00, 0.00, 0.00, 1.8968*10^-1;
                   0.00, 0.00, 0.00, 1.00];

            M03 = [1.00, 0.00, 0.00, 1.0698*10^-1;
                   0.00, 1.00, 0.00, -4.6*10^-4;
                   0.00, 0.00, 1.00, 2.2588*10^-1;
                   0.00, 0.00, 0.00, 1.00];

            M04 = [1.00, 0.00, 0.00, 2.1456*10^-1;
                   0.00, 1.00, 0.00, -1.1*10^-4;
                   0.00, 0.00, 1.00, 2.2803*10^-1;
                   0.00, 0.00, 0.00, 1.00];

            M12 = M01\M02;
            M23 = M02\M03;
            M34 = M03\M04;
            M45 = M04\self.M;
            
            self.MList = cat(3,M01, M12, M23, M34, M45);
            
            % Spatia-inertia-matrix list creation
            m1 = 1.185*10^-1;
            m2 = 1.04*10^-1;
            m3 = 8.3*10^-2;
            m4 = 2.18*10^-1;

            G1 = diag([4.055277*10^-5, 6.540397*10^-5, 6.664446*10^-5, m1,m1,m1]);
            G2 = diag([3.848275*10^-5, 1.9010054*10^-4, 1.9540781*10^-4, m2,m2,m2]);
            G3 = diag([2.255511*10^-5, 1.1750725*10^-4, 1.2792032*10^-4, m3,m3,m3]);
            G4 = diag([1.8019833*10^-4, 2.0227701*10^-4, 2.8711671*10^-4, m4,m4,m4]);
            
            self.GList = cat(3,G1,G2,G3,G4);
            self.eomg = 0.005;
            self.ev = 0.01;

            self.K = 0.0045; %current to torque conversion
        end

        function [angles, success] = IkinSpace501(self, T_des, T_guess)
            % No T_guess given. Must generate a guess based on current position
            if nargin == 2
                q = self.getJointsReadings();
                T_guess = transpose(deg2rad(q(1,:)));
            end
            [angles, success] = IKinSpace(self.SList, self.M, T_des, T_guess, self.eomg, self.ev);
            angles = rad2deg(angles);
        end
        
        % Sends the joints to the desired angles
        % goals [1x4 double] - angles (degrees) for each of the joints to go to
        function writeJoints(self, goals)
            goals = mod(round(goals .* DX_XM430_W350.TICKS_PER_DEG + DX_XM430_W350.TICK_POS_OFFSET), DX_XM430_W350.TICKS_PER_ROT);
            self.bulkReadWrite(DX_XM430_W350.POS_LEN, DX_XM430_W350.GOAL_POSITION, goals);
        end

        % Creates a time based profile (trapezoidal) based on the desired times
        % This will cause writePosition to take the desired number of
        % seconds to reach the setpoint. Set time to 0 to disable this profile (be careful).
        % time [double] - total profile time in s. If 0, the profile will be disabled (be extra careful).
        % acc_time [double] - the total acceleration time (for ramp up and ramp down individually, not combined)
        % acc_time is an optional parameter. It defaults to time/3.
      
        function writeTime(self, time, acc_time)
            if (~exist("acc_time", "var"))
                acc_time = time / 3;
            end

            time_ms = time * DX_XM430_W350.MS_PER_S;
            acc_time_ms = acc_time * DX_XM430_W350.MS_PER_S;

            disp("time")
            disp(time_ms)
            disp("acc time")
            disp(acc_time_ms)

            self.bulkReadWrite(DX_XM430_W350.PROF_ACC_LEN, DX_XM430_W350.PROF_ACC, acc_time_ms);
            self.bulkReadWrite(DX_XM430_W350.PROF_VEL_LEN, DX_XM430_W350.PROF_VEL, time_ms);
        end
        
        % Sets the gripper to be open or closed
        % Feel free to change values for open and closed positions as desired (they are in degrees)
        % open [boolean] - true to set the gripper to open, false to close
        function writeGripper(self, open)
            if open
                self.gripper.writePosition(-35);
            else
                self.gripper.writePosition(55);
            end
        end

        % Sets position holding for the joints on or off
        % enable [boolean] - true to enable torque to hold last set position for all joints, false to disable
        function writeMotorState(self, enable)
            self.bulkReadWrite(DX_XM430_W350.TORQUE_ENABLE_LEN, DX_XM430_W350.TORQUE_ENABLE, enable);
        end

        % Supplies the joints with the desired currents
        % currents [1x4 double] - currents (mA) for each of the joints to be supplied
        function writeCurrents(self, currents)
            currentInTicks = round(currents .* DX_XM430_W350.TICKS_PER_mA);
            self.bulkReadWrite(DX_XM430_W350.CURR_LEN, DX_XM430_W350.GOAL_CURRENT, currentInTicks);
        end

        % Change the operating mode for all joints:
        % https://emanual.robotis.com/docs/en/dxl/x/xm430-w350/#operating-mode11
        % mode [string] - new operating mode for all joints
        % "current": Current Control Mode (writeCurrent)
        % "velocity": Velocity Control Mode (writeVelocity)
        % "position": Position Control Mode (writePosition)
        % Other provided but not relevant/useful modes:
        % "ext position": Extended Position Control Mode
        % "curr position": Current-based Position Control Mode
        % "pwm voltage": PWM Control Mode
        function writeMode(self, mode)
            switch mode
                case {'current', 'c'} 
                    writeMode = DX_XM430_W350.CURR_CNTR_MD;
                case {'velocity', 'v'}
                    writeMode = DX_XM430_W350.VEL_CNTR_MD;
                case {'position', 'p'}
                    writeMode = DX_XM430_W350.POS_CNTR_MD;
                case {'ext position', 'ep'} % Not useful normally
                    writeMode = DX_XM430_W350.EXT_POS_CNTR_MD;
                case {'curr position', 'cp'} % Not useful normally
                    writeMode = DX_XM430_W350.CURR_POS_CNTR_MD;
                case {'pwm voltage', 'pwm'} % Not useful normally
                    writeMode = DX_XM430_W350.PWM_CNTR_MD;
                otherwise
                    error("setOperatingMode input cannot be '%s'. See implementation in DX_XM430_W350. class.", mode)
            end

            lastVelTimes = self.bulkReadWrite(DX_XM430_W350.PROF_VEL_LEN, DX_XM430_W350.PROF_VEL);
            lastAccTimes = self.bulkReadWrite(DX_XM430_W350.PROF_ACC_LEN, DX_XM430_W350.PROF_ACC);

            self.writeMotorState(false);
            self.bulkReadWrite(DX_XM430_W350.OPR_MODE_LEN, DX_XM430_W350.OPR_MODE, writeMode);
            self.writeTime(lastVelTimes(1) / 1000, lastAccTimes(1) / 1000);
            self.writeMotorState(true);
        end

        % Gets the current joint positions, velocities, and currents
        % readings [3x4 double] - The joints' positions, velocities,
        % and efforts (deg, deg/s, mA)
        function readings = getJointsReadings(self)
            readings = zeros(3,4);
            
            readings(1, :) = (self.bulkReadWrite(DX_XM430_W350.POS_LEN, DX_XM430_W350.CURR_POSITION) - DX_XM430_W350.TICK_POS_OFFSET) ./ DX_XM430_W350.TICKS_PER_DEG;
            readings(2, :) = self.bulkReadWrite(DX_XM430_W350.VEL_LEN, DX_XM430_W350.CURR_VELOCITY) ./ DX_XM430_W350.TICKS_PER_ANGVEL;
            readings(3, :) = self.bulkReadWrite(DX_XM430_W350.CURR_LEN, DX_XM430_W350.CURR_CURRENT) ./ DX_XM430_W350.TICKS_PER_mA;
        end

        % Sends the joints at the desired velocites
        % vels [1x4 double] - angular velocites (deg/s) for each of the joints to go at
        function writeVelocities(self, vels)
            vels = round(vels .* DX_XM430_W350.TICKS_PER_ANGVEL);
            self.bulkReadWrite(DX_XM430_W350.VEL_LEN, DX_XM430_W350.GOAL_VELOCITY, vels);
        end

        
    end % end methods
end % end class 
