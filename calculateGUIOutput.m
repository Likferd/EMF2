function [ result1, result2, result3, result4 ] = calculateGUIOutput( desired_output, transmission_line_type, circuit_type, characteristic_impedance, substrate_thickness, metal_thickness, metal_conductivity, frequency, coupling_ratio )
switch desired_output
    case  'Width'
        switch circuit_type
            case 'Wilkinson'
            case 'Quadrature'
            case 'Rat-Race'
            case 'Quarter-Wave'
            case 'General'
                switch transmission_line_type
                    case 'Stripline'
                    case 'Coaxial'
                      %  result1 = coaxial.calculateWidth(substrate_thickness,relative_permittivity, relative_permeability, characteristic_impedance);
                    case 'Microstrip'
                end
        end
    case 'Length'
        switch circuit_type
            case 'Wilkinson'
            case 'Quadrature'
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
