# TDE Penalized knapsack

# DATI
param NO;								# Numero di oggetti
set Oggetti := 1 .. NO;					# Oggetti
param Valore {Oggetti};					# Valore [punti pisello]
param Volume {Oggetti};					# Volume [punti tette]
param Penalita {Oggetti};				# Penalità [punti pisello]
param Capacita;							# Capacità massima [punti tette]

# VARIABILI
var Selezione {Oggetti} binary;			# Selezione [binaria]
var MassimaPenalita >= 0;				# Massima penalità [punti pisello]

# VINCOLI
# Volume massimo [punti tette]
subject to VolumeMassimo:
	sum {o in Oggetti} Selezione[o] * Volume[o] <= Capacita;
# Definizione massima penalità	[punti pisello]
subject to DefinizioneMassimaPenalita {o in Oggetti}:
	MassimaPenalita >= Selezione[o] * Penalita[o];

# OBIETTIVO
# Massimizzare il valore con Penalita [punti pisello]
maximize z : sum {o in Oggetti} Selezione[o] * Valore[o] - MassimaPenalita;

##################################################

data;

param NO := 30;

param:	Valore	Volume	Penalita	:=
1 27 10 34
2 41 58 59
3 23 97 87
4 32 23 34
5 39 19 40
6 8 5 29
7 50 71 84
8 2 94 67
9 30 81 53
10 54 92 48
11 85 74 53
12 2 3 85
13 23 41 37
14 18 57 49
15 73 12 85
16 41 47 37
17 78 10 90
18 32 25 57
19 18 61 62
20 23 23 34
21 34 74 75
22 58 28 88
23 12 62 43
24 31 35 75
25 63 63 93
26 14 49 75
27 13 13 39
28 87 95 58
29 56 87 37
30 32 23 6;

param Capacita := 1000;

end;
