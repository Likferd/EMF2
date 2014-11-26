function [Wdratio] = WDratio_g2(Z0,er)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
B = (377*pi)/(2*Z0*sqrt(er));
Wdratio = (2/pi)*(B - 1 - log(2*B -1) + ((er-1)/(2*er))*(log(B-1)+.39-(.61/er)));

end

