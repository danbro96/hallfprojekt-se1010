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

% Materialval Tab. 33.1 s.386 i FS , #7 SIS-141650-01
Rm  = 590; %MPa Brottgräns
Su  = 200; %+-200MPa sigma u, betecknar utmattningsgränsen vid växlande drag/tryck
Sup = 180; %180+-180MPa sigma up, betecknar utmattningsgränsen vid pulserande drag eller tryck
Subp = 240; %240+-240MPa sigma ubp, betecknar utmattningsgränsen vid pulserande böjning
Ss  = 310; %sigma s >310 MPa Sträckgräns
%KN = 1.65;       %Spänningskoncentrationsfaktorn, drag figur 159b GH s.252
%KM = 1.45;       %Spänningskoncentrationsfaktorn, böj figur 159c GH s.252
q   = 0.85;        %Kälkänslighetsfaktorn Figur 160 GH s.252

lambda = 1;%Teknologisk dimensionsfaktor. Axel ej gjuten figur 163 GH s.255
Kfd = 1 + q*(KN-1);  %Anvisningsfaktorn drag Ekv.(13-12) GH s.252
Kfb = 1 + q*(KM-1);  %Anvisningsfaktorn böj Ekv.(13-12) GH s.252
Kd = 1;             %Geometriska volymsfaktorn figur 163 GH s.255
Kr = 1/0.975;   %Ra = 0.8my m enligt Ytfinhet wiki turning, figur 162b GH s.254

redfd = lambda/(Kfd*Kd*Kr); %reduktionsfaktor drag
redfb = lambda/(Kfb*Kd*Kr); %reduktionsfaktor drag Blir väldigt lika
%redf = redfd;
%Kdd = 1/0.96; %Geometriska volymsfaktorn figur 161 GH s.253
%KdD = 1/0.925

Haigh(x) = piecewise(0<=x<Sup, Su+((Sup-Su)/Sup)*x, Sup<=x<=Rm, Sup+(Sup/(Rm-Sup))*Sup+(Sup/(Sup-Rm))*x);
redSu = Su*redfd;
redSup = Sup*redfd;
redHaigh(x) = piecewise(0<=x<Sup, redSu+((redSup-redSu)/Sup)*x, Sup<=x<=Rm, redSup+(redSup/(Rm-Sup))*Sup+(redSup/(Sup-Rm))*x);
LSs = @(x) Ss-x; %Linjen sigma s

figure
fplot(Haigh/nu,[0 Rm])
xlabel('Sigma m [MPa]')
ylabel('Sigma a [MPa]')
title('Haighdiagram Drag')
grid on
axis equal
hold on
fplot(redHaigh/nu,[0 Rm])
fplot(LSs, [0 Ss])
legend('Haighdiagram','Reducerat Haighdiagram (Arbetslinje)','Sigma s')




redSu = Su*redfb;
redSup = Sup*redfb;
redHaigh(x) = piecewise(0<=x<Sup, redSu+((redSup-redSu)/Sup)*x, Sup<=x<=Rm, redSup+(redSup/(Rm-Sup))*Sup+(redSup/(Sup-Rm))*x);
LSs = @(x) Ss-x; %Linjen sigma s

figure
fplot(Haigh/nu,[0 Rm])
xlabel('Sigma m [MPa]')
ylabel('Sigma a [MPa]')
title('Haighdiagram Böj')
grid on
axis equal
hold on
fplot(redHaigh/nu,[0 Rm])
fplot(LSs, [0 Ss])
legend('Haighdiagram','Reducerat Haighdiagram (Arbetslinje)','Sigma s')

%Mittspänning och amplitud GH s.245 Nominella spänningar
Sm = 0; %(Smax + smin)/2 %mittspänning sigma m = 0 vid rent växlande spänning
%Sa = SnomM; %S(Smax - Smin)/2 %spänningsamplitud sigma a
R = -1; %Spänningsförhållande
% OB = n*OA Belastningslinjen ligger på y-axeln