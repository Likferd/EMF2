clear all
close all
clc

choice = menu('Stripline Calculator','Find width','Find characteristic impedance');

if choice == 1
    
    prompt = {'Relative permittivity er','Ground plane spacing b (cm)','Conductor thickness t (mm)','Characteristic impedance Z0 (ohm)'};
    dlg_title = 'Width';
    num_lines = 1;
    find_w_s = inputdlg(prompt,dlg_title,num_lines);
    
    find_w_n = str2double(find_w_s); %string to double
    
    er = find_w_n(1);
    b = find_w_n(2);
    t = find_w_n(3);
    Z0 = find_w_n(4);
    
    x = 30 * pi / (sqrt(er)*Z0) - 0.441;
    
    % Width
    if sqrt(er) * Z0 < 120
        W = b*x;
    elseif sqrt(er) * Z0 > 120
        W = b * (0.85 - sqrt(0.6 - x));
    end
    
    uiwait(msgbox(sprintf('The width for the stripline is %f cm.', W)))
   
elseif choice == 2
    
    prompt = {'Relative permittivity er','Ground plane spacing b (cm)','Conductor thickness t (mm)','Characteristic impedance Z0 (ohm)'};
    dlg_title = 'Z0';
    num_lines = 1;
    find_w_s = inputdlg(prompt,dlg_title,num_lines);
    
    find_w_n = str2double(find_w_s); %string to double
    
end