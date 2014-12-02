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
     function [guidewavelength, beta] = getGuideWavelength(frequency, relative_permeability, relative_permittivity)
         beta = sqrt(relative_permittivity)*2*pi*frequency/(3e8);
         
         %beta = (2*pi*frequency)*sqrt(coaxial.epsilon_0*relative_permeability*coaxial.mu_0*relative_permittivity);
         guidewavelength = 2*pi/beta;
     end
     
     %Get Length
     %function
     
     %Propagation Constant
     function [gamma] = getPropagationConstant(frequency, relative_permeability, relative_permittivity, conductivity,Z0,substrateThickness)
         %We will have a complex value
         f = frequency/1e9;
         d = coaxial.calculateWidth(substrateThickness,relative_permittivity, Z0); %inner diameter
         D = (substrateThickness + (d/2));
         beta = sqrt(relative_permittivity)*2*pi*frequency/(3e8); betaDB = 20*log10(beta);
         alpha_c = (11.39/Z0)*sqrt(f)*((1/d) + (1/D));
         loss_tangent = (2*pi*frequency*imag(relative_permittivity) + conductivity)/(2*pi*frequency*real(relative_permittivity));
         alpha_d = 90.96*sqrt(relative_permittivity)*f*loss_tangent;
         gamma = alpha_c + alpha_d + 1*1j*betaDB;
%          gamma = 10^(gammaDB/20);
     end
     
     %Impedance
     function [lineImpedance] = getImpedance(characteristicImpedance, substrateThickness, relative_permittivity)
        a = coaxial.calculateWidth(substrateThickness,relative_permittivity, characteristicImpedance);
        b = substrateThickness + a;
        lineImpedance = characteristicImpedance*log(b/a)/(sqrt(relative_permittivity)*2*pi);
     end
     
     %Reference microwaves101.com/encyclopedias/coax
     function [width] = calculateWidth(substrateThickness,relative_permittivity, characteristicImpedance)
        width = substrateThickness/(10^(characteristicImpedance*sqrt(relative_permittivity)/138)+(1/2));
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
    
    function [length] = getLength(frequency, relative_permeability, relative_permittivity)
        length = coaxial.getGuideWavelength(frequency, relative_permeability, relative_permittivity)/4;
    end
    
 end
end