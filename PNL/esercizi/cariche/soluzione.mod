# Cariche

# DATI
param NB;											# Numero di bastoncini
set Bastoncini := 1 .. NB;							# Bastoncini

# VARIABILI
var X {Bastoncini};									# Coordinata X [cm]
var Y {Bastoncini};									# Coordinata Y [cm]
var Z {Bastoncini};									# Coordinata Z [cm]
var Distanza {Bastoncini, Bastoncini} >= 0;			# Distanza [cm]

# VINCOLI
# Sfera di raggio 1 [cm^2]
subject to Sfera {b in Bastoncini}:
	X[b]^2 + Y[b]^2 + Z[b]^2 = 1;
# Definizione distanza [cm^2]
subject to DefinizioneDistanza {b1 in Bastoncini, b2 in Bastoncini : b1 < b2}:
	Distanza[b1,b2]^2 = (X[b1]-X[b2])^2 + (Y[b1]-Y[b2])^2 + (Z[b1]-Z[b2])^2;

# OBIETTIVO
# Massimizzare l'inverso della distanza [cm]
maximize z : sum {b1 in Bastoncini, b2 in Bastoncini : b1 < b2} 1 / Distanza[b1,b2];

##################################################

data;

param NB := 5;

var:	X	Y	Z	:=
1		0	1	0
2		1	0	0
3		0	0	1
4		.7	.7	0
5		0	.7	.7;

end;
