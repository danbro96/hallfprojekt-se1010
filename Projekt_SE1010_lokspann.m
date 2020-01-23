%{
H�llfasthetsl�ra SE1010 Projektuppgift
Ber�kning av lokala sp�nningskoncentrationer vid �verg�ngar
samt best�mning av axeldiameter D

https://github.com/danbro96/hallfprojekt-se1010

2019-12-17
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
%% ------------LOKALA SP�NNINGSKONCENTRATIONER------------
%OBS! Ber�knas efter D i variabellistan

KN(x) = piecewise(x*2 == d, KN1, x*2 == D, KN2);
KM(x) = piecewise(x*2 == d, KM1, x*2 == D, KM2);
KMx(x) = piecewise(x*2 == d, KMx1, x*2 == D, KMx2);

SmaxN = @(x) KN(z(x))*N(x);
SmaxM = @(x) KM(z(x))*Mtot(x);
SmaxMx = @(x) KMx(z(x))*Mx(x);

Smaxx = @(x) SmaxN(x)/Aaxel(z(x)) + SmaxM(x)/ Wb(z(x));
Tmaxx = @(x) SmaxMx(x) / Wv(z(x));
VMx = @(x) sqrt(Smaxx(x)^2 + 3*Tmaxx(x)^2);

%%
%OBS! Dimensionerar till passande diameter D
SSmax = Ss / ns;                                 %Maximal sp�nning som f�r uppst� i materialet, inr�knat s�kerhetsfaktor ns.
D = 0.001;
d = 0.6*D;

%Smax = K*Snom

while true
    z(x) = piecewise(0 < x <= b1, d/2, b1 < x < L-b1, D/2, L-b1 <= x < L, d/2);

    KN(x) = piecewise(x*2 == d, KN1, x*2 == D, KN2);
    KM(x) = piecewise(x*2 == d, KM1, x*2 == D, KM2);
    KMx(x) = piecewise(x*2 == d, KMx1, x*2 == D, KMx2);
    
    SmaxN = @(x) KN(z(x))*N(x);
    SmaxM = @(x) KM(z(x))*Mtot(x);
    SmaxMx = @(x) KMx(z(x))*Mx(x);
    
    Smaxx = @(x) SmaxN(x)/Aaxel(z(x)) + SmaxM(x)/ Wb(z(x));
    Tmaxx = @(x) SmaxMx(x) / Wv(z(x));
    VMx = @(x) sqrt(Smaxx(x)^2 + 3*Tmaxx(x)^2);
    
    if SSmax > abs(VMx(b1)) && SSmax > abs(VMx(L/2-bb)) && SSmax > abs(VMx(L/2+bd)) && SSmax > abs(VMx(L-b1))
        break
    end
    D = D+0.001;
    d = 0.6*D;
end

%%
disp([newline 'N�dv�ndig diameter D f�r maxstress lastfall ' lastfall ': ' num2str(D*1000) ' mm.'])
disp(['d: ' num2str(d*1000) ' mm.'])
disp(['V�rde f�r grafer anges i Projekt_SE1010_variabler!' ])
fprintf('\nSp�nningar blir d�:\nStr�ckgr�ns av material:   %g Pa\n\nMaxsp�nning vid b1:     %g Pa\nMaxsp�nning vid L/2-bb: %g Pa\nMaxsp�nning vid L/2+bd: %g Pa\nMaxsp�nning vid L-b1:   %g Pa\n\n ',SSmax,VMx(b1),VMx(L/2-bb),VMx(L/2+bd),VMx(L-b1))
