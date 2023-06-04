# TDE Noleggio auto

# DATI
param NG;											# Numero di giorni
set Giorni := 1 .. NG;								# Giorni
param NO;											# Numero di ordini
set Ordini := 1 .. NO;								# Ordini
param GiornoInizio {Ordini};						# Giorno di inizio
param GiornoFine {Ordini};							# Giorno di fine
param Automobili;									# Numero di automobili
param QuotaFissa;									# Quota fissa [euro]
param QuotaVariabile;								# Quota variabile [euro/giorno]

# VARIABILI
var Selezione {Ordini} binary;						# Ordini selezionati
var GiorniOccupati {Ordini, Giorni} binary;			# Giorni occupati da ogni ordine

# VINCOLI
# Definizione dei giorni occupati
subject to DefinizioneGiorniOccupati {o in Ordini, g in GiornoInizio[o]..GiornoFine[o]}:
	GiorniOccupati[o,g] = Selezione[o];
# In ogni giorno posso noleggiare al massimo 4 automobili
subject to DisponibilitaAutomobili {g in Giorni}:
	sum {o in Ordini} GiorniOccupati[o,g] <= Automobili;

# OBIETTIVO
# Massimizzare i profitti [euro]
maximize z : sum {o in Ordini} ( Selezione[o] * ( QuotaFissa + QuotaVariabile * (GiornoFine[o] - GiornoInizio[o] + 1) ) );

##################################################

data;

param NG := 35;

param NO := 31;

param:	GiornoInizio	GiornoFine	:=
1		2		5
2		2		10
3		2		12
4		2		13
5		3		8
6		3		24
7		5		7
8		5		15
9		7		12
10		7		14
11		7		28
12		10		15
13		12		19
14		14		26
15		14		30
16		16		20
17		16		27
18		16		33
19		18		30
20		21		22
21		21		26
22		25		25
23		25		26
24		25		30
25		28		30
26		29		34
27		29		35
28		30		30
29		30		32
30		30		34
31		30		35;

param Automobili := 4;

param QuotaFissa := 20;

param QuotaVariabile := 40;

end;
