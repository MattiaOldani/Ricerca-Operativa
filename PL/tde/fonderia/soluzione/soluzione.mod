# TDE Fonderia

# DATI
param NP;														# Numero prodotti
set Prodotti := 1 .. NP;										# Prodotti
param NMP;														# Numero materie prime
set MateriePrime := 1 .. NMP;									# Materie primee
param Disponibilita {MateriePrime};								# Disponiblità [kg/g]
param ComposizionePercentuale {MateriePrime, Prodotti};			# Composizione percentuale [%]
param PrimoScenarioPrezzi {Prodotti};							# Prezzi primo scenario [euro/kg]
param SecondoScenarioPrezzi {Prodotti};							# Prezzi secondo scenario [euro/kg]

# VARIABILI
var Produzione {Prodotti} >= 0;									# Produzione [kg/g]
var PrimoRicavo;												# Primo ricavo [euro/giorno]
var SecondoRicavo;												# Secondo ricavo [euro/giorno]
var MAXMIN;														# MaxMin

# VINCOLI
# Disponibilità materie prime [kg/g]
subject to DisponibilitaMaterie {mp in MateriePrime}:
	sum {p in Prodotti} Produzione[p] * ComposizionePercentuale[mp,p] / 100 <= Disponibilita[mp];
# Primo ricavo [euro]
subject to VederePrimoRicavo:
	PrimoRicavo = sum {p in Prodotti} Produzione[p] * PrimoScenarioPrezzi[p];
# Secondo ricavo [euro]
subject to VedereSecondoRicavo:
	SecondoRicavo = sum {p in Prodotti} Produzione[p] * SecondoScenarioPrezzi[p];

# OBIETTIVO
# Mssimizzare i ricavi nello scenario peggiore [euro]
maximize z : MAXMIN;
subject to VincoloMAXMIN1:
	MAXMIN <= PrimoRicavo;
subject to VincoloMAXMIN2:
	MAXMIN <= SecondoRicavo;

##################################################

data;

param NP := 3;

param NMP := 4;

param Disponibilita :=
1	2900
2	2200
3	4000
4	1550;

param ComposizionePercentuale:		1	2	3	:=
1									58	22	30
2									12	15	60
3									20	53	14
4									10	15	23;

param PrimoScenarioPrezzi :=
1	6
2	10
3	12;

param SecondoScenarioPrezzi :=
1	12
2	10
3	6;

end;
