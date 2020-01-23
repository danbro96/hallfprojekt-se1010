%{
Hållfasthetslära SE1010 Projektuppgift
Variabellista till uppgift 1a-d
https://github.com/danbro96/hallfprojekt-se1010

2019-12-11
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


%Givna variabler
    v   = 100/3.6;          %m/s        Max fart (rakt fram)
    R   = 20;               %m          Kurvradie (vid 0,5v)
    a1  = 6;                %m/s2       Max acceleration
    a2  = -15;              %m/s2       Max retardation
    m   = 120;              %kg         Fordonets totalvikt
    c   = 0.3;              %           Luftmotståndskoefficient
    A   = 0.6;              %m2         Fortonets frontarea
    df  = 0.8;              %m          Avstånd från framaxel till tyngpunkt
    db  = 0.3;              %m          Avstånd från bakaxel till tyngdpunkt
    h   = 0.3;              %m          Tyngdpunktens vertikala position
    h1  = 0.3;              %m          Avstånd mellan tyngdpunkt och luftmotståndets verkningslinje
    L   = 1.1;              %m          Bakaxellängd
    b1  = 0.15;             %m          Hjullagerposition
    bb  = 0.3;             %m          Bromsskivans position
    dh  = 0.3;              %m          Hjuldiameter
    rh  = dh/2;             %m          Hjulradie
    rb  = 0.01*dh;          %m          Bromsbackarnas position
    rd  = 0.01*dh;          %m          Drevets radie
    bd  = 0.1;              %m          Drevets position
    p1  = 0.0045;           %m          Kälradie
    p2  = p1;               %m          Kälradie
    ns  = 3;                %           Säkerhetsfaktor mot plastisk deformation
    nu  = 1.8;              %           Säkerhetsfaktor mot utmattning

%Övriga variabler
    g   = 9.82;             %m/s2       Tyngdacceleration
    pluft = 1.21;           %kg/m3      Densitet luft
    
    % Materialval Tab. 33.1 s.386 i FS , #7 SIS-141650-01
    Rm  = 590*10^6;         %Pa         Brottgräns
    Su  = 200*10^6;         %Pa         +-200MPa sigma u, betecknar utmattningsgränsen vid växlande drag/tryck
    Sup = 180*10^6;         %Pa         180+-180MPa sigma up, betecknar utmattningsgränsen vid pulserande drag eller tryck
    Sub = 270*10^6;         %Pa         Utmattningsgränsen vid växlande böjning
    Subp = 240*10^6;        %Pa         240+-240MPa sigma ubp, betecknar utmattningsgränsen vid pulserande böjning
    Ss  = 310*10^6;         %Pa         sigma s >310 MPa Sträckgräns
    %KN = 1.65;             %           Spänningskoncentrationsfaktorn, drag figur 159b GH s.252
    %KM = 1.45;             %           Spänningskoncentrationsfaktorn, böj figur 159c GH s.252
    
    
    %Ss = 325*10^6;          %Pa         Sträckgräns stål SS-1650-01
    
    D = 0.048;               %m          Axelns diameter
    d = 0.6*D;
    
    %D/d=1.666, p1/d=0.163 =>
    KN1 = 1.65;                                          %Se F.S. 32.4
    KM1 = 1.48;                                          %Se F.S. 32.5
    KMx1 = 1.3;                                          %Se F.S. 32.5a
    
    %rb*2/D & rd*2/D=1.3043, p2/D=0.0975 =>
    KN2 = 1.9;
    KM2 = 1.62;
    KMx2 = 1.4;
    
    if abs(b1 - (L/2-bb)) < 0.001
        error('VARNING, Bromsbacken är i hjullagret! b1 = L/2-bb')
    end
    
    if abs(L-b1 - (L/2+bd)) < 0.001
       error('VARNING, Drevet är i hjullagret! L-b1 = L/2+bd') 
    end