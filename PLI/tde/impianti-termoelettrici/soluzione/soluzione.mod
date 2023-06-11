# TDE Impianti termoelettrici

# DATI
param NI;											# Numero di impianti
set Impianti := 1 .. NI;							# Impianti
param ProduzioneMinima {Impianti};					# Produzione minima [MWh]
param ProduzioneMassima {Impianti};					# Produzione massima [MWh]
param CostoFisso {Impianti};						# Costo fisso [euro]
param CostoVariabile {Impianti};					# Costo variabile [euro/MWh]
param NG;											# Numero di giorni
set Giorni := 1 .. NG;								# Giorni
param Fabbisogno {Giorni};							# Fabbisogno giornaliero [MW]
param Inizio;										# Inizio manutenzione

# VARIABILI
var Accensione {Giorni, Impianti} binary;			# Accensione impianto [binaria]
var Produzione {Giorni, Impianti};					# Produzione [MW]
var Manutenzione {Giorni} binary;					# Giorni di manutenzione [binaria]

# VINCOLI
# Produzione minima e massima [MWh]
subject to Minimo {g in Giorni, i in Impianti}:
	Produzione[g,i] >= ProduzioneMinima[i] * Accensione[g,i] * 24;
subject to Massimo {g in Giorni, i in Impianti}:
	Produzione[g,i] <= ProduzioneMassima[i] * Accensione[g,i] * 24;
# Fabbisogno richiesto [MW]
subject to FabbisognoGiornaliero {g in Giorni}:
	sum {i in Impianti} Produzione[g,i] >= Fabbisogno[g];
# Giorni di manutenzione [binaria]
subject to GiornoManutenzione1:
	sum {g in Inizio..Inizio+2} Manutenzione[g] = 3;
subject to GiornoManutenzione2:
	sum {g in Giorni} Manutenzione[g] = 3;
# Obbligo spegnimento se sono in manutenzione [binaria]
subject to ObbligoSpegnimento {g in Giorni}:
	Accensione[g,4] <= 1 - Manutenzione[g];

# OBIETTIVO
# Minimizzare i costi [euro]
minimize z : sum {g in Giorni, i in Impianti} ( CostoFisso[i] * Accensione[g,i] + Produzione[g,i] * CostoVariabile[i] );

##################################################

data;

param NI := 5;

param:	ProduzioneMinima	ProduzioneMassima	:=
1		100					650
2		150					600
3		200					500
4		150					400
5		220					500;

param:	CostoFisso	CostoVariabile	:=
1		1900		25
2		1500		32
3		2400		22
4		2000		24
5		2800		15;

param NG := 10;

param Fabbisogno :=
1	45000
2	47000
3	56000
4	52000
5	48000
6	46000
7	51000
8	55000
9	45000
10	35000;

param Inizio := 5;

end;
