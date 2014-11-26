classdef QuadratureHybrid
    methods (Access = public, Static)
        function [width] = getWidth(substrateThickness, fabricationType)
            switch fabricationType
                case 'Micro'
                    %test parameters
                    z0 = 50;
                    lambda_0 = 30;
                    epsilon_r = 2.2;
                    d = substrateThickness;
                    %Give
                    d = 0.158*10^(-2);

                    S = [0 (-1*1i/sqrt(2)) (-1/sqrt(2)) 0; (-1*1i/sqrt(2)) 0 0 (-1/sqrt(2)); (-1/sqrt(2)) 0 0 (-1*1i/sqrt(2)); 0 (-1/sqrt(2)) (-1*1i/sqrt(2)) 0];
                    Z = s2z4(S);

                    %find coupling
                    C = 10*log(1/(1-(Z(0+1,1+1)/z0)^2));
                    lambda = lambda_0/sqrt(epsilon_r);

                    %W for microstrip
                    width = d*WDratio_g2(z0,epsilon_r);
                case 'Strip'
                case 'Coax'
            end
        end
    end
end