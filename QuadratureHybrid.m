z0 = 15;
S = [0 (-1*1i/sqrt(2)) (-1/sqrt(2)) 0; (-1*1i/sqrt(2)) 0 0 (-1/sqrt(2)); (-1/sqrt(2)) 0 0 (-1*1i/sqrt(2)); 0 (-1/sqrt(2)) (-1*1i/sqrt(2)) 0];
Z = s2z4(S);
%find coupling
C = 10*log(1/(1-(Z(0+1,1+1)/z0)^2));