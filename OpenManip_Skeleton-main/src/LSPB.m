classdef LSPB
    %LSBP Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess = protected)
        tf;
        tb;
        V;
        alpha;
        q0;
        qf;
    end
    
    methods
        % params
        % q0 - 4x1 init joint angle (degrees)
        % qf - 4x1 final joint angle (degrees)
        % tf - 1x1 path time (seconds)
        % tb - blend time as a fraction where 0 < tb < 1/2 
        function self = LSPB(q0,qf,tf,tb)
            self.tb = tf*tb;
            self.V =  (qf - q0) ./ (tf - self.tb); % element-wise calculation of joint velocities 
            self.alpha = self.V ./ self.tb;

            self.tf = tf;
            self.q0 = q0;
            self.qf = qf;
            disp(self.V)
            disp(self.alpha)
        end

        function [q,qdot] = curr_increment(self,t)

            if t <= self.tb
                q = self.q0 + self.alpha / 2*power(t,2);
                qdot = self.alpha * t;
            elseif t <= self.tf - self.tb
                q = (self.qf+self.q0-self.V*self.tf)/2 + self.V*t;
                qdot = self.V;
            else
                q = self.qf - self.alpha/2*power(t,2) - self.alpha/2*power(self.tf,2) + self.alpha*self.tf*t;
                qdot = self.V - (self.alpha * (t-(self.tf-self.tb)));
            end
        end
        
        function calcTrajectory(self,q0,qf,tf,V)
            temp_tb = zeros(4:1);
            temp_alpha = zeros(4:1);
            for i = 1:4
                temp_tb(i) = (q0(i) - qf(i) + V*tf)/V;
                temp_alpha(i) = V/temp_tb(i);
            end
            self.tf = tf;
            self.tb = temp_tb;
            self.V = V;
            self.alpha = temp_alpha;
            self.q0 = q0;
            disp(self.tb)
            disp(self.alpha)
        end
    end
end

