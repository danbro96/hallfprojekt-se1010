%{
H�llfasthetsl�ra SE1010 Projektuppgift

https://github.com/danbro96/hallfprojekt-se1010

2019-12-11
Grupp 15

    VARIABELINDEXERING
    V = Vertikal    (upp-ner / z-axeln)
    H = Horisontell (h�ger-v�nster / x-axeln)
    F =             (fram-bak / y-axeln)
    f = framaxel
    b = bakaxel
    h = hjul
    i = innersida
    y = yttersida
    l = hjullager

    KOORDINATER
    x = ut till h�ger
    y = fram�t
    z = upp�t
%}


%% 1a   -   K�rning rakt fram med konstant fart, v
clear all, close all, clc

%Givna variabler
Projekt_SE1010_variabler

lastfall = 'A';
v0  = v;                %m/s        Ursprungsfart
a   = 0;                %m/s2       Acceleration
t   = 0;                %s          F�rfluten tid sedan p�b�rjad acceleration

R0  = inf;              %m          Radie kurva

Projekt_SE1010_jamviktsberakningar
Projekt_SE1010_snittning

Projekt_SE1010_plottning
Projekt_SE1010_lokspann
Projekt_SE1010_utmattning

%% 1b   -   Konstant acceleration, a1, p�b�rjad l�g fart, v0
clear all, close all, clc

%Givna variabler
Projekt_SE1010_variabler

lastfall = 'B';
v0  = 1/6 * v;          %m/s        Ursprungsfart
a   = a1;               %m/s2       Acceleration
t   = 0;                %s          F�rfluten tid sedan p�b�rjad acceleration

R0  = inf;              %m          Radie kurva

Projekt_SE1010_jamviktsberakningar
Projekt_SE1010_snittning

Projekt_SE1010_plottning
Projekt_SE1010_lokspann
Projekt_SE1010_utmattning

%% 1c   -   Bromsning fr�n maxfart med konstant retardation, a2
clear all, close all, clc

%Givna vriabler
Projekt_SE1010_variabler
lastfall = 'C';
v0  = v;                %m/s        Ursprungsfart
a   = a2;               %m/s2       Acceleration
t   = 0;                %s          F�rfluten tid sedan p�b�rjad acceleration

R0  = inf;              %m          Radie kurva

Projekt_SE1010_jamviktsberakningar
Projekt_SE1010_snittning

Projekt_SE1010_plottning
Projekt_SE1010_lokspann
Projekt_SE1010_utmattning


%% 1d   -   K�rning med konstant fart, 0.5*v, i kurva med radie R
clear all, close all, clc

%Givna variabler
Projekt_SE1010_variabler

lastfall = 'D';
v0  = 1/2 * v;          %m/s        Ursprungsfart
a   = 0;                %m/s2       Acceleration
t   = 0;                %s          F�rfluten tid sedan p�b�rjad acceleration

R0  = R;                %m          Radie kurva

Projekt_SE1010_jamviktsberakningar
Projekt_SE1010_snittning

Projekt_SE1010_plottning
Projekt_SE1010_lokspann
Projekt_SE1010_utmattning







%% 1b   -   Konstant acceleration, a1, p�b�rjad l�g fart, v0
clear all, close all, clc
VMt = [];
for i = 0.1:0.05:0.3
%Givna variabler
Projekt_SE1010_variabler
bd = i
lastfall = 'B';
v0  = 1/6 * v;          %m/s        Ursprungsfart
a   = a1;               %m/s2       Acceleration
t   = 0;                %s          F�rfluten tid sedan p�b�rjad acceleration

R0  = inf;              %m          Radie kurva

Projekt_SE1010_jamviktsberakningar
Projekt_SE1010_snittning

VMt = [];
for i = 0:0.01:L
   VMt = [VMt VM(i)]; 
end
%figure('Name',['Von Mises - Lastfall ' lastfall]);
plot(0:0.01:L,VMt)
%fplot(VM,[0 L]);
%legend("Von Mises")
xlabel('Position l�ngs X-axeln [m]')
ylabel('Moment [Nm] / Kraft [N]')
title(['Von Mises - Lastfall ' lastfall])
grid on
hold on
end
%%

%S�kes
%D                       %m          Bakaxelns diameter
%d  = 0.6*D              %m          Axeldiameter vid hjul & lager


%% 1c   -   Bromsning fr�n maxfart med konstant retardation, a2
%clear all, close all, clc
VMt = [];
for i = 0.2:0.05:0.4
%Givna vriabler
Projekt_SE1010_variabler
bb = i

lastfall = 'C';
v0  = v;                %m/s        Ursprungsfart
a   = a2;               %m/s2       Acceleration
t   = 0;                %s          F�rfluten tid sedan p�b�rjad acceleration

R0  = inf;              %m          Radie kurva

Projekt_SE1010_jamviktsberakningar
Projekt_SE1010_snittning


VMt = [];
for i = 0:0.01:L
   VMt = [VMt VM(i)]; 
end
%figure('Name',['Von Mises - Lastfall ' lastfall]);
plot(0:0.01:L,VMt)
%fplot(VM,[0 L]);
%legend("Von Mises")
xlabel('Position l�ngs X-axeln [m]')
ylabel('Moment [Nm] / Kraft [N]')
title(['Von Mises - Lastfall ' lastfall])
grid on
hold on
end