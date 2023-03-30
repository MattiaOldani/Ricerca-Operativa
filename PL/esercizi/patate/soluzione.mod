# Patate

# DATI
set Fornitori;								# Fornitori
set Patate;									# Patate
param Rese {Fornitori, Patate};				# Resa delle patate [adimensionale]
param Profitti {Fornitori};					# Profitto [euro/kg]
param Quantita {Patate};					# Quantità massime [tonnellate]

# VARIABILI
var x {Fornitori} >= 0;						# Patate comprate per fornitore [kg]

# VINCOLI
# Quantitò massime disponibili [kg]
subject to QuantitaMassime {p in Patate}:
	sum {f in Fornitori} x[f] * Rese[f,p] <= Quantita[p] * 1000;

# OBIETTIVO
# Massimizzare i profitti [euro]
maximize z : sum {f in Fornitori} x[f] * Profitti[f];

##################################################

data;

set Fornitori := 1 2;

set Patate := A B C;

param Rese:		A		B		C :=
1				0.2		0.2		0.3
2				0.3		0.1		0.3;

param Profitti :=
1	0.02
2	0.03;

param Quantita :=
A	6
B	4
C	8;

end;
