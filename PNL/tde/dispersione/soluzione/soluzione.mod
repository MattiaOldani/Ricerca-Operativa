# TDE Dispersione

# DATI
param NC;									# Numero di cerchi
set Cerchi := 1 .. NC;						# Cerchi
param Raggio {Cerchi};						# Raggi dei cerchi
param RaggioContenitore;					# Raggio del cerchio contenitore

# VARIABILI
var X {c in Cerchi} := c;					# Ascisse dei cerchi
var Y {c in Cerchi} := c;					# Ordinate dei cerchi
var Distanze {Cerchi, Cerchi} >= 0;			# Distanze tra cerchi
var MaxMin;									# MaxMin

# VINCOLI
# Appartenenza alla circonferenza sulle X
subject to DentroX1 {c in Cerchi}:
	X[c] <= RaggioContenitore - Raggio[c];
subject to DentroX2 {c in Cerchi}:
	X[c] >= Raggio[c] - RaggioContenitore;
# Appartenenza alla circonferenza sulle Y
subject to DentroY1 {c in Cerchi}:
	Y[c] <= RaggioContenitore - Raggio[c];
subject to DentroY2 {c in Cerchi}:
	Y[c] >= Raggio[c] - RaggioContenitore;
# Definizione distanze
subject to DefinizioneDistanze {c1 in Cerchi, c2 in Cerchi : c1 < c2}:
	Distanze[c1,c2] = sqrt( (X[c1]-X[c2])^2 + (Y[c1]-Y[c2])^2 );
# Non devo collidere con altri cerchi
subject to NonCollisione {c1 in Cerchi, c2 in Cerchi : c1 < c2}:
	Distanze[c1,c2] >= Raggio[c1] + Raggio[c2];

# OBIETTIVO
maximize z : MaxMin;
subject to VincoloMaxMin {c1 in Cerchi, c2 in Cerchi : c1 < c2}:
	MaxMin <= Distanze[c1,c2];

##################################################

data;

param NC := 20;

param Raggio :=
1	24
2	31
3	15
4	7
5	18
6	22
7	10
8	8
9	25
10	27
11	14
12	13
13	11
14	19
15	2
16	3
17	9
18	4
19	5
20	20;

param RaggioContenitore := 200;

end;
