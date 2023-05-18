# TDE Rettangolo

# DATI
param NP;						# Numero di punti
set Punti := 1 .. NP;			# Punti
param XP {Punti};				# X dei punti
param YP {Punti};				# Y dei punti
set Rette := 0 .. 3;			# Rette

# VARIABILI
var A {Rette};					# Coefficienti A delle rette
var B {Rette};					# Coefficienti B delle rette
var C {Rette};					# Coefficienti C delle rette
var Lato1 >= 0;					# Primo lato
var Lato2 >= 0;					# Secondo lato

# VINCOLI
# Interno del rettangolo
subject to InternoRettangolo {p in Punti, r in Rette}:
	A[r]*XP[p] + B[r]*YP[p] + C[r] >= 0;
# Normalizzazione
subject to Normalizzazione {r in Rette}:
	A[r]^2 + B[r]^2 = 1;
# Anti-parallelismo
# A1*A2 + B1*B2 = -1, ovvero prodotto scalare = -1
subject to AntiParallelismo {r in Rette : r <= 1}:
	A[r]*A[r+2] + B[r]*B[r+2] = -1;
# Perpendicolarità
# A1*A2 + B1*B2 = 0, ovvero prodotto scalare = 0
subject to Perpendicolarita:
	A[0]*A[1] + B[0]*B[1] = 0;
# Definizione lato1 e lato2
subject to DefinizioneLato1:
	Lato1 = C[0] + C[2];
subject to DefinizioneLato2:
	Lato2 = C[1] + C[3];

# OBIETTIVO
# Minimizzare l'area del rettangolo
# Distanza tra due rette --> ABS(C1+C2)
minimize z : Lato1 * Lato2;

##################################################

data;

param NP := 10;

param:	XP		YP	:=
1		-7		-2
2		-3		5
3		-4		-5
4		10		5
5		11		2
6		6		9
7		0		-6
8		-6		2
9		9		0
10		-7		0;

var:	A	B	C	:=
0		1	0	100
1		0	-1	100
2		-1	0	100
3		0	1	100;

end;
