# Colonnine

# DATI
param NR;																		# Numero di righe
set Righe := 1 .. NR;															# Insieme di righe
param NC;																		# Numero di colonne
set Colonne := 1 .. NC;															# Insieme di colonne
param Domanda {Righe, Colonne};													# Domanda richiesta da ogni cella [numero di automobili]
param NCR;																		# Numero di colonnine
set Colonnine := 1 .. NCR;														# Tipi di colonnine
param Capacita {Colonnine};														# Capacità delle colonnine [numero di automobili]
param Costi {Colonnine};														# Costi di installazione [migliaia di euro]
param Budget;																	# Budget [migliaia di euro]

# VARIABILI
var Assegnamento {Colonnine, Righe, Colonne, Righe, Colonne} binary;			# Assegnamento di ogni colonnina, in una data posizione, ad una serie di celle [binaria]
																				# [Colonnina, RigaColonnina, ColonnaColonnina, RigaCella, ColonnaCella]

# VINCOLI
# Non vado ad eccedere il budget disponibile [migliaia di euro]
# TODO
# Per ogni colonnina che non sia sul bordo non vado a eccedere la sua capacità [numero di automobili]
subject to CapacitaMassima1 {cr in Colonnine, r1 in Righe, c1 in Colonne : r1 > 1 and r1 < NR and c1 > 1 and c1 < NC}:
	sum {r2 in r1-1..r1+1, c2 in c1-1..c1+1} Assegnamento[cr,r1,c1,r2,c2] * Domanda[r2,c2] <= Capacita[cr];
# Per ogni colonnina sul bordo in alto non vado a eccedere la sua capacità [numero di automobili]
subject to CapacitaMassima2 {cr in Colonnine, c1 in Colonne : c1 > 1 and c1 < NC}:
	sum {r2 in 1..2, c2 in c1-1..c1+1} Assegnamento[cr,1,c1,r2,c2] * Domanda[r2,c2] <= Capacita[cr];
# Per ogni colonnina sul bordo in basso non vado a eccedere la sua capacità [numero di automobili]
subject to CapacitaMassima3 {cr in Colonnine, c1 in Colonne : c1 > 1 and c1 < NC}:
	sum {r2 in NR-1..NR, c2 in c1-1..c1+1} Assegnamento[cr,NR,c1,r2,c2] * Domanda[r2,c2] <= Capacita[cr];
# Per ogni colonnina sul bordo a sinistra non vado a eccedere la sua capacità [numero di automobili]
subject to CapacitaMassima4 {cr in Colonnine, r1 in Righe : r1 > 1 and r1 < NR}:
	sum {r2 in r1-1..r1-1, c2 in 1..2} Assegnamento[cr,r1,1,r2,c2] * Domanda[r2,c2] <= Capacita[cr];
# Per ogni colonnina sul bordo a destra non vado a eccedere la sua capacità [numero di automobili]
subject to CapacitaMassima5 {cr in Colonnine, r1 in Righe : r1 > 1 and r1 < NR}:
	sum {r2 in r1-1..r1-1, c2 in NC-1..NC} Assegnamento[cr,r1,NC,r2,c2] * Domanda[r2,c2] <= Capacita[cr];
# La colonnina in alto a sinistra non va a eccedere la sua capacità [numero di automobili]
subject to CapacitaMassima6 {cr in Colonnine}:
	Assegnamento[cr,1,1,2,1] * Domanda[2,1] + Assegnamento[cr,1,1,1,2] * Domanda[2,1] <= Capacita[cr];
# La colonnina in alto a destra non va a eccedere la sua capacità [numero di automobili]
subject to CapacitaMassima7 {cr in Colonnine}:
	Assegnamento[cr,1,NC,2,NC] * Domanda[2,NC] + Assegnamento[cr,1,NC,1,NC-1] * Domanda[1,NC-1] <= Capacita[cr];
# La colonnina in basso a sinistra non va a eccedere la sua capacità [numero di automobili]
subject to CapacitaMassima8 {cr in Colonnine}:
	Assegnamento[cr,NR,1,NR-1,1] * Domanda[NR-1,1] + Assegnamento[cr,NR,1,NR,2] * Domanda[NR,2] <= Capacita[cr];
# La colonnina in basso a destra non va a eccedere la sua capacità [numero di automobili]
subject to CapacitaMassima9 {cr in Colonnine}:
	Assegnamento[cr,NR,NC,NR-1,1] * Domanda[NR-1,1] + Assegnamento[cr,NR,NC,NR,NC-1] * Domanda[NR,NC-1] <= Capacita[cr];
# Garantisco la domanda di ogni cella [numero di automobili]
subject to GarantiscoDomanda {r1 in Righe, c1 in Colonne}:
	sum {cr in Colonnine, r2 in Righe, c2 in Colonne} Assegnamento[cr,r2,c2,r1,c1] * Capacita[cr] >= Domanda[r1,c1];

# OBIETTIVO
# Minimizzare i costi di installazione [migliaia di euro]
minimize z : sum {cr in Colonnine, r1 in Righe, c1 in Colonne, r2 in Righe, c2 in Colonne} Assegnamento[cr,r1,c1,r2,c2] * Costi[cr];

##################################################

data;

param NR := 16;

param NC := 9;

param Domanda:	1	2	3	4	5	6	7	8	9	:=
1				0	0	2	0	0	0	1	0	1
2				1	0	0	0	0	1	0	0	0
3				0	1	0	2	0	0	0	0	0
4				1	0	0	0	0	1	0	0	0
5				0	0	1	0	0	0	0	0	2
6				1	0	0	0	0	1	0	0	0
7				0	0	0	1	0	0	0	0	0
8				0	1	0	0	0	0	0	0	1
9				0	0	0	1	0	2	0	0	0
10				0	0	0	0	0	0	0	0	1
11				1	1	0	0	0	0	0	0	0
12				0	0	0	1	0	2	0	0	1
13				1	0	0	0	0	0	0	0	0
14				0	0	0	1	0	1	0	1	0
15				1	0	0	0	0	0	0	0	1
16				1	0	2	0	0	0	2	0	0;

param NCR := 2;

param:	Capacita	Costi	:=
1		1			50
2		3			100;

param Budget := 1200;

end;
