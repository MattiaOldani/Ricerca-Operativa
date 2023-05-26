# TDE Rover

# DATI
param NS;												# Numero di siti
set Siti := 1 .. NS;									# Siti
param TempiSpostamento {Siti, Siti};					# Tempi di spostamento [min]
param TempiEsplorazione {s in Siti : s <> 7};			# Tempi di esplorazione [min]
param CostoEsplorazione {s in Siti : s <> 7};			# Costi di esplorazione [joule]
param ValoreAtteso {s in Siti : s <> 7};				# Valore atteso di un sito [adimensionale]
param ConsumoSpostamento;								# Consumo energetico spostamento [joule/min]
param EnergiaDisponibile;								# Energia disponibile [joule]
param TempoDisponibile;									# Tempo disponibile [min]

# VARIABILI
var SitiVisitati {s in Siti : s <> 7} binary;			# Siti visitati [binaria]
var SpostamentiEffettuati {Siti, Siti} binary;			# Spostamenti effettuati [binaria]

# VINCOLI
# Se visito un sito s1 ci deve essere uno spostamento da s2 a s1
subject to HoVisitatoIlSito {s1 in Siti : s1 <> 7}:
	SitiVisitati[s1] = sum {s2 in Siti} SpostamentiEffettuati[s2,s1];
# Da un sito s1 mi sposto al massimo in un altro sito s2
subject to SingoloSpostamento {s1 in Siti}:
	sum {s2 in Siti : s2 <> 7} SpostamentiEffettuati[s1,s2] <= 1;
# Non visito il sito di partenza
subject to EvitarePartenza:
	sum {s in Siti} SpostamentiEffettuati[s,7] = 0;
# Non visito me stesso da me stesso
subject to EvitareMeStesso {s in Siti}:
	SpostamentiEffettuati[s,s] = 0;
# Non torno indietro su un sito già visitato
subject to NonRitorno {s1 in Siti, s2 in Siti : s1 < s2}:
	SpostamentiEffettuati[s1,s2] + SpostamentiEffettuati[s2,s1] <= 1;
# Massimo tempo disponibile [min]
subject to MassimoTempoDisponibile:
	sum {s1 in Siti, s2 in Siti} SpostamentiEffettuati[s1,s2] * TempiSpostamento[s1,s2] +
	sum {s3 in Siti : s3 <> 7} SitiVisitati[s3] * TempiEsplorazione[s3] <= TempoDisponibile;
# Massima energia disponibile [joule]
subject to MassimaEnergiaDisponibile:
	sum {s1 in Siti, s2 in Siti} SpostamentiEffettuati[s1,s2] * TempiSpostamento[s1,s2] * ConsumoSpostamento +
	sum {s3 in Siti : s3 <> 7} SitiVisitati[s3] * CostoEsplorazione[s3] <= EnergiaDisponibile;

# OBIETTIVO
# Massimizzare il valore atteso dei siti visitati [adimensionale]
maximize z : sum {s in Siti : s <> 7} SitiVisitati[s] * ValoreAtteso[s];

##################################################

data;

param NS := 7;

param TempiSpostamento:		1	2	3	4	5	6	7	:=
1 0 13 14 16 13 13 13
2 13 0 15 14 16 14 11
3 14 15 0 15 18 13 17
4 16 14 15 0 17 16 18
5 13 16 18 17 0 18 15
6 13 14 13 16 18 0 15
7 13 11 17 18 15 15 0;

param TempiEsplorazione :=
1 35
2 20
3 40
4 60
5 25
6 10;

param CostoEsplorazione :=
1 60
2 45
3 70
4 110
5 50
6 25;

param ValoreAtteso :=
1 90
2 50
3 20
4 100
5 120
6 50;

param ConsumoSpostamento := 8;

param EnergiaDisponibile := 1000;

param TempoDisponibile := 400;

end;
