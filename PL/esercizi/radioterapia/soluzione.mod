# Radioterapia

# DATI
set Organi;										# Organi
set Posizioni;									# Posizioni
param Assorbimento {Organi, Posizioni};			# Coefficiente di assorbimento [adimensionale]
param AssorbimentoTumore {Posizioni};			# Coefficiente di assorbimento del tumore [adimensionale]
param RadiazioniPosizione {Posizioni};			# Massimo irraggiamento per posizione [Gray]
param RadiazioniOrgani {Organi};				# Massimo irraggiamento per organo [Gray]
param Radiazioni;								# Radiazioni disponibili [Gray]

# VARIABILI
var x {Posizioni} >= 0;							# Radiazioni sparate per posizione [Gray]

# VINCOLI
# Radiazioni massime disponibili [Gray]
subject to RadiazioniMassime:
	sum {p in Posizioni} x[p] <= Radiazioni;
# Radiazioni massime per organo [Gray]
subject to RadiazioniPerOrgano {o in Organi}:
	sum {p in Posizioni} x[p] * Assorbimento[o,p] <= RadiazioniOrgani[o];
# Radiazioni massime per posizione [Gray]
subject to RadiazioniPerPosizione {p in Posizioni}:
	x[p] <= RadiazioniPosizione[p];

# OBIETTIVO
# Massimizzare le radiazioni sul tumore [Grey]
maximize z : sum {p in Posizioni} x[p] * AssorbimentoTumore[p];

##################################################

data;

set Organi := 1 2 3 4 5 6 7;

set Posizioni := 1 2 3 4 5;

param Assorbimento:		1	2	3	4	5 :=
1						.1	0	0	.1	.2
2						.1	0	.15	0	.1
3						0	.1	0	0	0
4						0	.2	.1	.1	0
5						.1	0	.2	0	.1
6						.1	.3	.15	.1	.1
7						.2	.1	.15	0	0;

param AssorbimentoTumore :=
1	.4
2	.3
3	.25
4	.7
5	.5;

param RadiazioniPosizione :=
1	12
2	13
3	10
4	15
5	15;

param RadiazioniOrgani :=
1	5.5
2	9
3	6
4	2.4
5	7
6	5.5
7	9.5;

param Radiazioni := 60;

end;
