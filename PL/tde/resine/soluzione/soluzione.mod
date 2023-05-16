# TDE Resine

# DATI
param NP;																						# Numero di prodotti
set Prodotti := 1 .. NP;																		# Prodotti
param NS;																						# Numero di sostanze
set Sostanze := 1 .. NS;																		# Sostanze
param PrezzoVendita {Prodotti};																	# Prezzo di vendita [euro/kg]
param QuantitaSostanze {Prodotti, Sostanze};													# Quantità da usare per 1 kg di prodotto [kg]
param SostanzeDisponibili {Sostanze};															# Sostanze disponibili [kg/giorno]
param ProdottiMassimi {Prodotti};																# Prodotti massimi [kg/giorno]
param ProdottiMinimi {Prodotti};																# Prodotti minimi [kg/giorno]

# VARIABILI
var ProduzioneGiornaliera {p in Prodotti} >= ProdottiMinimi[p], <= ProdottiMassimi[p];			# Produzione giornaliera [kg/giorno]

# VINCOLI
# Sostanze massime disponibili [kg/giorno]
subject to UsoSostanze {s in Sostanze}:
	sum {p in Prodotti} ProduzioneGiornaliera[p] * QuantitaSostanze[p,s] <= SostanzeDisponibili[s];

# OBIETTIVO
# Massimizzare i profitti [euro/giorno]
maximize z : sum {p in Prodotti} ProduzioneGiornaliera[p] * PrezzoVendita[p];

##################################################

data;

param NP := 5;

param NS := 3;

param PrezzoVendita :=
1	300 
2	250
3	600
4	280
5	510;

param QuantitaSostanze:		1	2	3	:=
1							50	20	35 
2							45	28	42 
3							46	42	37 
4							24	31	29 
5							55	25	42;

param SostanzeDisponibili :=
1	4000000
2	3500000
3	3200000;

param:		ProdottiMinimi		ProdottiMassimi		:=
1			10000				36000
2			15000				40000
3			16000				45000
4			15000				32000
5			14000				40000;

end;
