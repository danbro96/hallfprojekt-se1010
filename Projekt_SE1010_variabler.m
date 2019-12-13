%{
H�llfasthetsl�ra SE1010 Projektuppgift
Variabellista till uppgift 1a-d
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


%Givna variabler
    v   = 100/3.6;          %m/s        Max fart (rakt fram)
    R   = 20;               %m          Kurvradie (vid 0,5v)
    a1  = 6;                %m/s2       Max acceleration
    a2  = -15;              %m/s2       Max retardation
    m   = 120;              %kg         Fordonets totalvikt
    c   = 0.3;              %           Luftmotst�ndskoefficient
    A   = 0.6;              %m2         Fortonets frontarea
    df  = 0.8;              %m          Avst�nd fr�n framaxel till tyngpunkt
    db  = 0.3;              %m          Avst�nd fr�n bakaxel till tyngdpunkt
    h   = 0.3;              %m          Tyngdpunktens vertikala position
    h1  = 0.3;              %m          Avst�nd mellan tyngdpunkt och luftmotst�ndets verkningslinje
    L   = 1.1;              %m          Bakaxell�ngd
    b1  = 0.15;             %m          Hjullagerposition
    bb  = 0.3;              %m          Bromsskivans position
    dh  = 0.3;              %m          Hjuldiameter
    rh  = dh/2;             %m          Hjulradie
    rb  = 0.03;             %m          Bromsbackarnas position
    rd  = 0.03;             %m          Drevets radie
    bd  = 0.1;              %m          Drevets position
    p1  = 0.0045;           %m          K�lradie
    p2  = p1;               %m          K�lradie
    ns  = 3;                %           S�kerhetsfaktor mot plastisk deformation
    nu  = 1.8;              %           S�kerhetsfaktor mot utmattning

%�vriga variabler
    g   = 9.82;             %m/s2       Tyngdacceleration
    pluft = 1.21;           %kg/m3      Densitet luft
    SMmax = 325*10^6;       %Pa         Max str�ckgr�ns st�l SS-1650-01 Str�ckgr�ns 325

    D = 0.043;               %m          Axelns diameter
    d = 0.6*D;