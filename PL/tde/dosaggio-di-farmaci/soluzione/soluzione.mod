# TDE Dosaggio di farmaci

# DATI
param NP;																				# Numero di parametri
set Parametri := 1 .. NP;																# Parametri
set Farmaci;																			# Farmaci
param ValorePartenza {Parametri};														# Valore di partenza
param SogliaMinima {Parametri};															# Soglia minima
param ValoreRiferimento {Parametri};													# Valore di riferimento
param SogliaMassima {Parametri};														# Soglia massima
param EffettoFarmaci {Parametri, Farmaci};												# Effetto per mg  di farmaco preso
param FarmaciMassimi {Farmaci};															# Farmaci massimi [mg]

# VARIABILI
var Somministrazione {f in Farmaci} >= 0, <= FarmaciMassimi[f];							# Farmaci somministrati [mg]
var ValoreOttenuto {p in Parametri} >= SogliaMinima[p], <= SogliaMassima[p];			# Valore ottenuto dopo la somministrazione
var MINMAX;																				# MinMax

# VINCOLI
# Dichiarazione valori ottenuti
subject to DichiarazioneValoriOttenuti {p in Parametri}:
	ValoreOttenuto[p] = ValorePartenza[p] + sum {f in Farmaci} Somministrazione[f] * EffettoFarmaci[p,f];

# OBIETTIVO
# Minimizzare il massimo scostamento in valore assoluto
# minimize z : max( sum {p in Parametri} abs( ( ValoreOttenuto[p]-ValoreRiferimento[p] ) / ( SogliaMassima[p]-ValoreRiferimento[p] ) ) );
minimize z : MINMAX;
subject to VincoloMINMAX1 {p in Parametri}:
	MINMAX >= ( ValoreOttenuto[p]-ValoreRiferimento[p] ) / ( SogliaMassima[p]-ValoreRiferimento[p] );
subject to VincoloMINMAX2 {p in Parametri}:
	MINMAX >= ( ValoreRiferimento[p]-ValoreOttenuto[p] ) / ( ValoreRiferimento[p]-SogliaMassima[p] );

##################################################

data;

param NP := 7;

set Farmaci := A B C D E;

param:	ValorePartenza	SogliaMinima	ValoreRiferimento	SogliaMassima	:=
1        3.45       7.0      12.0        15.0
2        1800      1700      2500        3500
3        0.05      0.50      0.80        1.30
4        3200      1400      2000        2750
5        26.4       8.0      10.0        12.0     
6          35        28        35          41
7         136        80       120         160;

param EffettoFarmaci:	A	B	C	D	E	:=
1          -0.2   +0.5   +0.7   +0.1   +0.2
2          -500    0.0   -250    +50    0.0
3          +0.2   -0.1   +0.3    0.0   +0.2
4           -80   -120    +15    -90   -100
5          -8.5   -7.0   -1.0   -3.0   +1.0
6            +5     -2     +8     -4      0
7            -5     -1     -2     -3     +4;

param FarmaciMassimi :=
A          2.0
B          3.5
C          0.5
D          0.5
E          7.5;

end;
