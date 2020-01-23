%{
Hållfasthetslära SE1010 Projektuppgift
Beräkning av lokala spänningskoncentrationer vid övergångar
samt bestämning av axeldiameter D

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
%% ------------LOKALA SPÄNNINGSKONCENTRATIONER------------
%OBS! Beräknas efter D i variabellistan

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
SSmax = Ss / ns;                                 %Maximal spänning som får uppstå i materialet, inräknat säkerhetsfaktor ns.
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
disp([newline 'Nödvändig diameter D för maxstress lastfall ' lastfall ': ' num2str(D*1000) ' mm.'])
disp(['d: ' num2str(d*1000) ' mm.'])
disp(['Värde för grafer anges i Projekt_SE1010_variabler!' ])
fprintf('\nSpänningar blir då:\nSträckgräns av material:   %g Pa\n\nMaxspänning vid b1:     %g Pa\nMaxspänning vid L/2-bb: %g Pa\nMaxspänning vid L/2+bd: %g Pa\nMaxspänning vid L-b1:   %g Pa\n\n ',SSmax,VMx(b1),VMx(L/2-bb),VMx(L/2+bd),VMx(L-b1))
