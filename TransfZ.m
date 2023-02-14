%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%Synthesis of a function - Z Transform
%Felipe Alexandre da Silva Bento - 119111014
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

% The purpose of this synthesis is as follows:
%Using the z Transform, design a real function whose amplitude is decreasing.
%For this function draw the diagram of poles and zeros, the position of the pole and the Fourier transform.
clc
close all
syms z
syms n
syms w


a=0.925; %chosen value of Alpha 
X_z = z/(z-a); % Function in Z
X_n = iztrans(X_z,'n') %Prints the value of the inverse transform of Z and saves it in X(n) 
%X_n = (a.^(n));


%Whit some paramethers of X(n) we will plot the graph
n = 0:50;
Xn = eval(X_n);

%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%PLOT THE GRAPH
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

figure(1)
stem(n, Xn, 'Linewidth',1, 'color', 'red');
title('X(n) x n ');
ylabel('X(n)');
xlabel('n');

%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%FOUND POLES AND ZEROS
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

%Here we extract the numerator and denominator of the function
[num, den] = numden ((X_z))

%Now we extract only the coefficients
nx = coeffs(num,'All')           %Numerator coefficients
dx = coeffs(den,'All')           %Numerator coefficients
nx = double(nx)                  %The next function require the variables to be of type Double
dx = double(dx)                  %The next function require the variables to be of type Double

[z, p, k] = tf2zp(nx,dx)         %This function find poles and zeros from numerator and denominator

%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%POLES AND ZEROS DIAGRAM
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

figure(2)
zplaneplot (z,p) %graficar en el plano Z los polos y ceros
grid on
title('Plano transformada Z')

%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%FOURIER PHASE AND MAGNITUDE
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

%We know that to find the fourier transform just replace z by e^jw
%So X_w = e^jw/(e^jw - a), where "a" is the value of a pole
figure(4)
freqz(nx,dx)