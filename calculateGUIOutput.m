function [ result1, result2, result3, result4, result5 ] = calculateGUIOutput( desired_output, transmission_line_type, circuit_type, characteristic_impedance, substrate_thickness, metal_thickness, metal_conductivity, relative_permittivity, relative_permeability, frequency, coupling_ratio, phase_shift, load_impedance )
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
                        result1 = strcat('width12 = ',num2str(width12), ' m'); result2 = strcat('effective width12 = ',num2str(effectivewidth12), ' m'); result3 = strcat('width13 = ',num2str(width13), ' m'); result4 = strcat('effective width13 = ',num2str(effectivewidth13), ' m');
                    case 'Coaxial'
                        width = coaxial.calculateWidth(substrate_thickness,relative_permittivity, characteristic_impedance);
                        result1 = strcat('width = ',num2str(width), ' m'); result2 = ''; result3 = ''; result4 = '';
                    case 'Microstrip'
                        [Z12,Z13,~,~,~] = Wilkinson.getResistance(coupling_ratio,characteristic_impedance,1);
                        [width12,effectivewidth12,width13,effectivewidth13] = Wilkinson.getBranchWidth12(Z12,Z13,substrate_thickness,relative_permittivity,1,1,'Micro');
                        result1 = strcat('width12 = ',num2str(width12), ' m'); result2 = strcat('effective width12 =',num2str(effectivewidth12), ' m'); result3 = strcat('width13 = ',num2str(width13), ' m'); result4 = strcat('effective width13 = ',num2str(effectivewidth13), ' m');
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
                result1 = strcat('width_in = ',num2str(width_in), ' m'); result2 = strcat('width1 = ',num2str(width1), ' m'); result3 = strcat('width2 = ',num2str(width2), ' m'); result4 = '';
            case 'Rat-Race'
                switch transmission_line_type
                    case 'Stripline'
                        [widthZ0, widthsqrt2Z0] = RatRaceCoupler.getWidth(relative_permittivity, relative_permeability, characteristic_impedance, substrate_thickness, 'Strip');
                    case 'Coaxial'
                        [widthZ0, widthsqrt2Z0] = RatRaceCoupler.getWidth(relative_permittivity, relative_permeability, characteristic_impedance, substrate_thickness, 'Coax');
                    case 'Microstrip'
                        [widthZ0, widthsqrt2Z0] = RatRaceCoupler.getWidth(relative_permittivity, relative_permeability, characteristic_impedance, substrate_thickness, 'Micro');
                end
                result1 = strcat('widthZ0 = ',num2str(widthZ0), ' m'); result2 = strcat('width_sqrtZ0 = ',num2str(widthsqrt2Z0), 'm'); result3 = ''; result4 = '';
            otherwise
                switch transmission_line_type
                    case 'Stripline'
                        %Stripline width outputs to cm, we need to convert this to meters by multiplying by 0.01
                        %Substrate thickness input should be in cm
                        result1 = strcat('width = ',num2str(0.01*StriplineClass.getStriplineWidth(relative_permittivity, characteristic_impedance, 100*substrate_thickness)),' m');
                    case 'Coaxial'
                        result1 = strcat('width = ',num2str(coaxial.calculateWidth(substrate_thickness,relative_permittivity, relative_permeability, characteristic_impedance)), ' m');
                    case 'Microstrip'
                        result1 = strcat('width = ',num2str(substrate_thickness*WDratio_g2(characteristic_impedance, relative_permittivity)), ' m');
               end
               result2 = ''; result3 = ''; result4 = '';
        end
        result5 = '';
    case 'Length'
        switch circuit_type
            case 'Wilkinson'
                switch transmission_line_type
                    case 'Stripline'
                        %The stripline guide wavelength function takes frequency in GHz, so we need to convert our frequency in Hz to GHz by dividing by 10^9
                        lambda = 0.01*StriplineClass.getStriplineGuideWavelength(relative_permittivity, frequency/(10^9));
                    case 'Coaxial'
                        lambda = coaxial.getGuideWavelength(frequency, relative_permeability, relative_permittivity);
                    case 'Microstrip'
                        [~,~,~,beta] = microstripclass.getPropConstants(relative_permittivity,2*pi*frequency,mu_0*relative_permeability,metal_conductivity,WDratio_g2(characteristic_impedance,relative_permittivity),characteristic_impedance,substrate_thickness);
                        lambda = microstripclass.getGuideWavelength(beta);
                end
                result1 = strcat('length = ',num2str(Wilkinson.getLength(lambda)), ' m'); result2 = ''; result3 = ''; result4 = '';
            case 'Quadrature'
                switch transmission_line_type
                    case 'Stripline'
                        
                        length = QuadratureHybrid.calculateLength(relative_permittivity, relative_permeability, frequency, 'Strip');
                    case 'Coaxial'
                        length = QuadratureHybrid.calculateLength(relative_permittivity, relative_permeability, frequency, 'Coax');
                    case 'Microstrip'
                        length = QuadratureHybrid.calculateLength(relative_permittivity, relative_permeability, frequency, 'Micro');
                end
                result1 = strcat('length = ',num2str(length), ' m'); result2 = ''; result3 = ''; result4 = '';
            case 'Rat-Race'
                switch transmission_line_type
                    case 'Stripline'
                        [length_lamdafour, length_threelamdafour] = RatRaceCoupler.getLength(relative_permittivity, relative_permeability, frequency, 'Strip');
                    case 'Coaxial'
                        [length_lamdafour, length_threelamdafour] = RatRaceCoupler.getLength(relative_permittivity, relative_permeability, frequency, 'Coax');
                    case 'Microstrip'
                        [length_lamdafour, length_threelamdafour] = RatRaceCoupler.getLength(relative_permittivity, relative_permeability, frequency, 'Strip');
                end
                result1 = strcat('length_lambda4 = ',num2str(length_lamdafour),' m'); result2 = strcat('length_3lamda4 = ',num2str(length_threelamdafour), ' m'); result3 = ''; result4 = '';
            otherwise
                switch transmission_line_type
                    case 'Stripline'
                        %The strip line propagation constant function takes frequency in GHz, so convert to GHz by dividing by 10^9
                        %Convert substrate thickness to cm by multiplying by 100
                        [~, beta] = StriplineClass.getStriplinePropagationConstant(relative_permittivity, frequency/(10^9), metal_conductivity, characteristic_impedance, substrate_thickness*100, mu_0*relative_permeability, metal_thickness*100);
                        result1 = strcat('length = ', num2str(0.01*StriplineClass.getLength(beta,phase_shift)), ' m');
                        result2 = ''; result3 = ''; result4 = '';
                    case 'Coaxial'
                        result1 = strcat('length = ',num2str(coaxial.getLength(frequency, relative_permeability, relative_permittivity)), ' m');
                        result2 = ''; result3 = ''; result4 = '';
                    case 'Microstrip'
                        [beta, ~] = microstripclass.getBeta(relative_permittivity,2*pi*frequency,WDratio_g2(characteristic_impedance, relative_permittivity));
                        result1 = strcat('length = ',num2str(microstripclass.getLength(beta,phase_shift)), ' m');
                        result2 = ''; result3 = ''; result4 = '';
                end
        end
        result5 = '';
    case 'Impedance'
        switch circuit_type
            case 'Wilkinson'
                [Z12,Z13,R,R1, R2] = Wilkinson.getResistance(coupling_ratio,characteristic_impedance,1);
                result1 = strcat('R = ',num2str(R),' ohms'); result2 = strcat('Z12 = ', num2str(Z12), ' ohms'); result3 = strcat('Z13 = ',num2str(Z13), ' ohms'); result4 = strcat('R1 = ',num2str(R1), ' ohms'); result5 = strcat('R2 = ', num2str(R2), ' ohms');
            case 'Quadrature'
                [impedance_in, impedance01, impedance02] = QuadratureHybrid.calculateImpedance(coupling_ratio, characteristic_impedance);
                result1 = strcat('impedance_in = ',num2str(impedance_in),' ohms'); result2 = strcat('impedance01 = ',num2str(impedance01), ' ohms'); result3 = strcat('impedance02 = ',num2str(impedance02),' ohms'); result4 = ''; result5 = '';
            case 'Rat-Race'
                [impedance, impedance_ring] = RatRaceCoupler.getImpedance(characteristic_impedance);
                result1 = strcat('impedance = ' ,num2str(impedance), ' ohms'); result2 = strcat('impedance_ring = ',num2str(impedance_ring), ' ohms'); result3 = ''; result4 = ''; result5 = '';
            otherwise
                switch transmission_line_type
                    case 'Stripline'
                        %WRONG ANSWER, temporary
                        result1 = strcat('impedance = ',num2str(characteristic_impedance), ' ohms');
                    case 'Coaxial'
                        result1 = strcat('impedance =  ',num2str(coaxial.getImpedance(characteristic_impedance, substrate_thickness, relative_permeability, relative_permittivity)), ' ohms');
                    case 'Microstrip'
                        result1 = strcat('impedance = ',num2str(microstripclass.getZ0(WDratio_g2(characteristic_impedance, relative_permittivity),relative_permittivity)), ' ohms');%Check
                end
               result2 = ''; result3 = ''; result4 = ''; result5 = '';
        end
    case 'Propagation Constant'
        switch circuit_type
            case 'Quadrature'
                switch transmission_line_type
                    case 'Stripline'
                        propConst = QuadratureHybrid.calculatePropagationConstant(metal_conductivity, relative_permittivity, relative_permeability, frequency, 'Strip', characteristic_impedance, substrate_thickness, metal_thickness, phase_shift);
                    case 'Coaxial'
                        propConst = QuadratureHybrid.calculatePropagationConstant(metal_conductivity, relative_permittivity, relative_permeability, frequency, 'Coax', characteristic_impedance, substrate_thickness, metal_thickness, phase_shift);
                    case 'Microstrip'
                        propConst = QuadratureHybrid.calculatePropagationConstant(metal_conductivity, relative_permittivity, relative_permeability, frequency, 'Micro', characteristic_impedance, substrate_thickness, metal_thickness, phase_shift);
                end
                result1 = strcat('propagation constant = ',num2str(propConst)); result2 = ''; result3 = ''; result4 = '';
            case 'Rat-Race'
                switch transmission_line_type
                    case 'Stripline'
                        result1 = strcat('propagation constant = ', num2str(RatRaceCoupler.getPropagationConstant(metal_conductivity, relative_permittivity, relative_permeability, frequency, 'Strip', characteristic_impedance, substrate_thickness, metal_thickness)));
                    case 'Coaxial'
                        result1 = strcat('propagation constant = ',num2str(RatRaceCoupler.getPropagationConstant(metal_conductivity, relative_permittivity, relative_permeability, frequency, 'Coax', characteristic_impedance, substrate_thickness, metal_thickness)));
                    case 'Microstrip'
                        result1 = strcat('propagation constant = ', num2str(RatRaceCoupler.getPropagationConstant(metal_conductivity, relative_permittivity, relative_permeability, frequency, 'Micro', characteristic_impedance, substrate_thickness, metal_thickness)));
                end
                result2 = ''; result3 = ''; result4 = '';
           case 'Quarter-Wave'
                switch transmission_line_type
                    case 'Stripline'
                        %Input frequency should be in GHz
                        guideWavelength = num2str(0.01*StriplineClass.getStriplineGuideWavelength(relative_permittivity, frequency/(10^9)));
                    case 'Coaxial'
                        guideWavelength = num2str(coaxial.getGuideWavelength(frequency, relative_permeability, relative_permittivity));
                    case 'Microstrip'
                        [~,~,~,beta] = microstripclass.getPropConstants(relative_permittivity,2*pi*frequency,mu_0*relative_permeability,metal_conductivity,WDratio_g2(characteristic_impedance,relative_permittivity),characteristic_impedance,substrate_thickness);
                        guideWavelength = num2str(microstripclass.getGuideWavelength(beta));
                    otherwise
                        guideWavelength = 0;
                end
                Z1 = num2str(QuarterWaveStub.getZ1(characteristic_impedance,load_impedance));
                result1 = strcat('Z1 = ',Z1,' ohms');
                BetaL = QuarterWaveStub.getBetaL(frequency,guideWavelength);
                result2 = strcat('Zin = ',QuarterWaveStub.getZin(BetaL,Z1,load_impedance), ' ohms');
            otherwise
                switch transmission_line_type
                    case 'Stripline'
                        %Input frequency should be in GHz
                        %Input substrate thickness should be in cm
                        %Input metal thickness should be in cm
                        result1 = strcat('propagation constant = ',num2str(StriplineClass.getStriplinePropagationConstant(relative_permittivity, frequency/(10^9), metal_conductivity, characteristic_impedance, substrate_thickness*100, mu_0*relative_permeability, metal_thickness*100)));
                    case 'Coaxial'
                        result1 = strcat('propagation constant = ',num2str(coaxial.getPropagationConstant(frequency, relative_permeability, relative_permittivity, metal_conductivity, characteristic_impedance, substrate_thickness)));
                    case 'Microstrip'
                        [gamma,~,~,~] = microstripclass.getPropConstants(relative_permittivity,2*pi*frequency,mu_0*relative_permeability,metal_conductivity,WDratio_g2(characteristic_impedance, relative_permittivity),characteristic_impedance,substrate_thickness);
                        result1 = strcat('propagation constant = ',num2str(gamma));
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
                result1 = strcat('lambda = ',num2str(guideWavelength), ' m'); result2 = ''; result3 = ''; result4 = '';
            case 'Rat-Race'
                switch transmission_line_type
                    case 'Stripline'
                        [lambda] = RatRaceCoupler.getGuideWavelength(relative_permittivity,relative_permeability,frequency,'Strip');
                    case 'Coaxial'
                        [lambda] = RatRaceCoupler.getGuideWavelength(relative_permittivity,relative_permeability,frequency,'Coax');
                    case 'Microstrip'
                        [lambda] = RatRaceCoupler.getGuideWavelength(relative_permittivity,relative_permeability,frequency,'Micro');
                end
                result1 = strcat('lambda = ',num2str(lambda), ' m'); result2 = ''; result3 = ''; result4 = '';
            otherwise
                switch transmission_line_type
                    case 'Stripline'
                        %Input frequency should be in GHz
                        result1 = strcat('lambda = ',num2str(0.01*StriplineClass.getStriplineGuideWavelength(relative_permittivity, frequency/(10^9))), ' m');
                    case 'Coaxial'
                        result1 = strcat('lambda = ',num2str(coaxial.getGuideWavelength(frequency, relative_permeability, relative_permittivity)), ' m');
                    case 'Microstrip'
                        [~,~,~,beta] = microstripclass.getPropConstants(relative_permittivity,2*pi*frequency,mu_0*relative_permeability,metal_conductivity,WDratio_g2(characteristic_impedance,relative_permittivity),characteristic_impedance,substrate_thickness);
                        result1 = strcat('lambda = ',num2str(microstripclass.getGuideWavelength(beta)), ' m');
                end
                result2 = ''; result3 = ''; result4 = '';
        end
        result5 = '';
end
end

