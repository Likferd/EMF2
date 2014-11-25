% Stripline Calculator
% Output the following
% width W, wavenumber k, wavelength lambda
% attenuation alpha, propagation constant gamma


clear all
close all
clc

% Inputs
Z0 = 50; % ohm, characteristic impedance
b = 0.32; % cm, ground plane spacing
er = 2.20; % relative permittivity
f = 10; % GHz, frequency
t = 0.01; % mm, conductor thickness

loss_tangent = 0.001; % tan_delta
R_s = 0.026; % ohm, surface resistance

x = 30 * pi / (sqrt(er)*Z0) - 0.441;
% Width
if sqrt(er) * Z0 < 120
    W = b*x;
elseif sqrt(er) * Z0 > 120
    W = b * (0.85 - sqrt(0.6 - x));
end

% Wavenumber, m^-1
c = 3 * 10 ^ 8; % m/s, speed of light
k = 2 * pi * (f * 10^9) * sqrt(er) / c;

% wavelength, cm
lambda = c / (sqrt(er)* (f * 10^9)) * 10^2;

% dielectric attenuation alpha_d, Np/m
alpha_d = k * loss_tangent / 2

% conductor attenuation alpha_c,  Np/m
A = 1 + (2 * W * 10) / (b - t) + (1 / pi) * (b + 1)/(b - 1) * log((2 * b - t) / t);
B = 1 + (b / (0.5 * W + 0.7 * t)) * (0.5 + 0.414 * t / W + (1 / (2 * pi) * log(4 * pi * W / t)));
if sqrt(er) * Z0 < 120
    alpha_c = (2.7 * 10^(-3) * R_s * er * Z0 * A) / (30 * pi * (b - t));
elseif sqrt(er) * Z0 > 120
    alpha_c = 0.16 * R_s * B / (Z0 * b);
end



