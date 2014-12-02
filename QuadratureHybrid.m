%Reference:
%http://www.aps.anl.gov/asd/people/nassiri/USPAS2003/Lecture10.pdf

classdef QuadratureHybrid
    properties (Access = private, Constant)
        epsilon_0 = 8.85418782*10-12;
        mu_0 = 1.25663706*10-6;
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
            %Z = s2z4(S);

            [~, impedance01, impedance02] = QuadratureHybrid.calculateImpedance(coupling_ratio, characteristicImpedance);
            switch fabricationType
                case 'Micro'
                    %Three widths associated with quadrature hybrid for microstrip
                    width1 = substrateThickness*WDratio_g2(impedance01, relative_permittivity);
                    width2 = substrateThickness*WDratio_g2(impedance02, relative_permittivity);
                    width_in = substrateThickness*WDratio_g2(characteristicImpedance,relative_permittivity);
                case 'Strip'
                    %Three widths associated with quadrature hybrid for stripline
                    %Multiply by 100 to convert m to cm for substrateThickness
                    width1 = 0.01*StriplineClass.getStriplineWidth(relative_permittivity, impedance01, substrateThickness*100);
                    width2 = 0.01*StriplineClass.getStriplineWidth(relative_permittivity, impedance02, substrateThickness*100);
                    width_in = 0.01*StriplineClass.getStriplineWidth(relative_permittivity, characteristicImpedance, substrateThickness*100);
                case 'Coax'
                    %Three widths associated with quadrature hybrid for coaxial cable
                    width1 = coaxial.calculateWidth(substrateThickness, relative_permittivity, impedance01);
                    width2 = coaxial.calculateWidth(substrateThickness, relative_permittivity, impedance02);           
                    width_in = coaxial.calculateWidth(substrateThickness, relative_permittivity, characteristicImpedance);            
            end%end switch statement
        end%end getWidth function
        
        function [length] = calculateLength(relative_permittivity, relative_permeability, frequency, fabricationType)
            length = QuadratureHybrid.calculateGuideWavelength(relative_permittivity, relative_permeability,frequency,fabricationType)/4;
        end
        
        function [impedance_in, impedance01, impedance02] = calculateImpedance(coupling_ratio, characteristicImpedance)
            impedance_in = characteristicImpedance;
            %find impedance01 using given coupling ratio
            %Coupling Ratio:  C = 10*log(1/(1-(Z(0+1,1+1)/characteristicImpedance)^2));
            impedance01 = characteristicImpedance*sqrt(1-(1/(10^(coupling_ratio/10))));
            %find impedance02
            impedance02 = impedance01/sqrt(1-(impedance01/characteristicImpedance)^2);
        end
        
        function [propConst] = calculatePropagationConstant(conductivity, relative_permittivity, relative_permeability, frequency, fabricationType, characteristicImpedance, substrateThickness, conductorThickness, phase_shift)
            switch fabricationType
                case 'Micro'
                    [propConst, ~, ~, ~] = microstripclass.getPropConstants(relative_permittivity,2*pi*frequency,relative_permeability,conductivity,WDratio_g2(characteristicImpedance, relative_permittivity),characteristicImpedance, substrateThickness);
                case 'Strip'
                    %Input frequency should be in GHz
                    %Input substrateThickness should be in cm
                    %Input conductor thickness should be in cm
                    %Calc surface resistance
                    propConst = StriplineClass.getStriplinePropagationConstant(relative_permittivity, frequency/(10^9), conductivity, characteristicImpedance, substrateThickness*100, QuadratureHybrid.mu_0*relative_permeability, conductorThickness*100);
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
                    %Input frequency should be in GHz
                    %Output will be in cm
                    lambda = 0.01*StriplineClass.getStriplineGuideWavelength(relative_permittivity, frequency/(10^9));
                case 'Coax'
                    lambda = coaxial.getGuideWavelength(frequency, relative_permeability, relative_permittivity);
            end
        end
    end%end methods
end%end class