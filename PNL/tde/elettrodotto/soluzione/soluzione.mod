# TDE Elettrodotto

# DATI
param NP;																	# Numero di paesi
set Paesi := 1 .. NP;														# Paesi
param XCentralina {Paesi};													# Ascissa centraline [km]
param YCentralina {Paesi};													# Ordinata centraline [km]
param DistanzaMassimaCC;													# Distanza massima cabina-centralina [km]
param Predecessore {p in Paesi : p <> 1};									# Predecessore di ogni nodo

# VARIABILI
var XCabina {p in Paesi} := XCentralina[p];									# Ascissa cabine [km]
var YCabina {p in Paesi} := YCentralina[p];									# Ordinata cabine [km]
var DistanzaCC {p in Paesi : p <> 1} >= 0, <= DistanzaMassimaCC;			# Distanza cabina-centralina [km]
var DistanzaElettrodotto {Paesi} >= 0;										# Distanza nodi elettrodotto [km]

# VINCOLI
# Distanza cabina-centralina [km^2]
subject to CreazioneDistanzaCC1 {p in Paesi : p <> 1}:
	DistanzaCC[p]^2 = ( XCentralina[p]-XCabina[p] )^2 + ( YCentralina[p]-YCabina[p] )^2;
subject to CreazioneDistanzaCC2 : XCentralina[1] = XCabina[1];
subject to CreazioneDistanzaCC3 : YCentralina[1] = YCabina[1];
# Distanza nodi elettrodotto [km^2]
subject to CreazioneDistanzaElettrodotto {p in Paesi : p <> 1}:
	DistanzaElettrodotto[p]^2 = (XCabina[p]-XCabina[Predecessore[p]])^2 + (YCabina[p]-YCabina[Predecessore[p]])^2;

# OBIETTIVO
# Minimizzare le distanze cabina-centralina [km]
minimize Tizio: sum {p in Paesi : p <> 1} DistanzaCC[p];
# Minimizzare le distanze dei nodi elettrodotto [km]
# minimize Caio: sum {p in Paesi : p <> 1} DistanzaElettrodotto[p];
# Minimizzare una combinazione delle precedenti [km]
# minimize Sempronio : sum {p in Paesi : p <> 1} (1.5 * DistanzaCC[p] + DistanzaElettrodotto[p]);

##################################################

data;

param NP := 16;

param:	XCentralina		YCentralina	:=
1		0				0
2		4				8
3		10				12
4		15				12
5		22				28
6		31				30
7		40				34
8		42				46
9		50				50
10		25				15
11		32				15
12		37				10
13		46				13
14		31				38
15		28				45
16		35				54;

param DistanzaMassimaCC := 2;

param Predecessore :=
2	1
3	2
4	3
5	4
6	5
7	6
8	7
9	8
10	4
11	10
12	11
13	12
14	6
15	14
16	15;

end;
