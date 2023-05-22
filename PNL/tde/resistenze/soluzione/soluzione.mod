# TDE Resistenze

# DATI
param NR;												# Numero di resistori
set Resistori := 1 .. NR;								# Resistori
param Disponibilita {Resistori};						# Disponibilità di resistori [adimensionale]
param Resistenza {Resistori};							# Resistenze dei resistori [ohm]
param Target;											# Target da raggiungere [ohm]
set Posizioni := 1 .. 4;								# Posizioni

# VARIABILI
var Assegnamento {Resistori, Posizioni} binary;			# Assegnamento [binaria]
var ResistenzePosizionate {Posizioni};					# Resistenze posizionate [ohm]
var Delta;												# Ausiliaria

# VINCOLI
# Assegno un solo resistore per ogni posizione [binaria]
subject to SingoloResistore {p in Posizioni}:
	sum {r in Resistori} Assegnamento[r,p] = 1;
# Massima disponibilità di resistori [adimensionale]
subject to MassimaDisponibilita {r in Resistori}:
	sum {p in Posizioni} Assegnamento[r,p] <= Disponibilita[r];
# Definizione resistenze [ohm]
subject to DefinizioneResistenze {p in Posizioni}:
	ResistenzePosizionate[p] = sum {r in Resistori} Assegnamento[r,p] * Resistenza[r];

# OBIETTIVO
# Minimizzare la distanza dal target [ohm]
minimize z : Delta;
subject to ValoreAssoluto1 : Delta >= 
	Target - (
	           ( 1 / ( 1/ResistenzePosizionate[1] ) + ( 1/ ResistenzePosizionate[2] ) )
	         + ( 1 / ( 1/ResistenzePosizionate[3] ) + ( 1/ ResistenzePosizionate[4] ) )
	);
subject to ValoreAssoluto2 : Delta >= 
	(
	           ( 1 / ( 1/ResistenzePosizionate[1] ) + ( 1/ ResistenzePosizionate[2] ) )
	         + ( 1 / ( 1/ResistenzePosizionate[3] ) + ( 1/ ResistenzePosizionate[4] ) )
	) - Target;

##################################################

data;

param NR := 6;

param:	Disponibilita	Resistenza	:=
1      	1         		12
2      	1         		15
3      	2        		20
4      	2         		22
5      	1         		30
6      	1         		40;

param Target := 65;

end;
