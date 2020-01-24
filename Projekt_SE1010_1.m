%{
Hållfasthetslära SE1010 Projektuppgift

https://github.com/danbro96/hallfprojekt-se1010

2019-12-17
Grupp 15

    VARIABELINDEXERING
    V = Vertikal    (upp-ner / z-axeln)
    H = Horisontell (höger-vänster / x-axeln)
    F =             (fram-bak / y-axeln)
    f = framaxel
    b = bakaxel
    h = hjul
    i = innersida
    y = yttersida
    l = hjullager

    KOORDINATER
    x = ut till höger
    y = framåt
    z = uppåt
%}


%% Lastfall A   -   Körning rakt fram med konstant fart, v
clear all, close all, clc

%Givna variabler
Projekt_SE1010_variabler

lastfall = 'A';
v0  = v;                %m/s        Ursprungsfart
a   = 0;                %m/s2       Acceleration
t   = 0;                %s          Förfluten tid sedan påbörjad acceleration

R0  = inf;              %m          Radie kurva

Projekt_SE1010_jamviktsberakningar
Projekt_SE1010_snittning

Projekt_SE1010_plottning
Projekt_SE1010_lokspann
Projekt_SE1010_utmattning

%% Lastfall B   -   Konstant acceleration, a1, påbörjad låg fart, v0
clear all, close all, clc

%Givna variabler
Projekt_SE1010_variabler

lastfall = 'B';
v0  = 1/6 * v;          %m/s        Ursprungsfart
a   = a1;               %m/s2       Acceleration
t   = 0;                %s          Förfluten tid sedan påbörjad acceleration

R0  = inf;              %m          Radie kurva

Projekt_SE1010_jamviktsberakningar
Projekt_SE1010_snittning

Projekt_SE1010_plottning
Projekt_SE1010_lokspann
Projekt_SE1010_utmattning

%% Lastfall C   -   Bromsning från maxfart med konstant retardation, a2
clear all, close all, clc

%Givna vriabler
Projekt_SE1010_variabler
lastfall = 'C';
v0  = v;                %m/s        Ursprungsfart
a   = a2;               %m/s2       Acceleration
t   = 0;                %s          Förfluten tid sedan påbörjad acceleration

R0  = inf;              %m          Radie kurva

Projekt_SE1010_jamviktsberakningar
Projekt_SE1010_snittning

Projekt_SE1010_plottning
Projekt_SE1010_lokspann
Projekt_SE1010_utmattning

%% Lastfall D   -   Körning med konstant fart, 0.5*v, i kurva med radie R
clear all, close all, clc

%Givna variabler
Projekt_SE1010_variabler

lastfall = 'D';
v0  = 1/2 * v;          %m/s        Ursprungsfart
a   = 0;                %m/s2       Acceleration
t   = 0;                %s          Förfluten tid sedan påbörjad acceleration

R0  = R;                %m          Radie kurva

Projekt_SE1010_jamviktsberakningar
Projekt_SE1010_snittning

Projekt_SE1010_plottning
Projekt_SE1010_lokspann
Projekt_SE1010_utmattning

%% Lastfall B, DREVKALKYLERING   -   Konstant acceleration, a1, påbörjad låg fart, v0
%Skapar graf för positionsbestämning av drev.

clear all, close all, clc
VMt = [];
plots = [];
y = 1;
for i = 0.1:0.05:0.3
    %Givna variabler
    Projekt_SE1010_variabler
    bd = i
    lastfall = 'B';
    v0  = 1/6 * v;          %m/s        Ursprungsfart
    a   = a1;               %m/s2       Acceleration
    t   = 0;                %s          Förfluten tid sedan påbörjad acceleration
    
    R0  = inf;              %m          Radie kurva
    
    Projekt_SE1010_jamviktsberakningar
    Projekt_SE1010_snittning
    
    VMt = [];
    for i = 0:0.01:L
        VMt = [VMt VM(i)];
    end
    %figure('Name',['Von Mises - Lastfall ' lastfall]);
    plots(y) = plot(0:0.01:L,VMt);
    y =y+1;
    hold on
    p1 = plot([0 L],[Ss/nu Ss/nu], 'g');
    p2 = plot(b1, VMx(b1),'r*');
    plot(L/2-bb, VMx(L/2-bb),'r*')
    plot(L/2+bd, VMx(L/2+bd),'r*')
    plot(L-b1, VMx(L-b1),'r*')
    %fplot(VM,[0 L]);
    %legend("Von Mises")
    xlabel('X-koordinat längs med bakaxeln [m]')
    ylabel('Effektivpänning [Pa]')
    title(['Effektivspänning med varierad drevposition - Lastfall ' lastfall ' - D = ' num2str(D) ' m'])
    grid on
    hold on
end

legend([plots(1), plots(2), plots(3), plots(4), plots(5), p1, p2], {'bd = 0,1 m', 'bd = 0,15 m', 'bd = 0,2 m', 'bd = 0,25 m', 'bd = 0,3 m', 'Sträckgräns med säkerhetsfaktor för material', 'Lokala spänningskoncentrationer'})
hold off
%% Lastfall C, BROMSKALKYLERING   -   Bromsning från maxfart med konstant retardation, a2
%Skapar graf för positionsbestämning av bromsskiva.

clear all, close all, clc
VMt = [];
plots = [];
y = 1;
for i = 0.2:0.05:0.4
    %Givna vriabler
    Projekt_SE1010_variabler
    bb = i
    
    lastfall = 'C';
    v0  = v;                %m/s        Ursprungsfart
    a   = a2;               %m/s2       Acceleration
    t   = 0;                %s          Förfluten tid sedan påbörjad acceleration
    
    R0  = inf;              %m          Radie kurva
    
    Projekt_SE1010_jamviktsberakningar
    Projekt_SE1010_snittning
    
    
    VMt = [];
    for i = 0:0.01:L
        VMt = [VMt VM(i)];
    end
    %figure('Name',['Von Mises - Lastfall ' lastfall]);
    plots(y) = plot(0:0.01:L,VMt);
    y =y+1;
    hold on
    p1 = plot([0 L],[Ss/nu Ss/nu], 'g');
    p2 = plot(b1, VMx(b1),'r*');
    plot(L/2-bb, VMx(L/2-bb),'r*')
    plot(L/2+bd, VMx(L/2+bd),'r*')
    plot(L-b1, VMx(L-b1),'r*')
    %fplot(VM,[0 L]);
    %legend("Von Mises")
    xlabel('X-koordinat längs med bakaxeln [m]')
    ylabel('Effektivpänning [Pa]')
    title(['Effektivspänning med varierad bromsposition - Lastfall ' lastfall ' - D = ' num2str(D) ' m'])
    grid on
end
legend([plots(1), plots(2), plots(3), plots(4), plots(5), p1, p2], {'bb = 0,2 m', 'bb = 0,25 m', 'bb = 0,3 m', 'bb = 0,35 m', 'bb = 0,4 m', 'Sträckgräns med säkerhetsfaktor för material', 'Lokala spänningskoncentrationer'})
hold off