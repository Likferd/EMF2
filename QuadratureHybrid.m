%Reference:
%http://www.aps.anl.gov/asd/people/nassiri/USPAS2003/Lecture10.pdf

classdef QuadratureHybrid
    methods (Access = public, Static)
        % relative_permittivity: F/m
        % characteristicImpedance: Ohms
        % substrateThickness: meters
        % coupling_ratio: dB
        % fabricationType: 'Micro', 'Coax', 'Strip'
        function [width_in, width1, width2] = calculateWidth(coupling_ratio, relative_permittivity, characteristicImpedance, substrateThickness, fabricationType)
            %Give
            S = [0 (-1*1i/sqrt(2)) (-1/sqrt(2)) 0; (-1*1i/sqrt(2)) 0 0 (-1/sqrt(2)); (-1/sqrt(2)) 0 0 (-1*1i/sqrt(2)); 0 (-1/sqrt(2)) (-1*1i/sqrt(2)) 0];
            Z = s2z4(S);
            switch fabricationType
                case 'Micro'
                    %find impedance01 using given coupling ratio
                    %Coupling Ratio:  C = 10*log(1/(1-(Z(0+1,1+1)/characteristicImpedance)^2));
                    impedance01 = characteristicImpedance*sqrt(1-(1/(10^(coupling_ratio/10))));
                    %find impedance02
                    impedance02 = impedance01/sqrt(1-(impedance01/characteristicImpedance)^2);
                    %Three widths associated with quadrature hybrid for microstrip
                    width1 = substrateThickness*WDratio_g2(impedance01, relative_permittivity);
                    width2 = substrateThickness*WDratio_g2(impedance02, relative_permittivity);
                    width_in = substrateThickness*WDratio_g2(characteristicImpedance,relative_permittivity);
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
                    length = 1;
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
        
        % relative_permittivity: F/m
        % frequency: Hz
        function [lambda] = calculateGuideWavelength(relative_permittivity,frequency,fabricationType)
            switch fabricationType
                case 'Micro'
                    lambda_0 = 3*10^8/frequency;
                    lambda = lambda_0/sqrt(relative_permittivity);
                case 'Strip'
                    %TODO
                case 'Coax'
                    %TODO
            end
        end
    end%end methods
end%end class