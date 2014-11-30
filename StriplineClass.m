classdef StriplineClass
    
    methods (Access = public,Static)
        
        function [width] = getStriplineWidth(relative_permittivity, characteristicImpedance, substrateThickness)
            %substrateThickne'ss from m to cm
            %output width in cm
            substrateThickness = substrateThickness*(10^2);
            x = 30 * pi / (sqrt(er)*characteristicImpedance) - 0.441;
            if sqrt(relative_permittivity) * characteristicImpedance < 120
                  width = substrateThickness*x;
            elseif sqrt(er) *  characteristicImpedance > 120
                  width = substrateThickness * (0.85 - sqrt(0.6 - x));
            end
        end
        
        function [lambda] =  getStriplineGuideWavelength(relative_permittivity, frequency)
            c = 3*10^8;
            % wavelength, cm
            lambda = c / (sqrt(relative_permittivity)* (frequency * 10^9)) * 10^2;
        end
        
        function [DielectricAttenuation] = getDielectricAttenuation(wavenumber, losstangent)
            %Np/m
            DielectricAttenuation = wavenumber * losstangent/2 ;
        end
        
        function [ConductorAttenuation] = getConductorAttenuation(width, relative_permittivity, surface_resistance, substrateThickness, conductorThickness, characteristicImpedance)
            %input width cm, substrate thickness cm, conductor thickness mm
             
            %output Np/m
            A = 1 + (2 * width * 10^(-2) ) / (substrateThickness * 10^(-2) - conductorThickness * 10^(-3)) + (1 / pi) * (substrateThickness * 10^(-2) + t * 10^(-3))/(substrateThickness * 10^(-2)- conductorThickness * 10^(-3)) * log(((2 * substrateThickness * 10^(-2) - conductorThickness * 10^(-3))) / (conductorThickness * 10^(-3)));
            B = 1 + ((substrateThickness * 10^(-2)) / (0.5 * (width * 10^(-2)) + 0.7 * (conductorThickness * 10^(-3)))) * (0.5 + 0.414 * (conductorThickness * 10^(-3)) / (width * 10^(-2)) + (1 / (2 * pi) * log(4 * pi * (width * 10^(-2)) / (conductorThickness * 10^(-3)))));
            if sqrt(relative_permittivity) * characteristicImpedance < 120
                 ConductorAttenuation = (2.7 * 10^(-3) * surface_resistance * er * Z0 * A) / (30 * pi * ((substrateThickness * 10^(-2) - (conductorThickness * 10^(-3)))));
            elseif sqrt(relative_permittivity) * characteristicImpedance > 120
                 ConductorAttenuation= 0.16 * surface_resistance * B / (characteristicImpedance * (substrateThickness * 10^(-2)));
            end 
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
        
end
    

