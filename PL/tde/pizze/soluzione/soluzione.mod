# TDE Pizze

# DATI
set Amici;										# Amici
set Pizze;										# Pizze
param IndiceGradimento {Amici, Pizze};			# Indice di gradimento

# VARIABILI
var PizzaMangiata {Amici, Pizze} >= 0;			# Percentuale di pizza mangiata
var Contentezza {Amici} >= 0;					# Livello di contentezza
var MaxMin;										# MaxMin

# VINCOLI
# Finisco tutte le pizze
subject to FiniscoLePizze {p in Pizze}:
	sum {a in Amici} PizzaMangiata[a,p] = 1;
# Definizione grado di contentezza
subject to DefinizioneContentezza {a in Amici}:
	Contentezza[a] = sum {p in Pizze} PizzaMangiata[a,p] * IndiceGradimento[a,p];

# VARIABILI
# Massimizzare robe
maximize z : Contentezza[1];

##################################################

data;

set Amici := 1 2;

set Pizze := Formaggi Salumi Verdure;

param IndiceGradimento:		Formaggi	Salumi	Verdure		:=
1							.3			.5		.2
2							.7			.2		.1;

end;
