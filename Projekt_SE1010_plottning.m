%{
Hållfasthetslära SE1010 Projektuppgift
Plottning
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
close all

figure('Name',['Moment XZ-planet runt Y - Lastfall ' lastfall]);
fplot(My,[0 L]);
%legend("Moment XZ-planet runt Y")
xlabel('Position längs X-axeln [m]')
ylabel('Moment [Nm]')
title(['Moment XZ-planet runt Y - Lastfall ' lastfall])
grid on

figure('Name',['Moment XY-planet runt Z - Lastfall ' lastfall]);
fplot(Mz,[0 L]);
%legend("Moment XY-planet runt Z")
xlabel('Position längs X-axeln [m]')
ylabel('Moment [Nm]')
title(['Moment XY-planet runt Z - Lastfall ' lastfall])
grid on

figure('Name',['Moment YZ-planet runt X - Lastfall ' lastfall]);
fplot(Mx,[0 L]);
%legend("Moment YZ-planet runt X")
xlabel('Position längs X-axeln [m]')
ylabel('Moment [Nm]')
title(['Moment YZ-planet runt X - Lastfall ' lastfall])
grid on

figure('Name',['Tvärspänning Z-axeln - Lastfall ' lastfall]);
fplot(Tz,[0 L]);
%legend("Tvärspänning Z-axeln")
xlabel('Position längs X-axeln [m]')
ylabel('Tryck [Pa]')
title(['Tvärspänning Z-axeln - Lastfall ' lastfall])
grid on

figure('Name',['Tvärspänning Y-axeln - Lastfall ' lastfall]);
fplot(Ty,[0 L]);
%legend("Tvärspänning Y-axeln")
xlabel('Position längs X-axeln [m]')
ylabel('Tryck [Pa]')
title(['Tvärspänning Y-axeln - Lastfall ' lastfall])
grid on

figure('Name',['Normalkraft mot YZ-planet - Lastfall ' lastfall]);
fplot(N,[0 L]);
%legend("Normalkraft mot YZ-planet")
xlabel('Position längs X-axeln [m]')
ylabel('Kraft [N]')
title(['Normalkraft mot YZ-planet - Lastfall ' lastfall])
grid on

VMt = [];
for i = 0:0.01:L
    VMt = [VMt VM(i)];
end
figure('Name',['Von Mises - Lastfall ' lastfall]);
plot(0:0.01:L,VMt)

hold on
plot([0 L],[Ss/nu Ss/nu], 'g') 

plot(b1, VMx(b1),'r*')
plot(L/2-bb, VMx(L/2-bb),'r*')
plot(L/2+bd, VMx(L/2+bd),'r*')
plot(L-b1, VMx(L-b1),'r*')
hold off

%fplot(VM,[0 L]);
legend(['D = ' num2str(D) ' m'], 'Sträckgräns med säkerhetsfaktor för material', 'Lokala spänningskoncentrationer','Location','southoutside')
xlabel('Position längs X-axeln [m]')
ylabel('Moment [Nm] / Kraft [N]')
title(['Von Mises - Lastfall ' lastfall])
grid on