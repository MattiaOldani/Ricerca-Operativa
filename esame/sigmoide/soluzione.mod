# Sigmoide

# DATI
param NP;								# Numero di punti osservati
set Punti := 1 .. NP;					# Insieme dei punti osservati
param XP {Punti};						# Ascisse dei punti osservati [a scelta]
param YP {Punti};						# Ordinate dei punti osservati [a scelta]
param E := exp(1);						# Numero di nepero

# VARIABILI
var K;									# Coefficiente di scalatura
var S;									# Coefficiente di traslazione sulle ascisse
var T;									# Coefficiente di traslazione sulle ordinate
var Errore {Punti};						# Errore, calcolato come differenza tra f(x) e y associata alla x [a scelta]
var MinMax;								# Variabile ausiliaria per MinMax nell'obiettivo 1 [a scelta]
var ErrorePositivo {Punti};				# Errore positivo, da utilizzare nell'obiettivo 2 [a scelta]

# VINCOLI
# Definizione dell'errore come differenza tra f(x) e la y associata alla x [a scelta]
subject to DefinizioneErrore {p in Punti}:
	Errore[p] = ( K * ( E^(XP[p]+S) / ( 1 + E^(XP[p]+S) ) ) + T ) - YP[p];
# Definizione degli errori positivi per l'obiettivo 2 [a scelta]
subject to DefinizioneErrorePositivo1 {p in Punti}:
	ErrorePositivo[p] >= Errore[p];
subject to DefinizioneErrorePositivo2 {p in Punti}:
	ErrorePositivo[p] >= -Errore[p];

# OBIETTIVO 1
# Minimizzare il massimo errore in valore assoluto [a scelta]
minimize z : MinMax;
subject to VincoloMinMax1 {p in Punti}:
	MinMax >= Errore[p];
subject to VincoloMinMax2 {p in Punti}:
	MinMax >= -Errore[p];

# OBIETTIVO 2
# Minimizzare la somma degli errori in valore assoluto [a scelta]
# minimize z : sum {p in Punti} ErrorePositivo[p];

# OBIETTIVO 3
# Minimizzare l’errore quadratico medio [a scelta, ma elevato alla seconda]
# minimize z : sum {p in Punti} Errore[p]^2 / card(Punti);

##################################################

data;

param NP := 12;

param:	XP	YP	:=
 1	 2	28
 2	 1	20
 3	 8	40
 4	 5	36
 5	-6	16
 6	-2	16
 7	 0	16
 8	-3	16
 9	 7	40
10	 6	40
11	-4	16
12	 3	32;

end;
