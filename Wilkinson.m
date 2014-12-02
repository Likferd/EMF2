% V = input('Enter Voltage Supplied to Ports 2 and 3: ');
% Z0 = input('Enter Characteristic Impedence: ');
% er = input('Enter permitivity: ');
% u0 = pi*4e-7; u = u0;
% ZL = sqrt(u/er);
% c = 3e8;
% V0 = V/2;
% 
% Zin0 = Z0^2;

% would have width already

classdef Wilkinson
  methods  (Access = public, Static)
      
      function [S] = SParameters()
          %for equal split
          S = (1/sqrt(2))*[0 -1*i -1*i; -1*i 0 0; -1*i 0 0];
      end
      
      function [length] = getLength(guidewavelength)
          length = guidewavelength/4;
      end
      
      function [Z12,Z13,R,R2,R3] = getResistance(couplingratio,Z0,isEqual)
          %enter a boolean value for isEqual
          %0 for non-equal 
          %1 for equal
          %K is the coupling ratio, not in dB
          
          switch isEqual
              case 1
                  Z12 = Z0*sqrt(2);
                  Z13 = Z0*sqrt(2);
                  R = 2*Z0;
                  R2 = 50;
                  R3 = 50;
              case 0 
                  K = 10^(sqrt(couplingratio)/10);
                  Z13 = Z0*sqrt((1+K^2)/K^3);
                  Z12 = K^2 * Z13;
                  R = Z0 * (K + (1/K));
                  R2 = Z0*K;
                  R3 = Z0/K;
          end
      end
     
      function [width12,effectivewidth12,width13,effectivewidth13] = getBranchWidth12(Z12,Z13,substratethickness,er,greater_than_2_12,greater_than_2_13,transmissionlinetype)
        %12 means path between ports 1 and 2
        %13 means path between ports 1 and 3
        %enter a 0 if the Wdratio should not be greater than 2
        %enter a 1 if the Wdratio should be greater than 2
        %enter 'Micro' for microstrip and 'Strip' for Stripline
        switch transmissionlinetype
            case 'Micro'
                if greater_than_2_12 ==1
                    B2 = (377*pi)/(2*Z12*sqrt(er));
                    Wdratio2 = (2/pi)*(B2 - 1 - log(2*B2 -1) + ((er-1)/(2*er))*(log(B2-1)+.39-(.61/er)));
                    width12 = Wdratio2*substratethickness;
                    effectivewidth12 = width12;
                end
        
                if greater_than_2_12 ==0
                    A2 = Z12/60 * sqrt((er+1)/2) + ((er-1)/(er+1))*(.23+(.11/er));
                    Wdratio2 = 8*exp(A2) / (exp(2*A2)-2);
                    width12 = Wdratio2*substratethickness;
                    effectivewidth12 = width12;
                end
                if greater_than_2_13 ==1
                    B3 = (377*pi)/(2*Z13*sqrt(er));
                    Wdratio3 = (2/pi)*(B3 - 1 - log(2*B3 -1) + ((er-1)/(2*er))*(log(B3-1)+.39-(.61/er)));
                    width13 = Wdratio3*substratethickness;
                    effectivewidth13 = width13;
                end
        
                if greater_than_2_13 ==0
                    A3 = Z13/60 * sqrt((er+1)/2) + ((er-1)/(er+1))*(.23+(.11/er));
                    Wdratio3 = 8*exp(A3) / (exp(2*A3)-2);
                    width13 = Wdratio3*substratethickness;
                    effectivewidth13 = width13;
                end 
                
            case 'Strip'
                x12 = ((30*pi)/(sqrt(er)*Z12))-.441;
                x13 = ((30*pi)/(sqrt(er)*Z13))-.441;
                if sqrt(er)*Z12 < 120
                    width12 = x12*substratethickness;
                    width13 = x13*substratethickness;
                else
                    width12 = (0.85 - sqrt(.6-x12))*substratethickness;
                     width13 = (0.85 - sqrt(.6-13))*substratethickness;
                end
                
                if width12/substratethickness > .35
                    effectivewidth12 = width12;
                   
                else
                    effectivewidth12 = ((width12/substratethickness) - (.35 - width12/substratethickness)^2)*substratethickness;
                    
                end
                
                if width13/substratethickness > .35
                    
                    effectivewidth13 = width13;
                else
                    
                    effectivewidth13 = ((width13/substratethickness) - (.35 - width13/substratethickness)^2)*substratethickness;
                end
                
            case 'Coax'
                width12 = coaxial.calculateWidth(substratethickness,er,Z12);
                width13 = coaxial.calculateWidth(substratethickness,er,Z13);
                effectivewidth12 = width12;
                effectivewidth13 = width13;
                
        end
      end

        
  end  
end