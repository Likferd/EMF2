%Reference:
%Electromagnetic Waves by Inan Inan p368

%Given values:
%   Characteristic impedance, default to 50 ohms
%   Substrate Thickness
%   Metal thickness
%   Metal Conductivity
%   Frequency
%   Coupling Ratio% in dB

%Outputs:
%   Width
%   Length
%   Impedance
%   Propagation Constant
%   Guide wavelength
classdef coaxial
properties (Access = private, Constant)
    epsilon_0 = 8.85418782*10-12;
    mu_0 = 1.25663706*10-6;
end
 methods (Access = public, Static)
     %Length
     
     %Guide Wavelength
     function [w, beta] = getGuideWavelength(frequency, relative_permeability, relative_permittivity)
         beta = (2*pi*frequency)*sqrt(coaxial.epsilon_0*relative_permeability*coaxial.mu_0*relative_permittivity);
         w = 2*pi/beta;
     end
     
     %Get Length
     %function
     
     %Propagation Constant
     function [c] = getPropagationConstant(frequency, relative_permeability, relative_permittivity, conductivity)
         %We will have a complex value
         c = 1i*(2*pi*frequency)*sqrt(coaxial.epsilon_0*relative_permeability*coaxial.mu_0*relative_permittivity)*sqrt(1-1i*(conductivity/(2*pi*frequency*relative_permittivity)));
     end
     
     %Impedance
     function [lineImpedance] = getImpedance(characteristicImpedance, substrateThickness, relative_permeability, relative_permittivity)
        a = coaxial.calculateWidth(substrateThickness,relative_permittivity, relative_permeability, characteristicImpedance);
        b = substrateThickness - a;
        lineImpedance = characteristicImpedance*log(b/a)/(sqrt(relative_permittivity)*2*pi);
     end
     
     %For a coaxial cable, the width is equal to the conductor diameter
     %conductor radius = metal thickness, meters
     function [width] = calculateWidth(substrateThickness,relative_permittivity, relative_permeability, characteristicImpedance)
         %TODO, relate to impedance
         eta = sqrt((coaxial.mu_0*relative_permeability)/(coaxial.epsilon_0*relative_permittivity));
         width = 2*substrateThickness/(exp(2*pi*characteristicImpedance/eta)+1);
     end
     
        
    %Calculate the Electric Field
    function [field, direction] = calculateE(conductorRadius, dielectricThickness, conductorPotential)
        %Solution to the scalar potential funciton at the conductorRadius
        %and at the dielectricThickness
        syms r
        field = -1*diff(coaxial.spot(conductorPotential, conductorRadius, conductorRadius+dielectricThickness, r));
        direction = 'r';
    end
    
    %Calculate the Magnetic Field
    function [field, direction] = calculateH(permeability, permittivity, conductorRadius, dielectricThickness, conductorPotential)
       Ztem = coaxial.getImpedance(permeability, permittivity);
       %find the cross product of z^ with the E which is in the r^
       %direction
       syms r
       e = coaxial.calculateE(conductorRadius, dielectricThickness, conductorPotential);
       field = double((1/Ztem)*e.*r);
       direction = 'theta';
    end
    
    %Scalar potential function for a TEM coaxial line
    function [s] = spot(V0, a, b, r)
        s = V0*log(b./r)./log(b./a);
    end
    
 end
end