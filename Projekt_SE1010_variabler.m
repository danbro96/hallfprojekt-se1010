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
    bb  = 0.3;              %m          Bromsskivans position
    dh  = 0.3;              %m          Hjuldiameter
    rh  = dh/2;             %m          Hjulradie
    rb  = 0.03;             %m          Bromsbackarnas position
    rd  = 0.03;             %m          Drevets radie
    bd  = 0.1;              %m          Drevets position
    p1  = 0.0045;           %m          Kälradie
    p2  = p1;               %m          Kälradie
    ns  = 3;                %           Säkerhetsfaktor mot plastisk deformation
    nu  = 1.8;              %           Säkerhetsfaktor mot utmattning

%Övriga variabler
    g   = 9.82;             %m/s2       Tyngdacceleration
    pluft = 1.21;           %kg/m3      Densitet luft
    SMmax = 325*10^6;       %Pa         Max sträckgräns stål SS-1650-01 Sträckgräns 325

    D = 0.043;               %m          Axelns diameter
    d = 0.6*D;