%
%http://www.aps.anl.gov/asd/people/nassiri/USPAS2003/Lecture10.pdf
classdef QuadratureHybrid
    methods (Access = public, Static)
        
        function [width] = calculateWidth(characteristicImpedance, substrateThickness, fabricationType)
            switch fabricationType
                case 'Micro'
                    %test parameters
                    lambda_0 = 30;
                    epsilon_r = 2.2;
                    
                    %Give
                    d = 0.158*10^(-2);
                    S = [0 (-1*1i/sqrt(2)) (-1/sqrt(2)) 0; (-1*1i/sqrt(2)) 0 0 (-1/sqrt(2)); (-1/sqrt(2)) 0 0 (-1*1i/sqrt(2)); 0 (-1/sqrt(2)) (-1*1i/sqrt(2)) 0];
                    Z = s2z4(S);

                    %find coupling
                    C = 10*log(1/(1-(Z(0+1,1+1)/characteristicImpedance)^2));
                    lambda = lambda_0/sqrt(epsilon_r);

                    %W for microstrip
                    width = substrateThickness*WDratio_g2(characteristicImpedance,epsilon_r);
                case 'Strip'
                    %TODO
                case 'Coax'
                    %TODO
            end%end switch statement
        end%end getWidth function
        
        function [length] = calculateLength(fabricationType)
            switch fabricationType
                case 'Micro'
                    %TODO
                case 'Strip'
                    %TODO
                case 'Coax'
                    %TODO
            end
        end
        
        function [impedance] = calculateImpedance(fabricationType)
            %TODO
            switch fabricationType
                case 'Micro'
                    %TODO
                case 'Strip'
                    %TODO
                case 'Coax'
                    %TODO
            end
        end
        
        function [propConst] = calculatePropagationConstant(fabricationType)
            switch fabricationType
                case 'Micro'
                    %TODO
                case 'Strip'
                    %TODO
                case 'Coax'
                    %TODO
            end
        end
        
        function [guideWav] = calculateGuideWavelength(fabricationType)
            switch fabricationType
                case 'Micro'
                    %TODO
                case 'Strip'
                    %TODO
                case 'Coax'
                    %TODO
            end
        end
    end
end