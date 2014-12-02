classdef StriplineClass
    
    methods (Access = public,Static)
        
        function [width] = getStriplineWidth(relative_permittivity, characteristicImpedance, substrateThickness)
            %substrateThickness in cm, impedance in Ohms
            %output width in cm
            x = 30 * pi / (sqrt(relative_permittivity)*characteristicImpedance) - 0.441;
            if sqrt(relative_permittivity) * characteristicImpedance < 120
                  width = substrateThickness*x;
            elseif sqrt(relative_permittivity) *  characteristicImpedance > 120
                  width = substrateThickness * (0.85 - sqrt(0.6 - x));
            end
        end
        
        function [wavenumber] = getWavenumber(frequency,relative_permittivity) 
            %frequency GHz
            c = 3 * 10 ^ 8;
            wavenumber = 2 * pi * (frequency * 10^9) * sqrt(relative_permittivity) / c;
        end    
        
        function [LossTangent] = getLossTangent(frequency, relative_permittivity, conductivity)
            %frequency in GHz
            LossTangent = conductivity / (frequency*1e9 * relative_permittivity);
        end    
        
        function [lambda] =  getStriplineGuideWavelength(relative_permittivity, frequency)
            %frequency in GHz
            c = 3*10^8;
            % wavelength, cm
            lambda = c / (sqrt(relative_permittivity) * (frequency * 10^9)) * 10^2;
        end
        
        function [DielectricAttenuation] = getDielectricAttenuation(frequency, relative_permittivity, conductivity)
            %Np/m
            DielectricAttenuation = StriplineClass.getWavenumber(frequency,relative_permittivity) * StriplineClass.getLossTangent(frequency, relative_permittivity, conductivity)/2 ;
        end
        
        function [ConductorAttenuation] = getConductorAttenuation(relative_permittivity, surface_resistance, substrateThickness, conductorThickness, characteristicImpedance)
            %input width cm, substrate thickness cm, conductor thickness mm
            %output Np/m
            t = conductorThickness*10^(-3);
            b = substrateThickness*10^(-2);
            
            
            width = StriplineClass.getStriplineWidth(relative_permittivity, characteristicImpedance, substrateThickness);
            W = width*10^(-2);
            
            A = 1 + ((2 * W) / (b - t)) + (1 / pi) * ((b + t)/(b-t)) * log((2 * b - t) / t);
            B = 1 + (b / (0.5 * W + 0.7 * t)) * (0.5 + (0.414 * t / W) + ((1 / (2 * pi)) * log(4 * pi * W / t)));
            if sqrt(relative_permittivity) * characteristicImpedance < 120
                 ConductorAttenuation = (2.7 * 10^(-3) * surface_resistance * relative_permittivity * characteristicImpedance * A) / (30 * pi * (b - t));
            elseif sqrt(relative_permittivity) * characteristicImpedance > 120
                 ConductorAttenuation = 0.16 * surface_resistance * B / (characteristicImpedance * b);
            end 
        end
        
        %Reference microwaves101.com/encyclopedias/transmission-line-loss
       % function [surface_resistance] = getSurfaceResistance(conductivity, Beta, phi, conductorThickness,relative_permittivity, characteristicImpedance, substrateThickness)
            %frequency in GHz
            %permeability is mu_0*relative_permeability
        %    surface_resistance = StriplineClass.getLength(Beta,phi)/ (conductivity *  conductorThickness * StriplineClass.getStriplineWidth(relative_permittivity, characteristicImpedance, substrateThickness) );

        %end
        
        function [surface_resistance] = getSurfaceResistance(conductivity, frequency, permeability)
            %frequency in GHz
            %permeability is mu_0*relative_permeability
            surface_resistance = sqrt(pi*frequency*permeability/conductivity);
        end

        function [gamma, beta,surface_resistance] = getStriplinePropagationConstant(relative_permittivity, frequency, conductivity, characteristicImpedance, substrateThickness, permeability, conductorThickness)
            %input width cm, substrate thickness cm, conductor thickness mm
            %permeability is mu_0*relative_permeability
            
            % phase constant, rad/m
            beta = (sqrt(relative_permittivity) * (2 * pi * (frequency*1e9))) / (3e8);            
            surface_resistance = sqrt((2*pi*frequency*1e9*permeability)/(2*conductivity));
            % attenuation alpha, Np/m
            alpha = StriplineClass.getDielectricAttenuation(frequency, relative_permittivity, conductivity) + StriplineClass.getConductorAttenuation(relative_permittivity, surface_resistance, substrateThickness, conductorThickness, characteristicImpedance);
            
            % attenuation alpha, dB/m
            alpha_dB = 20 * log10(exp(alpha));



            % propagation constant, gamma
            gamma = alpha + 1i * beta;
        end
        
       function[l] = getLength(Beta,phi)
            % phi is desired phase shift, in degrees
            %Beta is the complex part of the propagation constant gamma
            l = phi*(pi/180)/Beta; 
        end
    end
        
end
    

