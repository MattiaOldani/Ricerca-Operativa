# TDE Hong Kong

# DATI
param NA;												# Numero di appuntamenti
set Appuntamenti := 1 .. NA;							# Appuntamenti
param PuntiConsumati {Appuntamenti};					# Punti consumati
param ValoreAffare {Appuntamenti};						# Valore affare
param PuntiTotali;										# Punti totali

# VARIABILI
var AppuntamentiScelti {Appuntamenti} binary;			# Appuntamenti scelti [binaria]
var UltimoAppuntamento {Appuntamenti} binary; 			# Ultimo appuntamento [binaria]

# VINCOLI
# Ho un solo ultimo appuntamento [binaria]
subject to Singolo:
	sum {a in Appuntamenti} UltimoAppuntamento[a] = 1;
# Se un appuntamento è scelto non è ultimo [binaria]
subject to NoUltimo {a1 in Appuntamenti}:
	sum {a2 in Appuntamenti : a2 <= a1} UltimoAppuntamento[a2] <= 1 - AppuntamentiScelti[a1];
# Punti massimi spendibili
subject to PuntiMassimiSpendibili:
	sum {a in Appuntamenti} AppuntamentiScelti[a] * PuntiConsumati[a] <= PuntiTotali - 1;

# OBIETTIVO
# Massimizzare il valore degli affari
maximize z : sum {a in Appuntamenti} (AppuntamentiScelti[a] + UltimoAppuntamento[a]) * ValoreAffare[a];

##################################################

data;

param NA := 20;

param:	PuntiConsumati	ValoreAffare	:=
1		200				112
2		180				105
3		165				104
4		141				99
5		138				97
6		130				90
7		122				81
8		115				78
9		109				66
10		104				58
11		90				55
12		79				52
13		61				50
14		50				43
15		42				41
16		34				37
17		27				35
18		20				33
19		12				30
20		9				25;

param PuntiTotali := 850;

end;
