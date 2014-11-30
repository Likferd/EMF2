function [ result1, result2, result3, result4, result5 ] = calculateGUIOutput( desired_output, transmission_line_type, circuit_type, characteristic_impedance, substrate_thickness, metal_thickness, metal_conductivity, relative_permittivity, relative_permeability, frequency, coupling_ratio, phase_shift )
epsilon_0 = 8.85418782*10-12;
mu_0 = 1.25663706*10-6;

switch desired_output
    case  'Width'
        switch circuit_type
            case 'Wilkinson'
                switch transmission_line_type
                    case 'Stripline'
                        [Z12,Z13,~,~,~] = Wilkinson.getResistance(coupling_ratio,characteristic_impedance,1);
                        [width12,effectivewidth12,width13,effectivewidth13] = Wilkinson.getBranchWidth12(Z12,Z13,substrate_thickness,relative_permittivity,1,1,'Strip');
                        result1 = num2str(width12); result2 = num2str(effectivewidth12); result3 = num2str(width13); result4 = num2str(effectivewidth13);
                    case 'Coaxial'
                        width = coaxial.calculateWidth(substrateThickness,relative_permittivity, relative_permeability, characteristicImpedance);
                        result1 = num2str(width); result2 = ''; result3 = ''; result4 = '';
                    case 'Microstrip'
                        [Z12,Z13,~,~,~] = Wilkinson.getResistance(coupling_ratio,characteristic_impedance,1);
                        [width12,effectivewidth12,width13,effectivewidth13] = Wilkinson.getBranchWidth12(Z12,Z13,substrate_thickness,relative_permittivity,1,1,'Micro');
                        result1 = num2str(width12); result2 = num2str(effectivewidth12); result3 = num2str(width13); result4 = num2str(effectivewidth13);
                end
             case 'Quadrature'
                switch transmission_line_type
                    case 'Stripline'
                        [width_in, width1, width2] = QuadratureHybrid.calculateWidth(coupling_ratio, relative_permittivity, relative_permeability, characteristic_impedance, substrate_thickness, 'Strip');
                    case 'Coaxial'
                        [width_in, width1, width2] = QuadratureHybrid.calculateWidth(coupling_ratio, relative_permittivity, relative_permeability, characteristic_impedance, substrate_thickness, 'Coax');
                    case 'Microstrip'
                        [width_in, width1, width2] = QuadratureHybrid.calculateWidth(coupling_ratio, relative_permittivity, relative_permeability, characteristic_impedance, substrate_thickness, 'Micro');
                end
                result1 = num2str(width_in); result2 = num2str(width1); result3 = num2str(width2); result4 = '';
            case 'Rat-Race'
                %TODO
                result1 = 'TODO'; result2 = ''; result3 = ''; result4 = '';
            otherwise
                switch transmission_line_type
                    case 'Stripline'
                        result1 = num2str(StriplineClass.getStriplineWidth(relative_permittivity, characteristic_impedance, substrate_thickness));
                    case 'Coaxial'
                        result1 = num2str(coaxial.calculateWidth(substrate_thickness,relative_permittivity, relative_permeability, characteristic_impedance));
                    case 'Microstrip'
                        result1 = num2str(substrate_thickness*WDratio_g2(characteristic_impedance, relative_permittivity));
               end
               result2 = ''; result3 = ''; result4 = '';
        end
        result5 = '';
    case 'Length'
        switch circuit_type
            case 'Wilkinson'
                switch transmission_line_type
                    case 'Stripline'
                        lambda = StriplineClass.getStriplineGuideWavelength(relative_permittivity, frequency);
                    case 'Coaxial'
                        lambda = coaxial.getGuideWavelength(frequency, relative_permeability, relative_permittivity);
                    case 'Microstrip'
                        [~,~,~,beta] = microstripclass.getPropConstants(relative_permittivity,2*pi*frequency,mu_0*relative_permeability,metal_conductivity,WDratio_g2(characteristic_impedance,relative_permittivity),characteristic_impedance,substrate_thickness);
                        lambda = microstripclass.getGuideWavelength(beta);
                end
                result1 = num2str(Wilkinson.getLength(lambda)); result2 = ''; result3 = ''; result4 = '';
            case 'Quadrature'
                switch transmission_line_type
                    case 'Stripline'
                        length = QuadratureHybrid.calculateLength(relative_permittivity, relative_permeability, frequency, 'Srip');
                    case 'Coaxial'
                        length = QuadratureHybrid.calculateLength(relative_permittivity, relative_permeability, frequency, 'Coax');
                    case 'Microstrip'
                        length = QuadratureHybrid.calculateLength(relative_permittivity, relative_permeability, frequency, 'Micro');
                end
                result1 = num2str(length); result2 = ''; result3 = ''; result4 = '';
            case 'Rat-Race'
                %TODO
                result1 = 'TODO'; result2 = ''; result3 = ''; result4 = '';
            otherwise
                switch transmission_line_type
                    case 'Stripline'
                        [~, beta] = getStriplinePropagationConstant(relative_permittivity, frequency);
                        result1 = num2str(StriplineClass.getLength(beta,phase_shift));
                        result2 = ''; result3 = ''; result4 = '';
                    case 'Coaxial'
                        %TODO
                        result1 = 'TODO'; result2 = ''; result3 = ''; result4 = '';
                    case 'Microstrip'
                        [beta, ~] = getBeta(relative_permittivity,2*pi*frequency,WDratio);
                        result1 = num2str(microstripclass.getLength(beta,phase_shift));
                        result2 = ''; result3 = ''; result4 = '';
                end
        end
        result5 = '';
    case 'Impedance'
        switch circuit_type
            case 'Wilkinson'
                [Z12,Z13,R,R1, R2] = getResistance(coupling_ratio,characteristic_impedance,1);
                result1 = num2str(Z12); result2 = num2str(Z13); result3 = num2str(R); result4 = num2str(R1); result5 = num2str(R2);
            case 'Quadrature'
                [impedance_in, impedance01, impedance02] = QuadratureHybrid.calculateImpedance(coupling_ratio, characteristic_impedance);
                result1 = num2str(impedance_in); result2 = num2str(impedance01); result3 = num2str(impedance02); result4 = ''; result5 = '';
            case 'Rat-Race'
                %TODO
                result1 = 'TODO'; result2 = ''; result3 = ''; result4 = ''; result5 = '';
            otherwise
                switch transmission_line_type
                    case 'Stripline'
                        %WRONG ANSWER, temporary
                        result1 = num2str(characteristic_impedance);
                    case 'Coaxial'
                        result1 = num2str(coaxial.getImpedance(characteristic_impedance, substrate_thickness, relative_permeability, relative_permittivity));
                    case 'Microstrip'
                        result1 = num2str(microstripclass.getZ0(Wdratio_g2(characteristic_impedance, relative_permittivity),relative_permittivity));%Check
                end
               result2 = ''; result3 = ''; result4 = ''; result5 = '';
        end
    case 'Propagation Constant'
        switch circuit_type
            case 'Quadrature'
                switch transmission_line_type
                    case 'Stripline'
                        propConst = QuadratureHybrid.calculatePropagationConstant(metal_conductivity, relative_permittivity, relative_permeability, frequency, 'Strip', characteristic_impedance, substrate_thickness);
                    case 'Coaxial'
                        propConst = QuadratureHybrid.calculatePropagationConstant(metal_conductivity, relative_permittivity, relative_permeability, frequency, 'Coax', characteristic_impedance, substrate_thickness);
                    case 'Microstrip'
                        propConst = QuadratureHybrid.calculatePropagationConstant(metal_conductivity, relative_permittivity, relative_permeability, frequency, 'Micro', characteristic_impedance, substrate_thickness);
                end
                result1 = num2str(propConst); result2 = ''; result3 = ''; result4 = '';
            case 'Rat-Race'
                %TODO
                result1 = 'TODO'; result2 = ''; result3 = ''; result4 = '';
            %case 'Quarter-Wave'
                %TODO: NEED LOAD IMPEDANCE
                %result1 = num2str(getTheta_m(Gamma_m, characteristic_impedance,ZL,frequency));
            otherwise
                switch transmission_line_type
                    case 'Stripline'
                        result1 = num2str(StriplineClass.getStriplinePropagationConstant(relative_permittivity, frequency));
                    case 'Coaxial'
                        result1 = num2str(coaxial.getPropagationConstant(frequency, relative_permeability, relative_permittivity, metal_conductivity));
                    case 'Microstrip'
                        [gamma,~,~,~] = microstripclass.getPropConstants(relative_permittivity,2*pi*frequency,mu_0*relative_permeability,metal_conductivity,WDratio_g2(characteristic_impedance, relative_permittivity),characteristic_impedance,substrate_thickness);
                        result1 = num2str(gamma);
                end
                result2 = ''; result3 = ''; result4 = '';
        end
        result5 = '';
    case 'Guide Wavelength'
        switch circuit_type
            case 'Quadrature'
                switch transmission_line_type
                    case 'Stripline'
                        guideWavelength = QuadratureHybrid.calculateGuideWavelength(relative_permittivity,relative_permeability,frequency, 'Strip');
                    case 'Coaxial'
                        guideWavelength = QuadratureHybrid.calculateGuideWavelength(relative_permittivity,relative_permeability,frequency, 'Coax');
                    case 'Microstrip'
                        guideWavelength = QuadratureHybrid.calculateGuideWavelength(relative_permittivity,relative_permeability,frequency, 'Micro');
                end
                result1 = num2str(guideWavelength); result2 = ''; result3 = ''; result4 = '';
            case 'Rat-Race'
                %TODO
                result1 = 'TODO'; result2 = ''; result3 = ''; result4 = '';
            otherwise
                switch transmission_line_type
                    case 'Stripline'
                        result1 = num2str(StriplineClass.getStriplineGuideWavelength(relative_permittivity, frequency));
                    case 'Coaxial'
                        result1 = num2str(coaxial.getGuideWavelength(frequency, relative_permeability, relative_permittivity));
                    case 'Microstrip'
                        [~,~,~,beta] = microstripclass.getPropConstants(relative_permittivity,2*pi*frequency,mu_0*relative_permeability,metal_conductivity,WDratio_g2(characteristic_impedance,relative_permittivity),characteristic_impedance,substrate_thickness);
                        result1 = num2str(microstripclass.getGuideWavelength(beta));
                end
                result2 = ''; result3 = ''; result4 = '';
        end
        result5 = '';
end
end

