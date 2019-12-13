%{
H�llfasthetsl�ra SE1010 Projektuppgift
Snittning
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
%SP = [b1 L/2-bb L/2+bd L-b1 L];         %Snittpunkter

%------------------------------------------------------
%0 <= x < b1
T1 = @() -Vbi;                          %Tv�rsp�nning Z-axeln
M1 = @(x) -Vbi * x - Hbi * rh;          %Moment XZ-planet

%b1 <= x < L/2-bb
T2 = @() Vli + T1();                    %Tv�rsp�nning Z-axeln
M2 = @(x) M1(x) + Vli * (x-b1);         %Moment XZ-planet

%L/2-bb <= x < L-b1
T3 = @() -Fb + T2();                    %Tv�rsp�nning Z-axeln
M3 = @(x) M2(x) - Fb * (x-(L/2-bb));    %Moment XZ-planet

%L-b1 <= x < L
T4 = @() Vly + T3();                    %Tv�rsp�nning Z-axeln
M4 = @(x) M3(x) + Vly * (x-(L-b1));     %Moment XZ-planet

%------------------------------------------------------
%0 <= x < b1
T5 = @() -Fd/2;                         %Tv�rsp�nning Y-axeln
M5 = @(x) Fd/2 * x;                    %Moment XY-planet

%b1 <= x < L/2+bd
T6 = @() Fli + T5();                    %Tv�rsp�nning Y-axeln
M6 = @(x) M5(x) - Fli * (x-b1);         %Moment XY-planet

%L/2-bd <= x < L-b1
T7 = @() -Fk + T6();                    %Tv�rsp�nning Y-axeln
M7 = @(x) M6(x) + Fk * (x-(L/2+bd));    %Moment XY-planet

%L-b1 <= x < L
T8 = @() Fly + T7();                    %Tv�rsp�nning Y-axeln
M8 = @(x) M7(x) - Fly * (x-(L-b1));     %Moment XY-planet

%------------------------------------------------------
%0 <= x < L/2-bb
M9 = @() -Fd/2*rh;                      %Moment YZ-planet

%L/2-bb <= x < L/2+bd
M10 = @() -Fb*rb + M9();                %Moment YZ-planet

%L/2+bd <= x < L
M11 = @() Fk*rd + M10();                %Moment YZ-planet

%------------------------------------------------------
%0 <= x < b1
T9 = @() Hbi;                           %Normalkraft i X-axeln

%b1 <= x < L
T10 = @() -Hli + T9();                  %Normalkraft i X-axeln
%------------------------------------------------------
    syms x    
    
    N(x)  = piecewise(0 <= x < b1, T9(), b1 <= x < L, T10());
    Mx(x) = piecewise(0 <= x < L/2-bb, M9(), L/2-bb <= x < L/2+bd, M10(), L/2+bd <= x < L, M11());
    Mz(x) = piecewise(0 <= x < b1, M5(x), b1 <= x < L/2+bd, M6(x), L/2-bd <= x < L-b1, M7(x), L-b1 <= x < L, M8(x));
    Ty(x) = piecewise(0 <= x < b1, T5(), b1 <= x < L/2+bd, T6(), L/2-bd <= x < L-b1, T7(), L-b1 <= x < L, T8());
    My(x) = piecewise(0 <= x < b1, M1(x), b1 <= x < L/2-bb, M2(x), L/2-bb <= x < L-b1, M3(x), L-b1 <= x < L, M4(x));
    Tz(x) = piecewise(0 <= x < b1, T1(), b1 <= x < L/2-bb, T2(), L/2-bb <= x < L-b1, T3(), L-b1 <= x < L, T4());
   
    clear z
    z(x) = piecewise(0 < x <= b1, d/2, b1 < x < L-b1, D/2, L-b1 <= x < L, d/2);

%% ------------VON MISES------------

    %Wb = pi*z^3/32;                 %Se FS 6.9      %B�jmotst�nd
    %Wv = pi*z^3/16;                 %Se FS 6.78     %Vridmotst�nd

    I =  @(zt) pi*zt^4/4;                                       %Areatr�thetsmoment     Se FS 30.1.3
    Wb = @(zt) I(zt)/abs(zt);                                   %B�jmotst�nd            Se G.L. S79 
    Wv = @(zt) pi*zt^3/2;                                       %Vridmotst�nd           Se FS 6.78

    Aaxel = @(zt) zt^2*pi;                                      %Axel tv�rsnittsarea

    Mtot = @(xt) sqrt(My(xt)^2 + Mz(xt)^2);                        %Sammansatt b�jmoment
    Smax = @(xt) N(xt) / Aaxel(z(xt)) + Mtot(xt) / Wb(z(xt));        %Maxsp�nningen i axeln
    Tmax = @(xt) Mx(xt) / Wv(z(xt));                               %Max skjuvsp�nning        
    VM = @(xt) sqrt(Smax(xt)^2 + 3*Tmax(xt)^2);

    %% Ber�kning av lokala sp�nningskoncentrationer vid �verg�ngar samt best�mning av axeldiameter D
    SSmax = SMmax / ns;                                 %Maximal sp�nning som f�r uppst� i materialet, inr�knat s�kerhetsfaktor ns.
    D = 0.001;
    d = 0.6*D;
    KN = 1.6;                                           %Se F.S. 32.4
    KM = 1.53;                                          %Se F.S. 32.5
    KMx = 1.3;                                          %Se F.S. 32.5
    SmaxN = @(x, d) KN*double(4*N(x)/(pi*d^2));
    SmaxM = @(x, d) KM*double(32*Mtot(x)/(pi*d^3));
    SmaxMx = @(x, d) KMx*double(16*Mx(x)/(pi*d^3));
    
    while true
        SmaxN1 = KN*SnomN(b1, d);
        SmaxM1 = KM*SnomM(b1, d);
        SmaxMx1 = KMx*SnomMx(b1, d);
        
        SmaxN2 = KN*SnomN(L-b1, d);
        SmaxM2 = KM*SnomM(L-b1, d);
        SmaxMx2 = KMx*SnomMx(L-b1, d);
        
        SmaxNd = KN*SnomN(L/2+bd, d);
        SmaxMd = KM*SnomM(L/2+bd, d);
        SmaxMxd = KMx*SnomMx(L/2+bd, d);
        
        SmaxNb = KN*SnomN(L/2-bd, d);
        SmaxMb = KM*SnomM(L/2-bd, d);
        SmaxMxb = KMx*SnomMx(L/2-bd, d);
        
        if SSmax > abs(SmaxN1) && SSmax > abs(SmaxM1) && SSmax > abs(SmaxMx1) && SSmax > abs(SmaxN2) && SSmax > abs(SmaxM2) && SSmax > abs(SmaxMx2) && SSmax > abs(SmaxNd) && SSmax > abs(SmaxMd) && SSmax > abs(SmaxMxd) && SSmax > abs(SmaxNb) && SSmax > abs(SmaxMb) && SSmax > abs(SmaxMxb)
            break
        end
        D = D+0.001;
        d = 0.6*D;
    end
    disp([newline 'Slutgiltig n�dv�ndig diameter D f�r lastfall ' lastfall ': ' num2str(D*1000) ' mm.'])
    disp(['d: ' num2str(d*1000) ' mm.'])
    disp(['V�rde f�r grafer anges i Projekt_SE1010_variabler!' ])
fprintf('\nStr�ckgr�ns av material:   %g Pa\n\nNormalsp�nning vid b1:     %g Pa\nB�jmoment vid b1:          %g Pa\nVridmoment vid b1:         %g Pa\nNormalsp�nning vid L-b1:   %g Pa\nB�jmoment vid L-b1:        %g Pa\nVridmoment vid L-b1:       %g Pa\nNormalsp�nning vid L/2+bd: %g Pa\nB�jmoment vid L/2+bd:      %g Pa\nVridmoment vid L/2+bd:     %g Pa\nNormalsp�nning vid L/2-bb: %g Pa\nB�jmoment vid L/2-bb:      %g Pa\nVridmoment vid L/2-bb:     %g Pa\n\n ',SSmax,SmaxN1,SmaxM1,SmaxMx1,SmaxN2,SmaxM2,SmaxMx2,SmaxNd,SmaxMd,SmaxMxd,SmaxNb,SmaxMb,SmaxMxb)
%% UTMATTNING; reduktion av utmattningsdata figur 163 GH s.255 Ex. 43 s.259 GH
% Materialval Tab. 33.1 s.386 i FS , #7 SIS-141650-01
Rm  = 590; %MPa Brottgr�ns
Su  = 200; %+-200MPa sigma u, betecknar utmattningsgr�nsen vid v�xlande drag/tryck
Sup = 180; %180+-180MPa sigma up, betecknar utmattningsgr�nsen vid pulserande drag eller tryck
Subp = 240; %240+-240MPa sigma ubp, betecknar utmattningsgr�nsen vid pulserande b�jning
Ss  = 310; %sigma s >310 MPa Str�ckgr�ns
%KN = 1.65;       %Sp�nningskoncentrationsfaktorn, drag figur 159b GH s.252
%KM = 1.45;       %Sp�nningskoncentrationsfaktorn, b�j figur 159c GH s.252
q   = 0.85;        %K�lk�nslighetsfaktorn Figur 160 GH s.252

lambda = 1;%Teknologisk dimensionsfaktor. Axel ej gjuten figur 163 GH s.255
Kfd = 1 + q*(KN-1);  %Anvisningsfaktorn drag Ekv.(13-12) GH s.252
Kfb = 1 + q*(KM-1);  %Anvisningsfaktorn b�j Ekv.(13-12) GH s.252
Kd = 1;             %Geometriska volymsfaktorn figur 163 GH s.255
Kr = 1/0.975;   %Ra = 0.8my m enligt Ytfinhet wiki turning, figur 162b GH s.254

redfd = lambda/(Kfd*Kd*Kr); %reduktionsfaktor drag
redfb = lambda/(Kfb*Kd*Kr); %reduktionsfaktor drag Blir v�ldigt lika
redf = redfd
%Kdd = 1/0.96; %Geometriska volymsfaktorn figur 161 GH s.253
%KdD = 1/0.925

Haigh(x) = piecewise(0<=x<Sup, Su+((Sup-Su)/Sup)*x, Sup<=x<=Rm, Sup+(Sup/(Rm-Sup))*Sup+(Sup/(Sup-Rm))*x);
redSu = Su*redf;
redSup = Sup*redf;
redHaigh(x) = piecewise(0<=x<Sup, redSu+((redSup-redSu)/Sup)*x, Sup<=x<=Rm, redSup+(redSup/(Rm-Sup))*Sup+(redSup/(Sup-Rm))*x);
LSs = @(x) Ss-x %Linjen sigma s

figure
fplot(Haigh,[0 Rm])
xlabel('Sigma m [MPa]')
ylabel('Sigma a [MPa]')
title('Haighdiagram')
grid on
axis equal
hold on
fplot(redHaigh,[0 Rm])

fplot(LSs, [0 Ss])
legend('Haighdiagram','Reducerat Haighdiagram (Arbetslinje)','Sigma s')

%Mittsp�nning och amplitud GH s.245 Nominella sp�nningar
Sm = 0; %(Smax + smin)/2 %mittsp�nning sigma m = 0 vid rent v�xlande sp�nning
Sa = SnomM; %S(Smax - Smin)/2 %sp�nningsamplitud sigma a
R = -1; %Sp�nningsf�rh�llande 
% OB = n*OA Belastningslinjen ligger p� y-axeln
%% PLOTTAR
close all

figure('Name',['Moment XZ-planet runt Y - Lastfall ' lastfall]);
fplot(My,[0 L]);
%legend("Moment XZ-planet runt Y")
xlabel('Position l�ngs X-axeln [m]')
ylabel('Moment [Nm]')
title(['Moment XZ-planet runt Y - Lastfall ' lastfall])
grid on

figure('Name',['Moment XY-planet runt Z - Lastfall ' lastfall]);
fplot(Mz,[0 L]);
%legend("Moment XY-planet runt Z")
xlabel('Position l�ngs X-axeln [m]')
ylabel('Moment [Nm]')
title(['Moment XY-planet runt Z - Lastfall ' lastfall])
grid on

figure('Name',['Moment YZ-planet runt X - Lastfall ' lastfall]);
fplot(Mx,[0 L]);
%legend("Moment YZ-planet runt X")
xlabel('Position l�ngs X-axeln [m]')
ylabel('Moment [Nm]')
title(['Moment YZ-planet runt X - Lastfall ' lastfall])
grid on

figure('Name',['Tv�rsp�nning Z-axeln - Lastfall ' lastfall]);
fplot(Tz,[0 L]);
%legend("Tv�rsp�nning Z-axeln")
xlabel('Position l�ngs X-axeln [m]')
ylabel('Tryck [Pa]')
title(['Tv�rsp�nning Z-axeln - Lastfall ' lastfall])
grid on

figure('Name',['Tv�rsp�nning Y-axeln - Lastfall ' lastfall]);
fplot(Ty,[0 L]);
%legend("Tv�rsp�nning Y-axeln")
xlabel('Position l�ngs X-axeln [m]')
ylabel('Tryck [Pa]')
title(['Tv�rsp�nning Y-axeln - Lastfall ' lastfall])
grid on

figure('Name',['Normalkraft mot YZ-planet - Lastfall ' lastfall]);
fplot(N,[0 L]);
%legend("Normalkraft mot YZ-planet")
xlabel('Position l�ngs X-axeln [m]')
ylabel('Kraft [N]')
title(['Normalkraft mot YZ-planet - Lastfall ' lastfall])
grid on

VMt = [];
for i = 0:0.01:L
   VMt = [VMt VM(i)]; 
end
figure('Name',['Von Mises - Lastfall ' lastfall]);
plot(0:0.01:L,VMt)
%fplot(VM,[0 L]);
%legend("Von Mises")
xlabel('Position l�ngs X-axeln [m]')
ylabel('Moment [Nm] / Kraft [N]')
title(['Von Mises - Lastfall ' lastfall])
grid on