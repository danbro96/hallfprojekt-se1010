%{
Hållfasthetslära SE1010 Projektuppgift
Utmattning via reduktion av utmattningsdata
Figur 163 GH s.255 Ex. 43 s.259 GH
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

%sigmaX = N/A+M/I*sin(v)


Kx = [KN1 KN2];                 %KN = drag, KM = böj
namn = {"Drag vid hjullager","Drag vid flänsar"};
for i = 1:length(Kx)
    i = 1;
    q   = 0.85;                             %Kälkänslighetsfaktorn Figur 160 GH s.252
    lambda = 1;                             %Teknologisk dimensionsfaktor. Axel ej gjuten figur 163 GH s.255
    Kf = 1 + q*(Kx(i)-1);                   %Anvisningsfaktorn drag Ekv.(13-12) GH s.252
    Kd = 1;                                 %Geometriska volymsfaktorn figur 163 GH s.255
    Kr = 1/0.975;                           %Ra = 0.8my m enligt Ytfinhet wiki turning, figur 162b GH s.254
    
    redf = lambda/(Kf*Kd*Kr);               %reduktionsfaktor drag
    %redf = redfd;
    %Kdd = 1/0.96;                          %Geometriska volymsfaktorn figur 161 GH s.253
    %KdD = 1/0.925
    
    Haigh(x) = piecewise(0<=x<Sup, Su+((Sup-Su)/Sup)*x, Sup<=x<=Rm, Sup+(Sup/(Rm-Sup))*Sup+(Sup/(Sup-Rm))*x);
    redSu = Su*redf;
    redSup = Sup*redf;
    %redSub = Sub*redf;
    redHaigh(x) = piecewise(0<=x<Sup, redSu+((redSup-redSu)/Sup)*x, Sup<=x<=Rm, redSup+(redSup/(Rm-Sup))*Sup+(redSup/(Sup-Rm))*x);
    LSs = @(x) Ss-x;                        %Linjen sigma s
    
    figure
    fplot(Haigh,[0 Rm])
    xlabel('Sigma m [Pa]')
    ylabel('Sigma a [Pa]')
    title(['Haighdiagram - ' namn(i)])
    grid on
    axis equal
    hold on
    fplot(redHaigh,[0 Rm])
    fplot(LSs, [0 Ss])
    legend('Haighdiagram','Reducerat Haighdiagram (Arbetslinje)','Sigma s')
    
    
    %Smax < redHaigh(0)/nu
    
    %Mtot = redSub/nu*Wb(b1)
    
    D = 0.001;
    d = 0.6*D;
    
    while true
        z(x) = piecewise(0 < x <= b1, d/2, b1 < x < L-b1, D/2, L-b1 <= x < L, d/2);
        Smax = @(xt) N(xt) / Aaxel(z(xt)) + Mtot(xt) / Wb(z(xt));       %Nominell maxspänningen i axeln
        if i == 1
            if Smax(b1) < redHaigh(Sup)/nu && Smax(L-b1) < redHaigh(Sup)/nu
                break
            end
        else
            if Smax(L/2-bb) < redHaigh(Sup)/nu && Smax(L/2+bd) < redHaigh(Sup)/nu
                break
            end
        end
        D = D + 0.001;
        d = 0.6*D;
    end
    
    disp([newline 'Nödvändig diameter D för utmattning lastfall ' lastfall ': ' num2str(D*1000) ' mm.'])
    disp(['d: ' num2str(d*1000) ' mm.'])
    disp(['Värde för grafer anges i Projekt_SE1010_variabler!' ])
end
%%
%Mittspänning och amplitud GH s.245 Nominella spänningar
Sm = 0; %(Smax + smin)/2 %mittspänning sigma m = 0 vid rent växlande spänning
%Sa = SnomM; %S(Smax - Smin)/2 %spänningsamplitud sigma a
R = -1; %Spänningsförhållande
% OB = n*OA Belastningslinjen ligger på y-axeln