# TDE Vigneto

# DATI
set Vitigni;																			# Vitigni
param Resa {Vitigni};																	# Resa [litri/mq]
param PrezzoVendita {Vitigni};															# Prezzo vendita [euro/litro]
param MinimaProduzione {Vitigni};														# Minima produzione [litri]
param MassimaProduzione {Vitigni};														# Massima produzione [litri]
param VitigniDisponibili {Vitigni};														# Terreno disponibile [mq]

# VARIABILI
var TerrenoColtivato {v in Vitigni} >= 0, <= VitigniDisponibili[v];						# Coltivazione [mq]
var Produzione {v in Vitigni} >= MinimaProduzione[v], <= MassimaProduzione[v];			# Produzione vino [litri]

# VINCOLI
# Massima TerrenoColtivato [litri]
subject to DefinizioneProduzione {v in Vitigni}:
	Produzione[v] = TerrenoColtivato[v] * Resa[v];
# 3:1 tra aree diverse
subject to Rapporto_3_1 {v1 in Vitigni, v2 in Vitigni : v1 <> v2}:
	TerrenoColtivato[v1] <= 3 * TerrenoColtivato[v2];
# 4:1 tra produzioni diverse
subject to Rapporto_4_1 {v1 in Vitigni, v2 in Vitigni : v1 <> v2}:
	Produzione[v1] <= 4 * Produzione[v2];

# OBIETTIVO
# Massimizzare i ricavi [euro]
maximize z : sum {v in Vitigni} TerrenoColtivato[v] * Resa[v] * PrezzoVendita[v];

##################################################

data;

set Vitigni := Silvaner Riesling Pinot Mueller_Thurgau Merlot;

param Resa :=
Silvaner 1.2
Riesling 0.9
Pinot 1.0
Mueller_Thurgau 0.8
Merlot 1.4;

param PrezzoVendita :=
Silvaner 4.50
Riesling 5.00
Pinot 4.00
Mueller_Thurgau 3.00
Merlot 3.50;

param:	MinimaProduzione	MassimaProduzione	:=
Silvaner 150000 1500000
Riesling 200000 1200000
Pinot 100000 950000
Mueller_Thurgau 150000 800000
Merlot 100000 1500000;

param VitigniDisponibili :=
Silvaner 950000
Riesling 1250000
Pinot 950000
Mueller_Thurgau 1000000
Merlot 850000;

end;
