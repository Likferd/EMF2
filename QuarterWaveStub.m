classdef QuarterWaveStub
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
    methods (Access = public,Static)
        
        function [Z1] = getZ1(Z0,ZL)
            Z1 = sqrt(Z0*ZL);
        end
        
        function [Zin] = getZin(Beta,l,Z1,ZL)
            Zin = Z1*((ZL + 1*1j*Z1*tan(Beta*l))/(Z1 + 1*1j*ZL*tan(Beta*l)));
        end
        
        function [BL] = getBetaL(f0,guidewavelength)
            lambda0 = 3e8/f0;
            BL = (2*pi/guidewavelength)*(lambda0/4);
        end
        
        function [Gamma] = getGamma(Zin,Z0)
            Gamma = (Zin - Z0)/(Zin + Z0);
        end
        
        function [SWR] = getSWR(Gamma)
            SWR = (1+abs(Gamma))/(1 - abs(Gamma));
        end
        
        function [Theta_m,fm,BW] = getTheta_m(Gamma_m, Z0,ZL,f0)
            %Gamma_m is the maximum Gamma value
            cosThetam = (Gamma_m/sqrt(1-Gamma_m^2)) * 2*sqrt(Z0*ZL)/abs(ZL-Z0);
            Theta_m = acosd(cosThetam); %gives theta m in degrees
            
            fm = 2*Theta_m*f0/pi;
            BW = 2*(f0-fm)/f0;  
        end
        
        
    end
    
end

