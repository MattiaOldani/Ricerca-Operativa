# TDE Zoo

# DATI
param NA;															# Numero di animali
set Animali := 1 .. NA;												# Animali
param NumeroAnimali {Animali};										# Animali disponibili [adimensionale]
param NSN;															# Numero di sostanza nutritive
set SostanzeNutritive := 1 .. NSN;									# Sostanze nutritive
param NP;															# Numero di prodotti
set Prodotti := 1 .. NP;											# Prodotti
param ComposizioneProdotti {SostanzeNutritive, Prodotti};			# Compisizione percentuale dei prodotti [%]
param FabbisognoGiornaliero {Animali, SostanzeNutritive};			# Quantità di nutrienti per esemplare [kg]
param CostiProdotti {Prodotti};										# Costi dei prodotti [euro/kg]

# VARIABILI
var ProdottiAcquistati {Prodotti} >= 0;								# Prodotti acquistati [kg]

# VINCOLI
# Soddisfare il fabbisogno giornaliero [kg]
subject to Soddisfazione {a in Animali, sn in SostanzeNutritive}:
	sum {p in Prodotti} ProdottiAcquistati[p] * ComposizioneProdotti[sn,p] >= NumeroAnimali[a] * FabbisognoGiornaliero[a,sn] * 100;

# OBIETTIVO
# Minimizzare i costi di acquisto dei prodotti [euro]
minimize z : sum {p in Prodotti} ProdottiAcquistati[p] * CostiProdotti[p];

##################################################

data;

param NA := 20;

param NumeroAnimali :=
1	1
2	2
3	1
4	1
5	1
6	8
7	1
8	1
9	3
10	2
11	2
12	1
13	1
14	8
15	1
16	6
17	1
18	4
19	4
20	2;

param NSN := 8;

param NP := 4;

param ComposizioneProdotti:		1	2	3	4	:=
1								80	5	0	25
2								0	5	0	0
3								0	25	30	5
4								5	40	25	10
5								5	0	0	0
6								0	0	0	15
7								0	0	25	0
8								10	25	20	45;

param FabbisognoGiornaliero:	1	2	3	4	5	6	7	8	:=
1								0	0	0	2	.2	.5	1	3
2								1	1	3	.3	.2	.2	0	2
3								.1	.5	.1	1	.1	.3	0	4
4								.5	.5	1	.5	.1	.5	.5	5
5								0	.5	5	9	.5	1	1	9
6								0	0	0	0	0	0	.1	.1
7								0	0	.2	3	0	0	0	4
8								0	0	8	6	.5	1	0	20
9								0	1	1	1	0	0	.2	.5
10								5	0	0	0	1	.5	0	5
11								0	1	0	5	0	0	0	3
12								0	0	0	0	0	0	3	0
13								5	.5	3	1	0	0	0	10
14								0	0	0	0	0	0	.2	.5
15								1	0	0	12	0	2	0	15
16								.5	0	0	.1	0	0	0	.1
17								0	.2	1	9	.2	.5	0	6
18								0	0	0	.5	.1	0	.5	1
19								0	.2	.5	3	0	0	1	1
20								0	0	0	5	.5	.2	.5	5;

param CostiProdotti :=
1	5
2	2
3	3
4	4;

end;
