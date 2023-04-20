# Zaino

# DATI
param N;									# Numero di oggetti
set Oggetti := 1 .. N;						# Oggetti
param Peso {Oggetti};						# Peso di un oggetto [kg]
param ValoreOggetto {Oggetti};				# Valore di un oggetto [adimensionale]
param CapacitaZaino;						# Capacità massima dello zaino [kg]

# VARIABILI
var x {Oggetti} binary;						# Selezione oggetti [binaria]

# VINCOLI
# Capacità massima dello zaino [kg]
subject to CapacitaMassima:
	sum {o in Oggetti} Peso[o] * x[o] <= CapacitaZaino;

# OBIETIVO
# Massimizzare il valore dello zaino [adimensionale]
maximize z : sum {o in Oggetti} ValoreOggetto[o] * x[o];

##################################################

data;

param N := 12;

param Peso :=
1	41
2	39
3	45
4	28
5	56
6	58
7	37
8	63
9	49
10	33
11	42
12	52;

param ValoreOggetto :=
1	16
2	19
3	19
4	12
5	22
6	29
7	18
8	26
9	22
10	14
11	19
12	25;

param CapacitaZaino := 300;

end;
