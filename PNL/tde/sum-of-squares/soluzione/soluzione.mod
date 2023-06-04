# TDE Sum of squares

# DATI
param NP;												# Numero di punti
set Punti := 1 .. NP;									# Punti
param NS;												# Numero di sottoinsiemi
set Sottoinsiemi := 1 .. NS;							# Sottoinsiemi
param ND;												# Numero di dimensioni
set Dimensioni := 1 .. ND;								# Dimensioni
param Coordinate {Punti, Dimensioni};					# Coordinate

# VARIABILI
var Assegnamento {Punti, Sottoinsiemi} binary;			# Assegnamento punto-sottinsieme
var Rappresentante {Sottoinsiemi, Dimensioni};			# Punti rappresentanti
var Distanze {Punti, Sottoinsiemi} >= 0;				# Distanze tra punti

# VINCOLI
# Assegno un punto ad un solo sottoinsieme
subject to SingoloAssegnamento {p in Punti}:
	sum {s in Sottoinsiemi} Assegnamento[p,s] = 1;
# Assegno almeno un punto ad ogni sottoinsieme
subject to MinimoAssegnamento {s in Sottoinsiemi}:
	sum {p in Punti} Assegnamento[p,s] >= 1;
# Definizione distanze
subject to DefinizioneDistanze {p in Punti, s in Sottoinsiemi}:
	Distanze[p,s] = Assegnamento[p,s] * sqrt( sum {d in Dimensioni} (Coordinate[p,d]-Rappresentante[s,d])^2 );

# OBIETTIVO
# Minimizzare le distanze nei sottoinsiemi
minimize z : sum {s in Sottoinsiemi, p in Punti} Distanze[p,s];

##################################################

data;

param NP := 16;

param NS := 3;

param ND := 4;

param Coordinate:	1	2	3	4	:=
1 					25 	61	110 -57
2 					32 	-63 90 	50
3 					28 	25 	-14 -34
4 					-41 -30 56 	-29
5 					70 	-81 -58 30
6 					-97 17 	-71 -68
7 					103 12 	-90 67
8 					12 	-31 135 65
9 					-28 -26 85 	21
10 					33 	-78 84 	-92
11 					-51 44 	-23 -94
12 					40 	-79 -27 63
13 					-99 80 	39 	-70
14 					96 	-11 -33 38
15 					5 	6 	-12 -91
16 					-40 48 	140 100;

end;
