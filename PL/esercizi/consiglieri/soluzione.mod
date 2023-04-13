# Consiglieri

# DATI
set Prodotti;
set Risorse;
param RisorseNecessarie {Risorse, Prodotti};
param RisorseDisponibili {Risorse};
param Ricavi_1 {Prodotti};
param Ricavi_2 {Prodotti};
# param z1;

# VARIABILI
var Produzione {Prodotti} >= 0;
# var z1;

# VINCOLI
subject to MassimoConsumo {r in Risorse}:
	sum {p in Prodotti} RisorseNecessarie[r,p] * Produzione[p] <= RisorseDisponibili[r];

# OBIETTIVO
# maximize z1 : sum {p in Prodotti} Ricavi_1[p] * Produzione[p];
maximize z2 : sum {p in Prodotti} Ricavi_2[p] * Produzione[p];
# subject to Obiettivo_1: sum {p in Prodotti} Ricavi_1[p] * Produzione[p] >= z1;

##################################################

data;

set Prodotti := X Y Z W;

set Risorse := A B C D;

param RisorseNecessarie:	X	Y	Z	W :=
A							3	2	5	4
B							8	10	1	1
C							1	3	6	9
D							2	0	8	11;

param RisorseDisponibili :=
A	100
B	120
C	90
D	110;

param Ricavi_1 :=
X	1
Y	1.5
Z	1.3
W	2.5;

param Ricavi_2 :=
X	1.7
Y	.4
Z	2
W	.7;

# param z1;

end;
