% Rat race coupler
classdef RatRaceCoupler
    methods (Access = public, Static)
        % relative_permittivity: F/m
        % characteristicImpedance: Ohms      
        % fabricationType: 'Micro','Strip', 'Coax'
        function [widthZ0, widthsqrt2Z0] = getWidth(relative_permittivity, relative_permeability, characteristicImpedance, substrateThickness, fabricationType)
            
            S = -1i/sqrt(2)*[0 1 1 0; 1 0 0 -1; 1 0 0 1 ; 0 -1 1 0];
            
            [impedance, impedance_ring] = RatRaceCoupler.getImpedance(characteristicImpedance);
            switch fabricationType
                case 'Micro'                    
                    widthZ0 = substrateThickness*WDratio_g2(impedance, relative_permittivity);
                    widthsqrt2Z0 = substrateThickness*WDratio_g2(impedance_ring, relative_permittivity);                    
                case 'Strip'                    
                    widthZ0 = 0.01*StriplineClass.getStriplineWidth(relative_permittivity, impedance, substrateThickness*100);
                    widthsqrt2Z0 = 0.01*StriplineClass.getStriplineWidth(relative_permittivity, impedance_ring, substrateThickness*100);  
                case 'Coax'
                    widthZ0 = coaxial.calculateWidth(substrateThickness, relative_permittivity, impedance);
                    widthsqrt2Z0 = coaxial.calculateWidth(substrateThickness, relative_permittivity, impedance_ring);   
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
        
        function [propConst] = getPropagationConstant(conductivity, relative_permittivity, relative_permeability, frequency, fabricationType, characteristicImpedance, substrateThickness, conductorThickness)
            switch fabricationType
                case 'Micro'
                    [propConst, ~, ~, ~] = microstripclass.getPropConstants(relative_permittivity,2*pi*frequency,relative_permeability,conductivity,WDratio_g2(characteristicImpedance, relative_permittivity),characteristicImpedance, substrateThickness);
                case 'Strip'

                    mu_0 = 1.25663706*10-6;
                    propConst = StriplineClass.getStriplinePropagationConstant(relative_permittivity, frequency/10^9, conductivity, characteristicImpedance, substrateThickness*100, mu_0*relative_permeability, conductorThickness*1000);


                case 'Coax'
                    propConst = coaxial.getPropagationConstant(frequency, relative_permeability, relative_permittivity, conductivity, characteristicImpedance, substrateThickness);
                
            end
        end
        
       
        function [lambda] = getGuideWavelength(relative_permittivity,relative_permeability,frequency,fabricationType)
            switch fabricationType
                case 'Micro'
                    lambda_0 = 3*10^8/frequency;
                    lambda = lambda_0/sqrt(relative_permittivity);
                case 'Strip'
                    lambda = 0.01*StriplineClass.getStriplineGuideWavelength(relative_permittivity, frequency/10^9);
                case 'Coax'
                    lambda = coaxial.getGuideWavelength(frequency, relative_permeability, relative_permittivity);
            end
        end
    end
end