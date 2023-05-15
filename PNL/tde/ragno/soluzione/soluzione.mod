# TDE Ragno

# DATI
set Appigli := 0 .. 2;							# Appigli
param CoordinateX {Appigli};					# Coordinate X [cm]
param CoordinateY {Appigli};					# Coordinate Y [cm]
param CoordinateZ {Appigli};					# Coordinate Z [cm]
param AreaMinima;								# Area minima [cm^2]

# VARIABILI
var X {Appigli};								# X vertici triangolo [cm]
var Y {Appigli};								# Y vertici triangolo [cm]
var Z {Appigli};								# Z vertici triangolo [cm]
var Lati {Appigli} >= 0;						# Lunghezza dei lati [cm]
var P = sum {a in Appigli} Lati[a] / 2;			# Semiperimetro [cm]
var Connessioni {Appigli} >= 0;					# Distanza tra appiglio e vertice [cm]

# VINCOLI
# Area minima
subject to AreaTriangoloPortante:
	P * Lati[0] * Lati[1] * Lati[2] >= AreaMinima^2;
# Definizione lati [cm]
subject to DefinizioneLati {a in Appigli}:
	Lati[a]^2 = (X[(a+2) mod 3] - X[(a+1) mod 3])^2
			  + (Y[(a+2) mod 3] - Y[(a+1) mod 3])^2
			  + (Z[(a+2) mod 3] - Z[(a+1) mod 3])^2;
# Definizione connessioni [cm]
subject to DefinizioneConnessioni {a in Appigli}:
	Connessioni[a]^2 = (CoordinateX[a] - X[a])^2
					 + (CoordinateY[a] - Y[a])^2
					 + (CoordinateZ[a] - Z[a])^2;

# OBIETTIVO
# Minimizzare il filo necessario [cm]
minimize z : 2*P + sum {a in Appigli} Connessioni[a];

##################################################

data;

param CoordinateX :=
0	30 
1	50
2	50;

param CoordinateY :=
0	60 
1	10
2	45;

param CoordinateZ :=
0	40
1	30
2	10;

param AreaMinima := 100;

var:	X	Y	Z	:=
0		35	45	40
1		55	20	45
2		40	30	20;

end;
