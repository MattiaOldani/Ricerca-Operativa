# TDE Tulipani

# DATI
set Tulipani;										# Tulipani
param Base;											# Base [m]
param Altezza;										# Altezza [m]
param LarghezzaMinima;								# Larghezza minima striscia [m]
param EsportazioneMinima {Tulipani};				# Esportazione minima [%]
param EsportazioneMassima {Tulipani};				# Esportazione massima [%]
param AcquaNecessaria {Tulipani};					# Acqua per mq di campo [mc]
set Concimi;										# Concimi
param ConcimiNecessari {Tulipani, Concimi};			# Concime per mq di campo [kg]
param AcquaDisponibile;								# Acqua disponibile [mc]
param ConcimiDisponibili {Concimi};					# Concimi disponibili [kg]
param PrezzoVenditaNazionale {Tulipani};			# Prezzo di vendita nazionale [euro/mq]
param PrezzoVenditaEsportato {Tulipani};			# Prezzo di vendita esportato [euro/mq]

# VARIABILI
var Strisce {Tulipani} >= LarghezzaMinima;			# Grandezza striscia [m]
var AreaEsportato {Tulipani} >= 0;					# Area esportata [m^2]
var AreaNazionale {Tulipani} >= 0;					# Area nazionale [m^2]

# VINCOLI
# Lunghezza totale del campo [m]
subject to Lunghezza:
	sum {t in Tulipani} Strisce[t] <= Base;
# Rispetto minima e massima esportazione [mq]
subject to MinimaEsportazione {t in Tulipani}:
	AreaEsportato[t] * 100 >= EsportazioneMinima[t] * Strisce[t] * Altezza;
subject to MassimaEsportazione {t in Tulipani}:
	AreaEsportato[t] * 100 <= EsportazioneMassima[t] * Strisce[t] * Altezza;
# Acqua disponibile [mc]
subject to Acqua:
	sum {t in Tulipani} Strisce[t] * Altezza * AcquaNecessaria[t] <= AcquaDisponibile;
# Concimi disponibili [kg]
subject to Concime {c in Concimi}:
	sum {t in Tulipani} Strisce[t] * Altezza * ConcimiNecessari[t,c] <= ConcimiDisponibili[c];
# Area nazionale [mq]
subject to DefinizioneAreaNazionale {t in Tulipani}:
	AreaNazionale[t] = Strisce[t] * Altezza - AreaEsportato[t];

# OBIETTIVO
# Massimizzare i ricavi [euro]
maximize z : sum {t in Tulipani} ( PrezzoVenditaNazionale[t] * AreaNazionale[t] +
								   PrezzoVenditaEsportato[t] * AreaEsportato[t] );

##################################################

data;

set Tulipani := A B C D E;

param Base := 100;

param Altezza := 50;

param LarghezzaMinima := 5;

param:	EsportazioneMinima	EsportazioneMassima		:=
A       10   40
B       15   60
C        5   75
D       50  100
E        0   50;

set Concimi := A B;

param AcquaNecessaria :=
A	4
B	3
C	8.5
D	1
E	2.5;

param ConcimiNecessari:		A	B	:=
A	1.2             0.5
B	1.5             0.4
C	0.3             1.3
D	2.8             1.0
E	1.9             0.8;

param AcquaDisponibile := 30000;

param ConcimiDisponibili :=
A	3000
B	5000;

param PrezzoVenditaNazionale :=
A	60
B	80
C	120
D	75
E	80;

param PrezzoVenditaEsportato :=
A	90
B	110
C	155
D	100
E	85;

end;
