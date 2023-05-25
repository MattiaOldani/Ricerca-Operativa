# TDE Classificatore automatico

# DATI
param NP;															# Numero di punti
set Punti := 1 .. NP;												# Punti
param XP {Punti};													# Ascissa dei punti
param YP {Punti};													# Ordinata dei punti
param Verita {Punti};												# Classificazione dei punti
param M := max {p1 in Punti, p2 in Punti}
		   sqrt( (XP[p1]-XP[p2])^2 + (YP[p1]-YP[p2])^2 );			# Disattivazione dei vincoli

# VARIABILI
var A;																# Coefficiente A retta
var B;																# Coefficiente B retta
var C;																# Coefficiente C retta
var Selezione {Punti} binary;										# Selezione = 1 consente di classificare male il punto

# VINCOLI
# Normalizzazione
subject to Normalizzazione:
	A^2 + B^2 = 1;
# Punti falsi con disattivazione
subject to PuntiFalsi {p in Punti : Verita[p] = 0}:
	A*XP[p] + B*YP[p] + C <= M * Selezione[p];
# Punti veri con disattivazione
subject to PuntiVeri {p in Punti: Verita[p] = 1}:
	A*XP[p] + B*YP[p] + C >= -M * Selezione[p];
	
# OBIETTIVO
# Minimizzare i punti classificati in modo errato
minimize z : sum {p in Punti} Selezione[p];

##################################################

data;

param NP := 20;

param:	XP	YP	Verita	:=
1  		12 	29 	1
2  		16 	26 	1
3  		24 	25 	1
4  		8 	7 	1
5  		30 	50 	1
6  		11 	41 	1
7  		5 	2 	1
8  		6 	11 	1
9  		40 	12 	1
10 		23 	27 	1
11 		21 	43 	1
12 		51 	18 	1
13 		2 	36 	0
14 		2 	33 	0
15 		11 	6 	0
16 		33 	7 	0
17 		28 	45 	0
18 		25 	42 	0
19 		20 	50 	0
20 		20 	18 	0;

end;
