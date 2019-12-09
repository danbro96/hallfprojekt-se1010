%{
Hållfasthetslära SE1010 Projektuppgift
Del 1, jämviktsberäkningar
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

%---------------------------------------------
%Problemlösning:
%---------------------------------------------
vt = v0 + a*t;                               %Hastighet v som funktion av tid

Fl = 1/2 * pluft * c * A * vt^2;             %Kraft som uppkommer pga luftmotstånd

Fc = m * vt^2 / R0;                          %Centrifugalkraft som verkar vid masscentrum

%%  ---------------------------------------------
   %Uträknande av fordonets yttre krafter
   %---------------------------------------------
%Jämviktsekvationer, Moment runt masscentrum
%{
syms Hf Hbi Hby Vf Vbi Vby Fd

   ekv1 =   Fc - Hbi - Hby - Hf == 0                                    %(1)Kraftjämvikt längs med x-axeln
   ekv2 =   Fd - Fl == m * a                                            %(2)Kraftjämvikt längs med y-axeln.
   ekv3 =   Vf + Vbi + Vby - m*g == 0                                   %(3)Kraftjämvikt längs med z-axeln. 
   ekv4 =   Vf * df + Fl * h1 + Fd * h - Vbi * db - Vby * db == 0       %(4)Momentjämvikt runt x-axeln
   ekv5 =   Vbi * L/2 - Vby * L/2 + (Hbi+Hby+Hf) * h == 0               %(5)Momentjämvikt runt y-axeln
%       Hf * df - (Hbi+Hby) * db + Fd/2 * L/2 - Fd/2 * L/2 = 0
   ekv6 =   Hf * df - (Hbi+Hby) * db == 0                               %(6)Momentjämvikt runt z-axeln
   ekv7 =   Hbi / Hby == Vbi / Vby                                      %(7)Friktionsförhållande givet i uppgiften

%---------------------------------------------

s = solve([ekv1, ekv3, ekv4, ekv5, ekv6, ekv7], [Hf, Hbi, Hby, Vf, Vbi, Vby]);
Hbi = getfield(s,'Hbi');
Hby = getfield(s,'Hby');
Hf  = getfield(s,'Hf');
Vbi = getfield(s,'Vbi');
Vby = getfield(s,'Vby');
Vf  = getfield(s,'Vf');

%Nedan approximerar bråken som ges av ovan.

Vbi = vpa(Vbi)
Vby = vpa(Vby)
Vf  = vpa(Vf)
Hbi = vpa(Hbi)
Hby = vpa(Hby)
Hf  = vpa(Hf)
FD
%}
 
%{
-1  *Hf +   -1      *Hbi +      -1      *Hby +      0	*Vf +	0       *Vbi +      0       *Vby +      0	*Fd = -Fc
0   *Hf +   0       *Hbi +      0       *Hby +      0   *Vf +   0       *Vbi +      0       *Vby +      1   *Fd = Fl + m*a
0   *Hf +   0       *Hbi +      0       *Hby +      1   *Vf +   1       *Vbi +      1       *Vby +      0   *Fd = m*g
0   *Hf +   0       *Hbi +      0       *Hby +      df  *Vf +   -db     *Vbi +      -db     *Vby +      h   *Fd = -Fl*h1
h   *Hf +   h       *Hbi +      h       *Hby +      0   *Vf +   L/2     *Vbi +      -L/2    *Vby +      0   *Fd = 0
df  *Hf +   -db     *Hbi +      -db     *Hby +      0   *Vf +   0       *Vbi +      0       *Vby +      0   *Fd = 0

Hbi / Hby = Vbi / Vby   

Sökes: Hf, Hbi, Hby, Vf, Vbi, Vby, Fd
%}

%Linalg-shit ger:
Hf  = Fc/(1+df/db);
Vf  = (-Fl*h1 + db*m*g - h*(Fl + m*a)) / (df + db);
Vby = m*g/2 + Fc*h/L - Vf/2;
Vbi = -Fc*h*2/L+ Vby;

Hby = Hf*df/db/(Vbi/Vby+1);
Hbi = Hf*df/db/(Vby/Vbi+1); 
Fd  = Fl + m*a;





%%  ---------------------------------------------
   %Friläggning av bakaxeln
   %---------------------------------------------
   
%Bestämning om bromsskiva eller drev behöver användas. Endast en används åt
%gången och ska därför motsätta momentet som uppstår av Fd.
if (Fd * rh < 0)
    Fk = 0;
    Fb = -Fd * rh/rb;
else
    Fk = Fd * rh/rd;
    Fb = 0;
end

%Jämviktsekvationer, Moment runt axelns mittpunkt
%{
syms Vly Vli Fly Fli Hli

   ekv8  =   Hli - Hbi - Hby == 0                                                                	%(8)Kraftjämvikt längs med x-axeln
   ekv9  =   - Fli - Fly + Fk + 2 * Fd/2 == 0                                                       %(9)Kraftjämvikt längs med y-axeln.
   ekv10 =   Vbi + Vby - Vli - Vly + Fb == 0                                                        %(10)Kraftjämvikt längs med z-axeln. 
   ekv11 =   2 * Fd/2 * rh - Fk * rd + Fb * rb == 0                                                 %(11)Momentjämvikt runt x-axeln
   ekv12 =   Vbi * L/2 - Vby * L/2 - Vli * (L/2-b1)+ Vly * (L/2-b1) + Fb * bb + (Hbi+Hby) * rh == 0 %(12)Momentjämvikt runt y-axeln
   ekv13 =   Fk * bd - Fly * (L/2-b1) + Fli * (L/2-b1) + Fd/2 * L/2 - Fd/2 * L/2 == 0               %(13)Momentjämvikt runt z-axeln

%---------------------------------------------
%Sökes: Vly, Vli, Fly, Fli, Hli

s = solve([ekv8, ekv9, ekv10, ekv11, ekv12, ekv13], [Vly, Vli, Fly, Fli, Hli]);
Vly = getfield(s,'Vly');
Vli = getfield(s,'Vli');
Fly  = getfield(s,'Fly');
Fli = getfield(s,'Fli');
Hli = getfield(s,'Hli');

%Nedan approximerar bråken som ges av ovan.

Vly = vpa(Vly)
Vli = vpa(Vli)
Fly = vpa(Fly)
Fli = vpa(Fli)
Hli = vpa(Hli)
%}

Hli = Hbi + Hby;

%{
0           *Vli +      0           *Vly +      1               *Fli +      1           *Fly = Fk + Fd
-1          *Vli +      -1          *Vly +      0               *Fli +      0           *Fly = - Vbi - Vby - Fb
-(L/2-b1)   *Vli +      (L/2-b1)    *Vly +      0               *Fli +      0           *Fly = -Vbi * L/2 + Vby * L/2 - (Hbi+Hby) * rh - Fb * bb
0           *Vli +      0           *Vly +      (L/2-b1)        *Fli +      -(L/2-b1)	*Fly = - Fk * bd



%Sökes: Vli, Vly, Fli, Fly

Vly = -Vli + Vbi + Vby + Fb

-(L/2-b1)*Vli +(L/2-b1)*Vly = -Vbi * L/2 + Vby * L/2 - (Hbi+Hby) * rh - Fb * bb
-(L/2-b1)*Vli +(L/2-b1)*(-Vli + Vbi + Vby + Fb) = -Vbi * L/2 + Vby * L/2 - (Hbi+Hby) * rh - Fb * bb
-(L/2-b1)*Vli -(L/2-b1)*Vli  = -Vbi * L/2 + Vby * L/2 - (Hbi+Hby) * rh - Fb * bb - (L/2-b1)*(Vbi + Vby + Fb)
%}

Vli = (-Vbi * L/2 + Vby * L/2 - (Hbi+Hby) * rh  - Fb * bb - (L/2-b1)*(Vbi + Vby + Fb))/(-2*(L/2-b1));
Vly = -Vli + Vbi + Vby + Fb;

%{
Fli = Fk + Fd - Fly

(L/2-b1) *Fli -(L/2-b1)	*Fly = - Fk * bd
(L/2-b1) *(Fk + Fd - Fly) -(L/2-b1)	*Fly = - Fk * bd

%}
Fly = (- Fk * bd - (L/2-b1) *(Fk + Fd))/(- 2*(L/2-b1));
Fli = Fk + Fd - Fly;
%%
disp('Yttre belastningar')
fprintf(' Vbi = %g N\n Vby = %g N\n Vf = %g N\n Hbi = %g N\n Hby = %g N\n Hf = %g N\n Fd = %g N\n\n ',Vbi,Vby,Vf,Hbi,Hby,Hf,Fd)
disp('Inre krafter')
fprintf(' Fk = %g N\n Fb = %g N\n Vli = %g N\n Vly = %g N\n Hli = %g N\n Fli = %g N\n Fly = %g N\n',Fk,Fb,Vli,Vly,Hli,Fli,Fly)
