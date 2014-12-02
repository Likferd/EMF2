% Rat race coupler
classdef RatRaceCoupler
    
    methods (Access = public, Static)
        % relative_permittivity: F/m
        % characteristicImpedance: Ohms      
        % fabricationType: 'Micro','Strip', 'Coax'
        function [widthZ0, widthsqrt2Z0] = getWidth(relative_permittivity, characteristicImpedance, substrateThickness, fabricationType)
            
            S = -1i/sqrt(2)*[0 1 1 0; 1 0 0 -1; 1 0 0 1 ; 0 -1 1 0];
            
            [impedance, impedance_ring] = RatRaceCoupler.getImpedance(characteristicImpedance);
            switch fabricationType
                case 'Micro'                    
                    widthZ0 = substrateThickness*WDratio_g2(impedance, relative_permittivity);
                    widthsqrt2Z0 = substrateThickness*WDratio_g2(impedance_ring, relative_permittivity);                    
                case 'Strip'                    
                    widthZ0 = StriplineClass.getStriplineWidth(relative_permittivity, impedance, substrateThickness);
                    widthsqrt2Z0 = StriplineClass.getStriplineWidth(relative_permittivity, impedance_ring, substrateThickness);  
                case 'Coax'
                    widthZ0 = coaxial.calculateWidth(substrateThickness, relative_permittivity, relative_permeability, impedance);
                    widthsqrt2Z0 = coaxial.calculateWidth(substrateThickness, relative_permittivity, relative_permeability, impedance_ring);   
            end
        end
        
        function [length_lamdafour, length_threelamdafour] = getLength(relative_permittivity, relative_permeability, frequency, fabricationType)
            length_lamdafour = RatRaceCoupler.getGuideWavelength(relative_permittivity,relative_permeability,frequency,fabricationType) / 4;
            length_threelamdafour = RatRaceCoupler.getGuideWavelength(relative_permittivity,relative_permeability,frequency,fabricationType) * 3 / 4;
        end
        
        function [impedance, impedance_ring] = getImpedance(characteristicImpedance)
            impedance = characteristicImpedance;
            impedance_ring = characteristicImpedance*sqrt(2);           
        end
        
        function [propConst] = getPropagationConstant(conductivity, relative_permittivity, relative_permeability, frequency, fabricationType, characteristicImpedance, substrateThickness)
            switch fabricationType
                case 'Micro'
                    [propConst, ~, ~, ~] = microstripclass.getPropConstants(relative_permittivity,2*pi*frequency,relative_permeability,conductivity,WDratio_g2(characteristicImpedance, relative_permittivity),characteristicImpedance, substrateThickness);
                case 'Strip'
                    propConst = StriplineClass.getStriplinePropagationConstant(relative_permittivity, frequency, conductivity, characteristicImpedance, substrateThickness, permeability, conductorThickness);
                case 'Coax'
                    propConst = coaxial.getPropagationConstant(frequency, relative_permeability, relative_permittivity, conductivity);
                
            end
        end
        
       
        function [lambda] = getGuideWavelength(relative_permittivity,relative_permeability,frequency,fabricationType)
            switch fabricationType
                case 'Micro'
                    lambda_0 = 3*10^8/frequency;
                    lambda = lambda_0/sqrt(relative_permittivity);
                case 'Strip'
                    lambda = StriplineClass.getStriplineGuideWavelength(relative_permittivity, frequency);
                case 'Coax'
                    lambda = coaxial.getGuideWavelength(frequency, relative_permeability, relative_permittivity);
            end
        end
    end
end