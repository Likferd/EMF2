clear all; close all; clc;
c = 3e8; %speed of light

calculation = input('Do you want to calculate W/d ratio or Z0? Enter "ratio" or "impedence": ','s');

switch calculation
    
    case 'ratio'
        er = input('Relative Permitivity: ');
        Z0 = input('Characteristic Impedence: ');
        u = input('Relative Permeability: ')*pi*4e-7; 
        w = input('Enter Operating Frequency in Hz: ')*2*pi;
        sigma = input('Enter Conductivity: ');
        
        loss_tangent = (w*imag(er) + sigma)/(w*real(er));
        A = Z0/60 * sqrt((er+1)/2) + ((er-1)/(er+1))*(.23+(.11/er));
        B = 377*pi / (2*Z0*sqrt(er));

         
        
        response = input('Is the desired W/d ratio greater than or equal to 2? Answer "Yes" or "No": ','s');

        TF = strcmp(response,'No');

        if TF==1
            Wdratio = 8*exp(A) / (exp(2*A)-2);
        else
            Wdratio = (2/pi)*(B - 1 - log(2*B -1) + ((er-1)/(2*er))*(log(B-1)+.39-(.61/er)));
        end
        ee = (er+1)/2 + ((er-1)/2)*(1/sqrt(1+(12/Wdratio))); 
        
        formatWD='WDratio = %d \n';
        fprintf(formatWD,Wdratio);
        
       
    case 'impedence'
        er = input('Relative Permitivity: ');
        Wdratio = input('WDratio: ');
        u = input('Relative Permeability: ')*pi*4e-7;
        w = input('Enter Operating Frequency in Hz: ')*2*pi;
        sigma = input('Enter Conductivity: ');
        
        loss_tangent = (w*imag(er) + sigma)/(w*real(er));
        ee = (er+1)/2 + ((er-1)/2)*(1/sqrt(1+(12/Wdratio))); 
      
        if Wdratio < 1
            Z0 = (60/log(ee))*log((8/Wdratio)+(Wdratio/4));
        else
            Z0 = (120*pi) / (sqrt(ee)*(Wdratio + 1.393 + .667*log(Wdratio + 1.444)));
        end
        
        formatZ='Z0 = %d Ohms \n';
        fprintf(formatZ,Z0);
        
    otherwise
        fprintf('\nPlease try again.\n');       
       
end

k0 = w/c;
d = input('Enter desired substrate thickness, in meters: ');
W = Wdratio*d;
                
alpha_d = (k0*er*(ee-1)*loss_tangent)/(2*sqrt(ee)*(er-1)); alpha_dDB = alpha_d*8.686;
Rs = sqrt((w*u/(2*sigma)));
alpha_c = Rs/(Z0*W); alpha_cDB = alpha_c*8.686;
Beta = sqrt(ee)*k0; BetadB = 20*log10(Beta);
gammaDB = alpha_cDB + alpha_dDB + 1i*BetadB;
gamma = 10^(gammaDB/20); %gamma not in dB
        
phi = input('Enter Desired Phase Delay, in degrees: ');
l = phi*(pi/180)/Beta; 
lambda = 2*pi/Beta;

formatPC='Gamma = %d dB \n';
fprintf(formatPC,gammaDB);
formatL='length = %d m \n';
fprintf(formatL,l);



