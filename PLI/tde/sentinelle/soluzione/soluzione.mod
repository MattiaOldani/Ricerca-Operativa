# TDE Sentinelle

# DATI
param I;									# Numero di incroci
set Incroci := 1 .. I;						# Incroci
set Vie within Incroci cross Incroci;		# Vie come sottoinsieme del prodotto cartesiano degli incroci

# VARIABILI
var PresenzaSentinella {Incroci} binary;	# Presenza della sentinella in un dato incrocio

# VINCOLI
# Controllo degli incroci
subject to ControlloIncrocio {i in Incroci}:
	PresenzaSentinella[i] + sum {i2 in Incroci : (i,i2) in Vie or (i2,i) in Vie} ( PresenzaSentinella[i2] ) >= 1;

# OBIETTIVI
# Minimizzare il numero di sentinelle
minimize z : sum {i in Incroci} PresenzaSentinella[i];

##################################################

data;

param I := 30;

set Vie :=
1 2,
1 3,
1 4,
2 30,
3 13,
3 16,
4 5,
4 6,
4 24,
5 6,
5 8,
5 13,
6 7,
7 9,
7 10,
8 9,
8 12,
8 13,
8 27,
9 10,
9 27,
10 11, 
11 23,
11 29,
12 13,
12 18,
12 19,
12 27,
13 14,
14 15,
14 18,
15 16,
15 17,
18 19,
18 28,
19 20,
19 28,
20 21,
20 22,
20 29,
24 25,
24 26,
27 29;

end;
