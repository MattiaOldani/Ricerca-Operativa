# TDE Spedizione urgente

# DATI
param NI;											# Numero di imballi
set Imballi := 1 .. NI;								# Imballi
param Peso {Imballi};								# Peso degli imballi [kg]
param Volume {Imballi};								# Volume degli imballi [mc]
param NA;											# Numero di aerei
set Aerei := 1 .. NA;								# Aerei
param PesoMassimo {Aerei};							# Peso massimo [kg]
param VolumeMassimo {Aerei};						# Volume massimo [mc]
param CostoFisso {Aerei};							# Costo fisso [euro]
param CostoVariabilePeso {Aerei};					# Costi variabili peso [euro/kg]
param CostoVariabileVolume {Aerei};					# Costi variabili volume [euro/mc]
param FO;											# FO precedente

# VARIABILI
var Assegnamento {Aerei, Imballi} binary;			# Assegnamento [binaria]
var Spese >= 0;										# Spese [euro]

# VINCOLI
# Non eccedo il peso di ogni aereo [kg]
subject to PesoMassimoPerAereo {a in Aerei}:
	sum {i in Imballi} Assegnamento[a,i] * Peso[i] <= PesoMassimo[a];
# Non eccedo il volume di ogni aereo [mc]
subject to VolumeMassimoPerAereo {a in Aerei}:
	sum {i in Imballi} Assegnamento[a,i] * Volume[i] <= VolumeMassimo[a];
# Ogni imballo va al massimo su un aereo
subject to MassimoAssegnamento {i in Imballi}:
	sum {a in Aerei} Assegnamento[a,i] <= 1;
# Definizione delle spese [euro]
subject to DefinizioneSpese:
	Spese = sum {a in Aerei} ( CostoFisso[a] +
							   ( CostoVariabilePeso[a] * sum {i in Imballi} Assegnamento[a,i] * Peso[i] ) +
							   ( CostoVariabileVolume[a] * sum {i in Imballi} Assegnamento[a,i] * Volume[i] )
							 );
# Ho il numero di imballi trovati precedentemente
subject to ImballiCaricati:
	sum {a in Aerei, i in Imballi} Assegnamento[a,i] = FO;

# OBIETTIVO
# Massimizzare gli imballi in aereo
# maximize z : sum {a in Aerei, i in Imballi} Assegnamento[a,i];
# Minimizzare il costo complessivo [euro]
minimize z : Spese;

##################################################

data;

param NI := 12;

param:	Peso	Volume	:=
1 400 9
2 250 12
3 70 8
4 1000 20
5 550 15
6 810 25
7 320 15
8 125 26
9 480 18
10 225 4
11 250 3
12 400 23;

param NA := 2;

param:	PesoMassimo		VolumeMassimo	CostoFisso	CostoVariabilePeso	CostoVariabileVolume	:=
1 2900 90 2000 8 2
2 1950 100 1500 5 3;

param FO := 11;

end;
