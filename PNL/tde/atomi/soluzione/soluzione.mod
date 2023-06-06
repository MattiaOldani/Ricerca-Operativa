# TDE Atomi

# DATI
param NA;																				# Numero di atomi
set Atomi := 1 .. NA;																	# Atomi
param X {Atomi};																		# X atomi
param Y {Atomi};																		# Y atomi
param Z {Atomi};																		# Z atomi
param A {Atomi};																		# Costante A
param B {Atomi};																		# Costante B

# VARIABILI
var XS;																					# X sonda
var YS;																					# Y sonda
var ZS;																					# Z sonda
var Distanze {a in Atomi} = sqrt( (X[a]-XS)^2 + (Y[a]-YS)^2 + (Z[a]-ZS)^2 );			# Distanza atomi-sonda
var Energia {Atomi};																	# Energia

# VINCOLI
# Definizione dell'energia di interazione
subject to DefinizioneEnergia {a in Atomi}:
	Energia[a] = ( A[a] / Distanze[a]^12) - ( B[a] / Distanze[a]^6 );

# OBIETTIVO
# Massimizzare l'energia di interazione
# Ho sempre energia negativa, quindi la massimizzo per stabilizzarla sullo 0
maximize z : sum {a in Atomi} Energia[a];

#################################################

data;

param NA := 10;

param:	X	Y	Z	:=
1 		3.2 2.5 4.8
2 		2.1 3.7 8.4
3 		7.5 2.5 5.0
4 		6.6 1.2 4.5
5 		0.8 5.1 5.6
6 		6.3 8.8 3.5
7 		2.4 1.0 3.1
8 		1.2 4.6 9.0
9 		8.5 7.8 1.5
10 		4.1 9.3 0.9;

param:	A	B	:=
1		1	200
2		1.1	400
3		2.1	320
4		3	250
5		.5	400
6		.2	200
7		.8	120
8		1.1	300
9		1.5	100
10		1.7	500;

var XS = 5;

var YS = 5;

var ZS = 5;

end;
