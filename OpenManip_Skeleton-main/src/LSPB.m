classdef LSPB
    %LSBP Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess = protected)
        tf;
        tb;
        V;
        alpha1;
        alpha2;
        q0;
        qf;
        qdot_0;
        qdot_f;
    end
    
    methods
        % params
        % q0 - 4x1 init joint angle (degrees)
        % qf - 4x1 final joint angle (degrees)
        % tf - 1x1 path time (seconds)
        % tb - blend time as a fraction where 0 < tb < 1/2 
        function self = LSPB(q0,qf,tf,tb, qdot_0, qdot_f)
            self.tb = tf * tb;
            self.tf = tf;
            self.q0 = q0;
            self.qf = qf;
            if nargin < 5
                self.qdot_0 = 0;
                self.qdot_f = 0;
            else
                self.qdot_0 = qdot_0;
                self.qdot_f = qdot_f;
            end
            
            self.V =  (qf - q0 - (self.qdot_0 + self.qdot_f) * (self.tb / 2)) / (tf - self.tb); % element-wise calculation of joint velocities 
            self.alpha1 = (self.V - self.qdot_0) / self.tb;
            self.alpha2 = (self.qdot_f - self.V) / self.tb;
        end

        function [q,qdot] = curr_increment(self,t)

            if t <= self.tb
                q = self.q0 + self.alpha1 / 2*power(t,2); % + self.qdot_0 * t ??
                qdot = self.alpha1 * t + self.qdot_0;
            elseif t <= self.tf - self.tb
                q = (self.qf+self.q0-self.V*self.tf)/2 + self.V*t;
                qdot = self.V;
            elseif t <= self.tf
                q = self.qf - self.alpha2/2*power(t,2) - self.alpha2/2*power(self.tf,2) + self.alpha2*self.tf*t; % + something ??
                qdot = self.V + (self.alpha2 * (t-(self.tf-self.tb)));
            else
                error("Invalid Time Enter")
            end
        end
    end
end

