# TDE Match

# DATI
param NP;														# Numero di punti
set Punti := 1 .. NP;											# Punti
param XP1 {Punti};												# Ascisse punti 1
param YP1 {Punti};												# Ordinate punti 1
param XP2 {Punti};												# Ascisse punti 2
param YP2 {Punti};												# Ordinate punti 2
param CostoComplessivo;											# Costo massimo complessivo
param CostoMassimoCoppia;										# Costo massimo per coppia

# VARIABILI
var Relazione {Punti, Punti} binary;							# Match tra punti
var Distanze {p1 in Punti, p2 in Punti} :=
	sqrt( (XP1[p1]-XP2[p2])^2 + (YP1[p1]-YP2[p2])^2 );			# Distanze tra punti

# VINCOLI
# Dato un punto p1, matcho un solo punto p2
subject to SingolaCoppia1 {p1 in Punti}:
	sum {p2 in Punti} Relazione[p1,p2] = 1;
# Dato un punti p1, sono matchato da un solo p2
subject to SingolaCoppia2 {p2 in Punti}:
	sum {p1 in Punti} Relazione[p1,p2] = 1;
# Massimo match complessivo
subject to MassimoMatchComplessivo:
	sum {p1 in Punti, p2 in Punti} Relazione[p1,p2] * Distanze[p1,p2] <= CostoComplessivo;

# OBIETTIVO
# Massimizzare il match
maximize z : sum {p1 in Punti, p2 in Punti} Relazione[p1,p2] * Distanze[p1,p2];

##################################################

data;

param NP := 7;

param:	XP1	YP1	XP2	YP2	:=
1		15	12	90	12
2		25	42	11	25
3		35	3	29	3
4		45	28	57	88
5		93	56	20	18
6		18	44	61	30
7		19	28	40	51;

param CostoComplessivo := 180;

param CostoMassimoCoppia := 70;

end;
