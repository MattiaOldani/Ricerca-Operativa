# TDE Missione

# DATI
param NP;											# Numero di persone
set Persone := 1 .. NP;								# Persone
param NO;											# Numero di oggetti
set Oggetti := 1 .. NO;								# Oggetti
param SpazioOccupato {Persone, Oggetti};			# Spazio occupato
param Valore {Persone, Oggetti};					# Valore esperimenti
param Capacita;										# Peso massimo

# VARIABILI
var Selezione {Persone, Oggetti} binary;			# Selezione [binaria]
var MaxMin;											# MaxMin

# VINCOLI
# Non sforo la capcità massima
subject to Massimo:
	sum {p in Persone, o in Oggetti} Selezione[p,o] * SpazioOccupato[p,o] <= Capacita;
# Ogni scienziato porta almeno un oggetto
subject to AlmenoUnOggetto {p in Persone}:
	sum {o in Oggetti} Selezione[p,o] >= 1;

# OBIETTIVO
# maximize z : MaxMin;
# subject to VincoloMaxMin {p in Persone, o in Oggetti}:
# MaxMin <= Valore[p,o] + (1 - Selezione[p,o]) * Capacita;
maximize z : sum {p in Persone, o in Oggetti} Selezione[p,o] * Valore[p,o];

##################################################

data;

param NP := 4;

param NO := 6;

param SpazioOccupato:	1	2	3	4	5	6	:=
1						35	48	12	26	29	40
2						18	17	41	36	28	15
3						33	20	14	12	8	27
4						20	28	31	35	7	15;

param Valore:	1	2	3	4	5	6	:=
1				31	40	19	25	33	41
2				17	25	36	32	30	19
3				25	28	12	18	10	29
4				15	18	30	27	10	12;

param Capacita := 100;

end;
