# TDE Location

# DATI
param NP;												# Numero di punti
set Punti := 1 .. NP;									# Punti
param NF;												# Numero di facilities
set Facilities := 1 .. NF;								# Facilities
param XP {Punti};										# Ascissa punti
param YP {Punti};										# Ordinata punti
param Richieste {Punti};								# Richieste [punti tren]
param Capacita {Facilities};							# Capacita [punti tren]
param CostoUtilizzo {Facilities};						# Costo utilizzo [punti tren]

# VARIABILI
var XF {Facilities};									# Ascissa facilities
var YF {Facilities};									# Ordinata facilities
var Assegnamento {Punti, Facilities} binary;			# Assegnamento [binaria]
var Utilizzo {Facilities} binary;						# Utilizzo [binaria]
var Distanze {Punti} >= 0;								# Distanze [punti tren]

# VINCOLI
# Singolo assegnamento [binaria]
subject to SingoloAssegnamento {p in Punti}:
	sum {f in Facilities} Assegnamento[p,f] = 1;
# Definizione distanze [punti tren]
subject to DefinzioneDistanze {p in Punti}:
	Distanze[p]^2 = sum {f in Facilities} Assegnamento[p,f] * ( (XP[p]-XF[f])^2 + (YP[p]-YF[f])^2 );
# Capacità di ogni facilities [punti tren]
subject to CapacitaMassima {f in Facilities}:
	sum {p in Punti} Assegnamento[p,f] * Richieste[p] <= Capacita[f] * Utilizzo[f];

# OBIETTIVO
# Minimizzare i costi di utilizzo [punti tren]
minimize z : sum {f in Facilities} Utilizzo[f] * CostoUtilizzo[f] +
			 sum {f in Facilities, p in Punti} Assegnamento[p,f] * Distanze[p];

##################################################

data;

param NP := 10;

param NF := 4;

param:	XP	YP	:=
1		-20	45
2		-30	56
3		-10	-29
4		0	-18
5		40	3
6		30	40
7		15	12
8		18	-6
9		23	24
10		-2	-30;

param Richieste :=
1	30
2	35
3	40
4	15
5	20
6	20
7	25
8	40
9	10
10	25;

param Capacita :=
1	130
2	80
3	100
4	60;

param CostoUtilizzo :=
1	800
2	500
3	750
4	400;

end;
