# TDE Prezzi

# DATI
param NP;												# Numero di prodotti
set Prodotti := 1 .. NP;								# Prodotti
param NMP;												# Numero di materie prime
set MateriePrime := 1 .. NMP;							# Materie prime
param Composizione {MateriePrime, Prodotti};			# Unità per prodotto
param Alpha {Prodotti};									# Alpha
param Beta {Prodotti};									# Beta
param Gamma {Prodotti};									# Gamma
param Disponibilita {MateriePrime};						# Disponibilità di materie
param E := exp(1);										# Nepero

# VARIABILI
var Produzione {Prodotti} >= 0;							# Produzione
var Prezzo {Prodotti} >= 0;								# Prezzo

# VINCOLI
# Massima disponibilità di materie prime
subject to Massimo {mp in MateriePrime}:
	sum {p in Prodotti} Produzione[p] * Composizione[mp,p] <= Disponibilita[mp];
# Definizione del prezzo
subject to DefinizionePrezzo {p in Prodotti}:
	Prezzo[p] = Alpha[p] + Beta[p] * E ^ ( -Gamma[p] * Produzione[p] );

# OBIETTIVO
# Massimizzare i guadagni
maximize z : sum {p in Prodotti} Produzione[p] * Prezzo[p];

##################################################

data;

param NP := 3;

param NMP := 5;

param Composizione:	1	2	3	:=
1 					20 	15 	30
2 					12 	18 	40
3 					25 	21 	30
4 					30 	38 	18
5 					25 	12 	33;

param:	Alpha	Beta	Gamma	:=
1 		50 		50		.8
2 		48 		55		.2
3 		65 		45		.5;

param Disponibilita :=
1	1600
2	1800
3	2200
4	3800
5	1300;

end;
