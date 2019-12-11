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
clear all, close all, clc

%Givna variabler
    Projekt_SE1010_variabler
    
%% 1a   -   K�rning rakt fram med konstant fart, v
clc
    lastfall = 'A';
	v0  = v;                %m/s        Ursprungsfart
    a   = 0;                %m/s2       Acceleration
    t   = 0;                %s          F�rfluten tid sedan p�b�rjad acceleration
    
    R0  = inf;              %m          Radie kurva

Projekt_SE1010_jamviktsberakningar
Projekt_SE1010_snittning

%% 1b   -   Konstant acceleration, a1, p�b�rjad l�g fart, v0
clc
    lastfall = 'B';
    v0  = 1/6 * v;          %m/s        Ursprungsfart
    a   = a1;               %m/s2       Acceleration
    t   = 0;                %s          F�rfluten tid sedan p�b�rjad acceleration
    
    R0  = inf;              %m          Radie kurva

Projekt_SE1010_jamviktsberakningar
%Projekt_SE1010_snittning

%% 1c   -   Bromsning fr�n maxfart med konstant retardation, a2
clc
    lastfall = 'C';
    v0  = v;                %m/s        Ursprungsfart
    a   = a2;               %m/s2       Acceleration
    t   = 0;                %s          F�rfluten tid sedan p�b�rjad acceleration
    
    R0  = inf;              %m          Radie kurva

Projekt_SE1010_jamviktsberakningar
%Projekt_SE1010_snittning

%% 1d   -   K�rning med konstant fart, 0.5*v, i kurva med radie R
clc
    lastfall = 'D';
    v0  = 1/2 * v;          %m/s        Ursprungsfart
    a   = 0;                %m/s2       Acceleration
    t   = 0;                %s          F�rfluten tid sedan p�b�rjad acceleration
    
    R0  = R;                %m          Radie kurva

Projekt_SE1010_jamviktsberakningar
Projekt_SE1010_snittning

%%

%S�kes
%D                       %m          Bakaxelns diameter
%d  = 0.6*D              %m          Axeldiameter vid hjul & lager


