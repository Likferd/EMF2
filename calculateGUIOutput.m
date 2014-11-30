function [ result1, result2, result3, result4 ] = calculateGUIOutput( desired_output, transmission_line_type, circuit_type, characteristic_impedance, substrate_thickness, metal_thickness, metal_conductivity, relative_permittivity, relative_permeability, frequency, coupling_ratio )
switch desired_output
    case  'Width'
        switch circuit_type
            case 'Wilkinson'
            case 'Quadrature'
                switch transmission_line_type
                    case 'Stripline'
                        [width_in, width1, width2] = QuadratureHybrid.calculateWidth(coupling_ratio, relative_permittivity, relative_permeability, characteristic_impedance, substrate_thickness, 'Strip');
                    case 'Coaxial'
                        [width_in, width1, width2] = QuadratureHybrid.calculateWidth(coupling_ratio, relative_permittivity, relative_permeability, characteristic_impedance, substrate_thickness, 'Coax');
                    case 'Microstrip'
                        [width_in, width1, width2] = QuadratureHyrid.calculateWidth(coupling_ratio, relative_permittivity, relative_permeability, characteristic_impedance, substrate_thickness, 'Micro');
                end
                result1 = num2str(width_in); result2 = num2str(width1); result3 = num2str(width2); result4 = '';
            case 'Rat-Race'
            case 'Quarter-Wave'
            case 'General'
                switch transmission_line_type
                    case 'Stripline'
                    case 'Coaxial'
                        result1 = num2str(coaxial.calculateWidth(substrate_thickness,relative_permittivity, relative_permeability, characteristic_impedance));
                        result2 = ''; result3 = ''; result4 = '';
                    case 'Microstrip'
                end
        end
    case 'Length'
        switch circuit_type
            case 'Wilkinson'
            case 'Quadrature'
                switch transmission_line_type
                    case 'Stripline'
                        length = QuadratureHybrid.calculateLength(relative_permittivity, frequency, 'Srip');
                    case 'Coaxial'
                        length = QuadratureHybrid.calculateLength(relative_permittivity, frequency, 'Coax');
                    case 'Microstrip'
                        length = QuadratureHybrid.calculateLength(relative_permittivity, frequency, 'Micro');
                end
                result1 = num2str(length); result2 = ''; result3 = ''; result4 = '';
            case 'Rat-Race'
            case 'Quarter-Wave'
            case 'General'
                switch transmission_line_type
                    case 'Stripline'
                    case 'Coaxial'
                    case 'Microstrip'
                end
        end
    case 'Impedance'
        switch circuit_type
            case 'Wilkinson'
            case 'Quadrature'
                [impedance_in, impedance01, impedance02] = QuadratureHybrid.calculateImpedance(coupling_ratio, characteristic_impedance);
                result1 = num2str(impedance_in); result2 = num2str(impedance01); result3 = num2str(impedance02); result4 = '';
            case 'Rat-Race'
            case 'Quarter-Wave'
            case 'General'
                switch transmission_line_type
                    case 'Stripline'
                    case 'Coaxial'
                    case 'Microstrip'
                end
        end
    case 'Propagation Constant'
        switch circuit_type
            case 'Wilkinson'
            case 'Quadrature'
                switch transmission_line_type
                    case 'Stripline'
                        propConst = QuadratureHybrid.calculatePropagationConstant(metal_conductivity, relative_permittivity, relative_permeability, frequency, 'Strip');
                    case 'Coaxial'
                        propConst = QuadratureHybrid.calculatePropagationConstant(metal_conductivity, relative_permittivity, relative_permeability, frequency, 'Coax');
                    case 'Microstrip'
                        propConst = QuadratureHybrid.calculatePropagationConstant(metal_conductivity, relative_permittivity, relative_permeability, frequency, 'Micro');
                end
                result1 = num2str(propConst); result2 = ''; result3 = ''; result4 = '';
            case 'Rat-Race'
            case 'Quarter-Wave'
            case 'General'
                switch transmission_line_type
                    case 'Stripline'
                    case 'Coaxial'
                    case 'Microstrip'
                end
        end
    case 'Guide Wavelength'
        switch circuit_type
            case 'Wilkinson'
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
            case 'Quarter-Wave'
            case 'General'
                switch transmission_line_type
                    case 'Stripline'
                    case 'Coaxial'
                    case 'Microstrip'
                end
        end
end
end

