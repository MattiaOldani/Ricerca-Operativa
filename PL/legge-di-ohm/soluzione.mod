# Legge di Ohm

# DATI
param nS;								# Numero studenti
set Studenti := 1..nS;					# Studenti
param Tensione {Studenti};				# Tensione [Volt]
param Corrente {Studenti};				# Corrente [mAmpere]

# VARIABILI
var errore {Studenti};					# Errore di misura [Volt]
var resistenza;							# Resistenza [kOhm]
var aux1;								# Ausiliaria per z1 [Volt]
var aux2;								# Ausiliaria per z2 [Volt]
var aux3 {Studenti};					# Ausiliaria per z3 [Volt]
var aux4;								# Ausiliaria per z4 [Volt]

# VINCOLI
# Errore sulla corrente [Volt]
subject to DefinizioneErrore {s in Studenti}:
	errore[s] = Tensione[s] - ( resistenza*Corrente[s] );

# OBIETTIVO
# Minimizzare il massimo errore in valore assoluto [Volt]
# minimize z1 : aux1;
# subject to MinMax1 {s in Studenti}:
# 	aux1 >= errore[s];
# subject to MinMax2 {s in Studenti}:
#	aux1 >= -errore[s];

# Minimizzare il valore assoluto del valore medio degli errori [Volt] 
# minimize z2 : aux2;
# subject to Assoluto1:
# 	aux2 >= sum {s in Studenti} errore[s] / card(Studenti);
# subject to Assoluto2:
# 	aux2 >= - sum {s in Studenti} errore[s] / card(Studenti);

# Minimizzare il valore medio del valore assoluto degli errori [Volt]
# minimize z3 : sum {s in Studenti} aux3[s] / card(Studenti);
# subject to Assoluto1 {s in Studenti}:
# 	aux3[s] >= errore[s];
# subject to Assoluto2 {s in Studenti}:
# 	aux3[s] >= - errore[s];

# Minimizzare l'errore quadratico medio [Volt]
# Non riusciamo a linearizzarlo in maniera semplice
# minimize z4 : sum {s in Studenti} (-2*Corrente[s] / card(Studenti));

##################################################

data;

param nS := 12;

param Tensione :=
1	18.3
2	20.5
3	32.2
4	12.2
5	10.1
6	22.6
7	30.1
8	28
9	23.4
10	15.5
11	14.7
12	15.4;

param Corrente :=
1	12.2
2	14.1
3	21.9
4	8.4
5	6.7
6	15
7	20.3
8	18.5
9	15.8
10	10
11	10.4
12	10;

end;
