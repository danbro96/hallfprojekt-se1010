%{
Hållfasthetslära SE1010 Projektuppgift
Snittning
https://github.com/danbro96/hallfprojekt-se1010

2019-12-06
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
x = 0:0.001:L;
Snitt = zeros(8, length(x));
Snitt(1,:) = x;
SP = [b1 L/2-bb L/2+bd L-b1 L];         %Snittpunkter
%XZ-plan runt Y

%{
Snitt(1,:) = X-koordinater
Snitt(2,:) = Moment XZ-planet
Snitt(3,:) = Moment XY-planet
Snitt(4,:) = Moment YZ-planet
Snitt(5,:) = Tvärspänning Z-axeln
Snitt(6,:) = Tvärspänning Y-axeln
Snitt(7,:) = Normalspänning X-axeln
Snitt(8,:) = Von Mises
%}

%------------------------------------------------------
%0 =< x < b1
T1 = @() -Vbi;                          %Tvärspänning Z-axeln
M1 = @(x) -Vbi * x - Hbi * rh;          %Moment XZ-planet

%b1 =< x < L/2-bb
T2 = @() Vli + T1();                    %Tvärspänning Z-axeln
M2 = @(x) M1(x) + Vli * (x-b1);         %Moment XZ-planet

%L/2-bb =< x < L-b1
T3 = @() -Fb + T2();                    %Tvärspänning Z-axeln
M3 = @(x) M2(x) - Fb * (x-(L/2-bb));    %Moment XZ-planet

%L-b1 =< x < L
T4 = @() Vly + T3();                    %Tvärspänning Z-axeln
M4 = @(x) M3(x) + Vly * (x-(L-b1));     %Moment XZ-planet

%------------------------------------------------------
%0 =< x < b1
T5 = @() -Fd/2;                         %Tvärspänning Y-axeln
M5 = @(x) -Fd/2 * x;                    %Moment XY-planet

%b1 =< x < L/2+bd
T6 = @() Fli + T5();                    %Tvärspänning Y-axeln
M6 = @(x) M5(x) + Fli * (x-b1);         %Moment XY-planet

%L/2-bd =< x < L-b1
T7 = @() -Fk + T6();                    %Tvärspänning Y-axeln
M7 = @(x) M6(x) - Fk * (x-(L/2+bd));    %Moment XY-planet

%L-b1 =< x < L
T8 = @() Fly + T7();                    %Tvärspänning Y-axeln
M8 = @(x) M7(x) + Fly * (x-(L-b1));     %Moment XY-planet

%------------------------------------------------------
%0 =< x < L/2-bb
M9 = @() -Fd/2*rh;                      %Moment YZ-planet

%L/2-bb =< x < L/2+bd
M10 = @() Fb*rb + M9();                 %Moment YZ-planet

%L/2+bd =< x < L
M11 = @() Fk*rd + M10();                %Moment YZ-planet

%------------------------------------------------------
%0 =< x < b1
T9 = @() Hbi;                           %Normalkraft i X-axeln

%b1 =< x < L
T10 = @() -Hli + T9();                  %Normalkraft i X-axeln
%------------------------------------------------------


for i=1:length(Snitt)
    %--------MOMENT XY-PLANET & TVÄRSPÄNNING Z-AXELN------
    if Snitt(1,i) < b1                      %Snitt fram till inre hjullager
        Snitt(2,i) = M1(Snitt(1,i));
        Snitt(5,i) = T1();
        
    elseif Snitt(1,i) < L/2-bb              %Snitt fram till bromsskiva
        Snitt(2,i) = M2(Snitt(1,i));
        Snitt(5,i) = T2();
        
    elseif Snitt(1,i) < L-b1                %Snitt fram till yttre hjullager
        Snitt(2,i) = M3(Snitt(1,i));
        Snitt(5,i) = T3();
        
    elseif Snitt(1,i) <= L                  %Snitt fram till axelns slut
        Snitt(2,i) = M4(Snitt(1,i));
        Snitt(5,i) = T4();
        
    end
    
    %--------MOMENT XY-PLANET & TVÄRSPÄNNING Y-AXELN------
    if Snitt(1,i) < b1                      %Snitt fram till inre hjullager
        Snitt(3,i) = -M5(Snitt(1,i));
        Snitt(6,i) = T5();
        
    elseif Snitt(1,i) < L/2+bd              %Snitt fram till drev
        Snitt(3,i) = -M6(Snitt(1,i));
        Snitt(6,i) = T6();
        
    elseif Snitt(1,i) < L-b1                %Snitt fram till yttre hjullager
        Snitt(3,i) = -M7(Snitt(1,i));
        Snitt(6,i) = T7();
        
    elseif Snitt(1,i) <= L                  %Snitt fram till axelns slut
        Snitt(3,i) = -M8(Snitt(1,i));
        Snitt(6,i) = T8();
        
    end
    
    %--------MOMENT YZ-PLANET------
    if Snitt(1,i) < L/2-bb                  %Snitt fram till bromsskiva
        Snitt(4,i) = M9();
        
    elseif Snitt(1,i) < L/2+bd              %Snitt fram till yttre hjullager
        Snitt(4,i) = M10();
        
    elseif Snitt(1,i) <= L                  %Snitt fram till axelns slut
        Snitt(4,i) = M11();
        
    end
    
    
    
    %--------NORMALKRAFT I X-AXELN------
    if Snitt(1,i) < b1                      %Snitt fram till inre hjullager
        Snitt(7,i) = T9();
        
    elseif Snitt(1,i) <= L                  %Snitt fram till axelns slut
        Snitt(7,i) = T10();
    end
    
    %-----Beräkning av axeldiameter D & d-------
    D = * ns;
    
    %------------VON MISES------------
  syms x
y = piecewise(x<0, -1, x>0, 1)

    if Snitt(1,i) <= b1
        z = d/2;
    elseif Snitt(1,i) < L-b1
        z = D/2;
    else
        z = d/2;
    end
    %Wb = pi*z^3/32;                 %Se FS 6.9      %Böjmotstånd
    %Wv = pi*z^3/16;                 %Se FS 6.78     %Vridmotstånd
    
    I = pi*z^4/4;                                   %Areatröthetsmoment     Se FS 30.1.3
    Wb = I/abs(z);                                  %Böjmotstånd            Se G.L. S79 
    Wv = pi*z^3/2;                                  %Vridmotstånd           Se FS 6.78
   
    Aaxel = z^2*pi;                                 %Axel tvärsnittsarea
    Mtot = sqrt(Snitt(2,i)^2 + Snitt(3,i)^2);       %Sammansatt böjmoment
    Smax = Snitt(7,i) / Aaxel + Mtot / Wb;          %Maxspänningen i axeln
    Tmax = Snitt(4,i) / Wv;                         %Max skjuvspänning        
    
    %kolla kap 32.2 nominell*kt
    %{
qn1 = Wb - (pi*d^3)/32 == 0;
qn2 = Wv - (pi*d^3)/16 == 0;
qn3 = Sigma_max - M_tot/Wb == 0;
qn4 = t_max - Mv/Wv == 0;
qn5 = Sigma_eff - sqrt(abs((Sigma_max)^2+3*(t_max)^2)) == 0;
%}
    %Snitt(8,i) = (sigmay^2 + sigmaz^2 + Smax^2 + sigmay*sigmaz + sigmay*sigmax + sigmaz*sigmax + 3*Tmax^2 + 3*tauy^2 + 3*tauz^2)^0.5;
    Snitt(8,i) = sqrt(Smax^2 + 3*Tmax^2);

    
end
%% PLOT
close all
leg = ["Moment XZ-planet runt Y", "Moment XY-planet runt Z","Moment YZ-planet runt X","Tvärspänning Z-axeln", "Tvärspänning Y-axeln", "Normalkraft mot YZ-planet", "Von Mises"];
for i = 2:(size(Snitt,1))
    figure
    plot(Snitt(1,:), Snitt(i,:), '-.')
    %legend(leg(i-1))
    xlabel('Position längs X-axeln [m]')
    ylabel('Moment [Nm] / Kraft [N]')
    title([leg(i-1) [' Lastfall ' lastfall]])
    grid on
    
end