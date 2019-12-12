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
    KN = 1.45;                                          %Se F.S. 32.4 & 32.5
    KM = 1.35;
    KMx = 1.2;
    SnomN = @(x, d) double(4*N(x)/(pi*d^2));
    SnomM = @(x, d) double(32*Mtot(x)/(pi*d^3));
    SnomMx = @(x, d) double(16*Mx(x)/(pi*d^3));
    
    while true
        SmaxN1 = KN*SnomN(b1, d);
        SmaxM1 = KM*SnomM(b1, d);
        SmaxMx1 = KMx*SnomMx(b1, d);
        
        SmaxN2 = KN*SnomN(L-b1, d);
        SmaxM2 = KM*SnomM(L-b1, d);
        SmaxMx2 = KMx*SnomMx(L-b1, d);
        if SSmax > SmaxN1 && SSmax > SmaxM1 && SSmax > SmaxMx1 && SSmax > SmaxN2 && SSmax > SmaxM2 && SSmax > SmaxMx2
            break
        end
        D = D+0.001;
        d = 0.6*D;
    end
    disp([newline 'Slutgiltig n�dv�ndig diameter D f�r lastfall ' lastfall ': ' num2str(D*1000) ' mm.'])
    disp(['d: ' num2str(d*1000) ' mm.'])
    disp(['V�rde f�r grafer anges i Projekt_SE1010_variabler!'])

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
