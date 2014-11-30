classdef microstripclass
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes her
    methods (Access = public, Static)
    
        function [Wdratio] = getWDratio(Z0,er,GreaterThanTwo)
        %enter Boolean for "Greater than Two" 
        % 1 if W/D should be greater than 2, 0 if it should be less than 2
            if GreaterThanTwo == 1
                B = (377*pi)/(2*Z0*sqrt(er));
                Wdratio = (2/pi)*(B - 1 - log(2*B -1) + ((er-1)/(2*er))*(log(B-1)+.39-(.61/er)));
            else
                A = Z0/60 * sqrt((er+1)/2) + ((er-1)/(er+1))*(.23+(.11/er));
                Wdratio = 8*exp(A) / (exp(2*A)-2);
            end
        end
        
        function [Z0] = getZ0(Wdratio,er)
             ee = (er+1)/2 + ((er-1)/2)*(1/sqrt(1+(12/Wdratio)));
             if Wdratio > 1
                Z0 = (120*pi) / (sqrt(ee)*(Wdratio + 1.393 + .667*log(Wdratio + 1.444)));
             else
                Z0 = (60/log(ee))*log((8/Wdratio)+(Wdratio/4));
             end
        end
        
        function[lambda_g] = getGuideWavelength(Beta)
            lambda_g = 2*pi/Beta;
        end
        
        function[gamma,alpha_d,alpha_c,Beta] = getPropConstants(er,w,u,sigma,WDratio,Z0,substratethickness)
            %w is the operational frequency, in rad/s
            %u is permeability
            u = u*pi*4e-7;
            W = WDratio*substratethickness;
            c = 3e8;
            ee = (er+1)/2 + ((er-1)/2)*(1/sqrt(1+(12/WDratio)));
            loss_tangent = (w*imag(er) + sigma)/(w*real(er));
            k0 = w/c;
            alpha_d = (k0*er*(ee-1)*loss_tangent)/(2*sqrt(ee)*(er-1)); alpha_dDB = alpha_d*8.686;
            Rs = sqrt((w*u/(2*sigma)));
            alpha_c = Rs/(Z0*W); alpha_cDB = alpha_c*8.686;
            Beta = sqrt(ee)*k0; BetadB = 20*log10(Beta);
            gammaDB = alpha_cDB + alpha_dDB + 1i*BetadB;
            gamma = 10^(gammaDB/20); %gamma not in dB
        end
        
        function[Beta,BetadB] = getBeta(er,w,WDratio)
            %w is the operational frequency, in rad/s
            %u is relative permeability
            
            c = 3e8;
            ee = (er+1)/2 + ((er-1)/2)*(1/sqrt(1+(12/WDratio)));
            k0 = w/c;
            Beta = sqrt(ee)*k0; BetadB = 20*log10(Beta);
            
        end
        
        function[l,guidewavelength] = getLength(Beta,phi)
            % phi is desired phase shift, in degrees
            %Beta is the complex part of the propagation constant gamma
            l = phi*(pi/180)/Beta; 
            guidewavelength = 2*pi/Beta;
        end
        
        function [phi,w0] = getFrequency(Beta,er,WDratio,l)
            %l is electrical length
            %phi is phase shift across line
            c = 3e8;
            ee = (er+1)/2 + ((er-1)/2)*(1/sqrt(1+(12/WDratio)));
            phi = l*Beta*180/pi;
            w0 = c*Beta/sqrt(ee);
        end
    end
end

