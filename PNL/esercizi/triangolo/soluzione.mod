# Triangolo

# DATI
param NP;									# Numero di punti
set Punti := 1 .. NP;						# Punti
param XP {Punti};							# X dei punti
param YP {Punti};							# Y dei punti
set Vertici := 0 .. 2;						# Vertici

# VARIABILI
var XVertice {Vertici};						# X dei vertici
var YVertice {Vertici};						# Y dei vertici
var Lambda {Punti, Vertici} >= 0;			# Pesi della combinazione convessa
var Lato >= 0;								# Lato al quadrato

# VINCOLI
# Teorema di mio fratello
subject to CombinazioneConvessa1 {p in Punti}:
	XP[p] = sum {v in Vertici} XVertice[v] * Lambda[p,v];
subject to CombinazioneConvessa2 {p in Punti}:
	YP[p] = sum {v in Vertici} YVertice[v] * Lambda[p,v];
# Somma dei lambda
subject to SommaLambda {p in Punti}:
	sum {v in Vertici} Lambda[p,v] = 1;
# Triangolo equilatero
subject to TriangoloEquilatero {v in Vertici}:
	Lato = ( XVertice[v]-XVertice[(v+1) mod 3] )^2 + ( YVertice[v]-YVertice[(v+1) mod 3] )^2;

# OBIETTIVO
# Minimizzare il lato
minimize z : Lato;

##################################################

data;

param NP := 5;

param:	XP		YP	:=
1		24		-17
2		15		14
3		-2		0
4		21		20
5		18		-6;

var:	XVertice	YVertice	:=
0		-10			0
1		25			30
2		25			30;

end;
