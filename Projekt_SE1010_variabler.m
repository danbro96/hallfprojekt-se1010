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
    bb  = 0.3;             %m          Bromsskivans position
    dh  = 0.3;              %m          Hjuldiameter
    rh  = dh/2;             %m          Hjulradie
    rb  = 0.01*dh;          %m          Bromsbackarnas position
    rd  = 0.01*dh;          %m          Drevets radie
    bd  = 0.1;              %m          Drevets position
    p1  = 0.0045;           %m          K�lradie
    p2  = p1;               %m          K�lradie
    ns  = 3;                %           S�kerhetsfaktor mot plastisk deformation
    nu  = 1.8;              %           S�kerhetsfaktor mot utmattning

%�vriga variabler
    g   = 9.82;             %m/s2       Tyngdacceleration
    pluft = 1.21;           %kg/m3      Densitet luft
    
    % Materialval Tab. 33.1 s.386 i FS , #7 SIS-141650-01
    Rm  = 590*10^6;         %Pa         Brottgr�ns
    Su  = 200*10^6;         %Pa         +-200MPa sigma u, betecknar utmattningsgr�nsen vid v�xlande drag/tryck
    Sup = 180*10^6;         %Pa         180+-180MPa sigma up, betecknar utmattningsgr�nsen vid pulserande drag eller tryck
    Sub = 270*10^6;         %Pa         Utmattningsgr�nsen vid v�xlande b�jning
    Subp = 240*10^6;        %Pa         240+-240MPa sigma ubp, betecknar utmattningsgr�nsen vid pulserande b�jning
    Ss  = 310*10^6;         %Pa         sigma s >310 MPa Str�ckgr�ns
    %KN = 1.65;             %           Sp�nningskoncentrationsfaktorn, drag figur 159b GH s.252
    %KM = 1.45;             %           Sp�nningskoncentrationsfaktorn, b�j figur 159c GH s.252
    
    
    %Ss = 325*10^6;          %Pa         Str�ckgr�ns st�l SS-1650-01
    
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
        error('VARNING, Bromsbacken �r i hjullagret! b1 = L/2-bb')
    end
    
    if abs(L-b1 - (L/2+bd)) < 0.001
       error('VARNING, Drevet �r i hjullagret! L-b1 = L/2+bd') 
    end