%{
H�llfasthetsl�ra SE1010 Projektuppgift
Plottning
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
close all

figure('Name',['Moment XZ-planet runt Y - Lastfall ' lastfall]);
fplot(My,[0 L]);
%legend("Moment XZ-planet runt Y")
xlabel('X-koordinat l�ngs med bakaxeln [m]')
ylabel('Moment XZ-planet [Nm]')
title(['Moment XZ-planet runt Y - Lastfall ' lastfall])
grid on

figure('Name',['Moment XY-planet runt Z - Lastfall ' lastfall]);
fplot(Mz,[0 L]);
%legend("Moment XY-planet runt Z")
xlabel('X-koordinat l�ngs med bakaxeln [m]')
ylabel('Moment XY-planet [Nm]')
title(['Moment XY-planet runt Z - Lastfall ' lastfall])
grid on

figure('Name',['Moment YZ-planet runt X - Lastfall ' lastfall]);
fplot(Mx,[0 L]);
%legend("Moment YZ-planet runt X")
xlabel('X-koordinat l�ngs med bakaxeln [m]')
ylabel('Moment YZ-planet [Nm]')
title(['Moment YZ-planet runt X - Lastfall ' lastfall])
grid on

figure('Name',['Tv�rsp�nning Z-axeln - Lastfall ' lastfall]);
fplot(Tz,[0 L]);
%legend("Tv�rsp�nning Z-axeln")
xlabel('X-koordinat l�ngs med bakaxeln [m]')
ylabel('Tv�rsp�nning Z-axeln [Pa]')
title(['Tv�rsp�nning Z-axeln - Lastfall ' lastfall])
grid on

figure('Name',['Tv�rsp�nning Y-axeln - Lastfall ' lastfall]);
fplot(Ty,[0 L]);
%legend("Tv�rsp�nning Y-axeln")
xlabel('X-koordinat l�ngs med bakaxeln [m]')
ylabel('Tv�rsp�nning Y-axeln [Pa]')
title(['Tv�rsp�nning Y-axeln - Lastfall ' lastfall])
grid on

figure('Name',['Normalkraft mot YZ-planet - Lastfall ' lastfall]);
fplot(N,[0 L]);
%legend("Normalkraft mot YZ-planet")
xlabel('X-koordinat l�ngs med bakaxeln [m]')
ylabel('Normalkraft [Pa]')
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
legend(['D = ' num2str(D) ' m'], 'Str�ckgr�ns med s�kerhetsfaktor f�r material', 'Lokala sp�nningskoncentrationer','Location','southoutside')
xlabel('X-koordinat l�ngs med bakaxeln [m]')
ylabel('Sp�nning [Pa]')
title(['Von Mises Effektivsp�nning - Lastfall ' lastfall])
grid on


figure('Name',['B�jskjuvsp�nning - Lastfall ' lastfall]);
fplot(Tbmax,[0 L]);
%legend("B�jskjuvsp�nning")
xlabel('X-koordinat l�ngs med bakaxeln [m]')
ylabel('B�jskjuvsp�nning [Pa]')
title(['B�jskjuvsp�nning - Lastfall ' lastfall])
grid on

figure('Name',['Vridskjuvsp�nning - Lastfall ' lastfall]);
fplot(Tmax,[0 L]);
%legend("B�jskjuvsp�nning")
xlabel('X-koordinat l�ngs med bakaxeln [m]')
ylabel('Vridskjuvsp�nning [Pa]')
title(['Vridskjuvsp�nning - Lastfall ' lastfall])
grid on

figure('Name',['Skjuvsp�nningar - Lastfall ' lastfall]);
hold on
fplot(Tmax,[0 L]);
fplot(Tbmax,[0 L]);
legend("Vridskjuvsp�nning", "B�jskjuvsp�nning")
xlabel('X-koordinat l�ngs med bakaxeln [m]')
ylabel('Sp�nning [Pa]')
title(['Skjuvsp�nningar - Lastfall ' lastfall])
grid on
hold off
