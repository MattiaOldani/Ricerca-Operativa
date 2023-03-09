# Scommesse sui Cavalli

# DATI
set Cavalli;                        # Cavalli
param Quotazioni {Cavalli};         # Quotazione per cavallo [adimensionale]
param Budget;                       # Budget spendibile [euro]

# VARIABILI
var x {Cavalli} >= 0;               # Puntata per cavallo [euro]
var aux;                            # Variabile ausiliaria per MinMax [euro]

# VINCOLI
# Puntata massima [euro]
subject to PuntataMassima:
   sum {c in Cavalli} x[c] <= Budget;

# OBIETTIVO
# MinMax [euro]
maximize z: aux;
# Vincolo del MinMax [euro]
subject to MinMax {c in Cavalli}:
   aux <= x[c] * Quotazioni[c];

##################################################

data;

set Cavalli := Fulmine Freccia Dardo Lampo;

param Quotazioni :=
Fulmine     3
Freccia     4
Dardo       5
Lampo       6;

param Budget := 57;

end;
