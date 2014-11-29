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
      
      function [Z02,Z03,R] = getResistance(couplingratio,Z0,isEqual)
          %enter a boolean value for isEqual
          %0 for non-equal 
          %1 for equal
          %K is the coupling ratio, not in dB
          
          switch isEqual
              case 1
                  Z02 = Z0*sqrt(2);
                  Z03 = Z0*sqrt(2);
                  R = 2*z0;
              case 0 
                  K = 10^(sqrt(couplingratio)/10);
                  Z03 = Z0*sqrt((1+K^2)/K^3);
                  Z02 = K^2 * Z03;
                  R = Z0 * (K + (1/K));
          end
      end
      
      function [R2,R3] = getResistanceforUnequal(Z0,couplingratio)
          %K is the coupling ratio, not in dB
          K = 10^(sqrt(couplingratio)/10);
          R2 = Z0*K;
          R3 = Z0/K;
      end
      
      function [width12,effectivewidth] = getBranchWidth12(Z02,substratethickness,er,greater_than_2,transmissionlinetype)
          
        %enter a 0 if the Wdratio should not be greater than 2
        %enter a 1 if the Wdratio should be greater than 2
        %enter 'Micro' for microstrip and 'Strip' for Stripline
        switch transmissionlinetype
            case 'Micro'
                if greater_than_2 ==1
                    B2 = (377*pi)/(2*Z02*sqrt(er));
                    Wdratio2 = (2/pi)*(B2 - 1 - log(2*B2 -1) + ((er-1)/(2*er))*(log(B2-1)+.39-(.61/er)));
                    width12 = Wdratio2*substratethickness;
                    effectivewidth = [];
                end
        
                if greater_than_2 ==0
                    A2 = Z02/60 * sqrt((er+1)/2) + ((er-1)/(er+1))*(.23+(.11/er));
                    Wdratio2 = 8*exp(A2) / (exp(2*A2)-2);
                    width12 = Wdratio2*substratethickness;
                    effectivewidth = [];
                end
            case 'Strip'
                x = ((30*pi)/(sqrt(er)*Z02))-.441;
                if sqrt(er)*Z02 < 120
                    width12 = x*substratethickness;
                else
                    width12 = (0.85 - sqrt(.6-x))*substratethickness;
                end
                
                if width12/substratethickness > .35
                    effectivewidth = width12;
                else
                    effectivewidth = ((width12/substratethickness) - (.35 - width12/substratethickness)^2)*substratethickness;
                end
        end
      end

        function [width13,effectivewidth] = getBranchWidth13(Z03,substratethickness,er,greater_than_2,fabricationtype)
          
        %enter a 0 if the Wdratio should not be greater than 2
        %enter a 1 if the Wdratio should be greater than 2
        %enter 'Micro' for microstrip and 'Strip' for Stripline
        
        switch fabricationtype
            case 'Micro'
                if greater_than_2 ==1
                    B3 = (377*pi)/(2*Z03*sqrt(er));
                    Wdratio3 = (2/pi)*(B3 - 1 - log(2*B3 -1) + ((er-1)/(2*er))*(log(B3-1)+.39-(.61/er)));
                    width13 = Wdratio3*substratethickness;
                end
        
                if greater_than_2 ==0
                    A3 = Z03/60 * sqrt((er+1)/2) + ((er-1)/(er+1))*(.23+(.11/er));
                    Wdratio3 = 8*exp(A3) / (exp(2*A3)-2);
                    width13 = Wdratio3*substratethickness;
                end
           case 'Strip'
               
                x = ((30*pi)/(sqrt(er)*Z03))-.441;
                if sqrt(er)*Z03 < 120
                    width13 = x*substratethickness;
                else
                    width13 = (0.85 - sqrt(.6-x))*substratethickness;
                end
                
                if width13/substratethickness > .35
                    effectivewidth = width13;
                else
                    effectivewidth = ((width13/substratethickness) - (.35 - width13/substratethickness)^2)*substratethickness;
                end
        end
      end
  end  
end