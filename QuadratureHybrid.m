%Reference:
%http://www.aps.anl.gov/asd/people/nassiri/USPAS2003/Lecture10.pdf

classdef QuadratureHybrid
    methods (Access = private, Static)
        function [width] = getStriplineWidth(relative_permittivity, characteristicImpedance, substrateThickness)
            %substrateThickness from m to cm
            substrateThickness = substrateThickness*(10^2);
            x = 30 * pi / (sqrt(er)*characteristicImpedance) - 0.441;
            if sqrt(relative_permittivity) * characteristicImpedance < 120
                  width = substrateThickness*x;
            elseif sqrt(er) * Z0 > 120
                  width = substrateThickness * (0.85 - sqrt(0.6 - x));
            end
        end
        
        function [length] = getStriplineLength()
        end
        
        function [lambda] =  getStriplineGuideWavelength(relative_permittivity, frequency)
            c = 3*10^8;
            % wavelength, cm
            lambda = c / (sqrt(relative_permittivity)* (frequency * 10^9)) * 10^2;
        end
        
        function [gamma] = getStriplinePropagationConstant(relative_permittivity, frequency)
            % attenuation alpha, Np/m
            alpha = alpha_d + alpha_c;
            
            % attenuation alpha, dB/m
            alpha_dB = 20 * log10(exp(alpha));

            % phase constant, rad/m
            beta = sqrt(relative_permittivity) * (2 * pi * frequency) / c;

            % propagation constant, gamma
            gamma = alpha + 1i * beta;
        end
    end
    
    methods (Access = public, Static)
        % relative_permittivity: F/m
        % characteristicImpedance: Ohms
        % substrateThickness: meters
        % coupling_ratio: dB
        % fabricationType: 'Micro', 'Coax', 'Strip'
        function [width_in, width1, width2] = calculateWidth(coupling_ratio, relative_permittivity, relative_permeability, characteristicImpedance, substrateThickness, fabricationType)
            %Given
            S = [0 (-1*1i/sqrt(2)) (-1/sqrt(2)) 0; (-1*1i/sqrt(2)) 0 0 (-1/sqrt(2)); (-1/sqrt(2)) 0 0 (-1*1i/sqrt(2)); 0 (-1/sqrt(2)) (-1*1i/sqrt(2)) 0];
            Z = s2z4(S);

            [~, impedance01, impedance02] = calculateImpedance(coupling_ratio, characteristicImpedance);
            switch fabricationType
                case 'Micro'
                    %Three widths associated with quadrature hybrid for microstrip
                    width1 = substrateThickness*WDratio_g2(impedance01, relative_permittivity);
                    width2 = substrateThickness*WDratio_g2(impedance02, relative_permittivity);
                    width_in = substrateThickness*WDratio_g2(characteristicImpedance,relative_permittivity);
                case 'Strip'
                    %Three widths associated with quadrature hybrid for stripline
                    width1 = getStriplineWidth(relative_permittivity, impedance01, substrateThickness);
                    width2 = getStriplineWidth(relative_permittivity, impedance02, substrateThickness);
                    width_in = getStriplineWidth(relative_permittivity, characteristicImpedance, substrateThickness);
                case 'Coax'
                    %Three widths associated with quadrature hybrid for coaxial cable
                    width1 = coaxial.calculateWidth(substrateThickness, relative_permittivity, relative_permeability, impedance01);
                    width2 = coaxial.calculateWidth(substrateThickness, relative_permittivity, relative_permeability, impedance02);           
                    width_in = coaxial.calculateWidth(substrateThickness, relative_permittivity, relative_permeability, characteristicImpedance);            
            end%end switch statement
        end%end getWidth function
        
        function [length] = calculateLength(relative_permittivity, frequency, fabricationType)
            length = calculateGuideWavelength(relative_permittivity,frequency,fabricationType)/4;
        end
        
        function [impedance_in, impedance01, impedance02] = calculateImpedance(coupling_ratio, characteristicImpedance)
            impedance_in = characteristicImpedance;
            %find impedance01 using given coupling ratio
            %Coupling Ratio:  C = 10*log(1/(1-(Z(0+1,1+1)/characteristicImpedance)^2));
            impedance01 = characteristicImpedance*sqrt(1-(1/(10^(coupling_ratio/10))));
            %find impedance02
            impedance02 = impedance01/sqrt(1-(impedance01/characteristicImpedance)^2);
        end
        
        function [propConst] = calculatePropagationConstant(conductivity, relative_permittivity, relative_permeability, frequency, fabricationType)
            switch fabricationType
                case 'Micro'
                    propConst = microstripclass.getPropConstants(relative_permittivity,2*pi*frequency,relative_permeability,conductivity,WDratio,Z0);
                case 'Strip'
                    propConst = getStriplinePropagationConstant(relative_permittivity, frequency);
                case 'Coax'
                    propConst = coaxial.getPropagationConstant(frequency, relative_permeability, relative_permittivity, conductivity);
            end
        end
        
        % relative_permittivity: F/m
        % frequency: Hz
        function [lambda] = calculateGuideWavelength(relative_permittivity,relative_permeability,frequency,fabricationType)
            switch fabricationType
                case 'Micro'
                    lambda_0 = 3*10^8/frequency;
                    lambda = lambda_0/sqrt(relative_permittivity);
                case 'Strip'
                    lambda = getStriplineGuideWavelength(relative_permittivity, frequency);
                case 'Coax'
                    lambda = coaxial.getGuideWavelength(frequency, relative_permeability, relative_permittivity);
            end
        end
    end%end methods
end%end class