# TDE Tunnel

# DATI
param NP;							# Numero di punti
set Punti := 1 .. NP;				# Punti
param XP {Punti};					# X dei punti
param YP {Punti};					# Y dei punti

# VARIABILI
var A := 1;							# Coefficiente A
var B := 0;							# Coefficiente B
var C := -10;						# Coefficiente C
var aux {Punti};					# Linearizzare il modulo
var Distanze {Punti} >= 0;			# Distanze

# VINCOLI
# Caso patologico A = B = 0 non deve succedere
# Normalizzare la terna <A,B,C> con A^2 + B^2 = 1
subject to Normalizzazione:
	A^2 + B^2 = 1;
# Inizializzazione delle distanze
subject to InizializzazioneDistanze {p in Punti}:
	Distanze[p] = A*XP[p] + B*YP[p] + C;

# OBIETTIVO
# Minimizzare le distanze tra i punti e la retta
minimize z : sum {p in Punti} aux[p];
subject to Modulo1 {p in Punti}: aux[p] >= Distanze[p];
subject to Modulo2 {p in Punti}: aux[p] >= -Distanze[p];

##################################################

data;

param NP := 12;

param:	XP		YP	:=
1		-10		14
2    	-8 		7
3    	-5 		10
4    	-3 		10
5     	0  		9
6     	2   	8
7     	5   	8
8     	8   	7
9     	9   	5
10    	11 		6
11    	14  	7
12    	16  	5;

end;
