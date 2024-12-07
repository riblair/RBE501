classdef LSBP
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
        function self = LSBP(q0,qf,tf,V)
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
            self.qf = qf;
            disp(self.tb)
            disp(self.alpha)
        end

        function [q,qdot] = curr_increment(self,t)
            q = zeros(4,1);
            qdot = zeros(4,1);
            for i = 1:4
                if t<=self.tb(i)
                    q(i) = self.q0(i) + self.alpha(i)/2*power(t,2);
                    qdot(i) = self.alpha(i)*t;
                
                elseif t <= self.tf - self.tb(i)
                    q(i) = (self.qf(i)+self.q0(i)-self.V*self.tf)/2 + self.V*t;
                    qdot(i) = self.V;
                else
                    q(i) = self.qf(i) - self.alpha(i)/2*power(t,2) - self.alpha(i)/2*power(self.tf,2) + self.alpha(i)*self.tf*t;
                    qdot(i) = self.V-self.alpha(i)*(t-(self.tf-self.tb(i)));
                end
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

