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
 methods (Access = public, Static)
     %Length
     
     %Guide Wavelength
     function [w] = getGuideWavelength(frequency, permeability, permittivity)
         beta = (2*pi*frequency)*sqrt(permeability*permittivity);
         w = 2*pi/beta;
     end
     %Propagation Constant
     function [c] = getPropagationConstant(frequency, permeability, permittivity, conductivity)
         %We will have a complex value
         c = 1i*(2*pi*frequency)*sqrt(permeability*permittivity)*sqrt(1-1i*(conductivity/(2*pi*frequency*permittivity)));
     end
     
     %Impedance
     function [lineImpedance] = getImpedance(permeability, permittivity)
         lineImpedance = sqrt(permeability/permittivity);
     end
     
     %For a coaxial cable, the width is equal to the conductor diameter
     function [width] = getWidth(conductorRadius)
         width = conductorRadius*2;
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