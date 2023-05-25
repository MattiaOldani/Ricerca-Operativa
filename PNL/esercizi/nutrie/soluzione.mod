# Nutrie

# DATI
param NC;												# Numero di cacciatori
set Cacciatori := 1 .. NC;								# Cacciatori
param NP;												# Numero di paesi
set Paesi := 1 .. NP;									# Paesi
param NumeroNutrie {Paesi};								# Numero di nutrie per paese

# VARIABILI
var Assegnamento {Paesi, Cacciatori} binary;			# Assegnamento paese-cacciatore
var Target {Cacciatori} >= 0;							# Target di ogni cacciatore
var MaxTarget;											# MinMax

# VINCOLI
# Massimo 3 paesi per cacciatore ma mai zero
subject to PaesiMassimi {c in Cacciatori}:
	sum {p in Paesi} Assegnamento[p,c] <= 3;
subject to PaesiMinimi {c in Cacciatori}:
	sum {p in Paesi} Assegnamento[p,c] >= 1;
# Definizione del target
subject to DefinizioneTarget {c1 in Cacciatori}:
	Target[c1] = sum {p in Paesi} Assegnamento[p,c1] * NumeroNutrie[p]
			   / sum {c2 in Cacciatori} Assegnamento[p,c2];

# OBIETTIVO
# Minimizzare il massimo dei valori target
minimize z : MaxTarget;
subject to MinMax {c in Cacciatori}:
	MaxTarget >= Target[c]; 

##################################################

data;

param NC := 5;

param NP := 10;

param NumeroNutrie :=
1	20
2	30
3	24
4	36
5	80
6	72
7	54
8	37
9	25
10	47;

end;
