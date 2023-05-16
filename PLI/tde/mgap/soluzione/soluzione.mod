# TDE Mgap

# DATI
param NJ;													# Numero di jobs
set Jobs := 1 .. NJ;										# Jobs
param NM;													# Numero di macchine
set Macchine := 1 .. NM;									# Macchine
param NL;													# Numero di livelli
set Livelli := 1 .. NL;										# Livelli
param ConsumiRisorsa {Jobs, Macchine, Livelli};				# Consumi di risorse [tempo]
param Costi {Jobs, Macchine, Livelli};						# Costi [euro]
param Capacita;												# Capacità delle macchine [tempo]

# VARIABILI
var Allocazione {Jobs, Macchine, Livelli} binary;			# Scelta allocazione J-M-L [binaria]

# VINCOLI
# Assegno un job ad una sola macchina [binaria]
subject to JobSingolaMacchina {j in Jobs}:
	sum {m in Macchine, l in Livelli} Allocazione[j,m,l] = 1;
# Assegno un solo livello alla coppia job-macchina [binaria]
# subject to LivelloSingoloSullaCoppia {j in Jobs, m in Macchine}:
# sum {l in Livelli} Allocazione[j,m,l] <= 1;
# Massima capacità di una macchina [tempo]
subject to MassimaCapacitaMacchina {m in Macchine}:
	sum {j in Jobs, l in Livelli} Allocazione[j,m,l] * ConsumiRisorsa[j,m,l] <= Capacita;

# OBIETTIVO
# Minimizzare i costi [euro]
minimize z : sum {j in Jobs, m in Macchine, l in Livelli} Allocazione[j,m,l] * Costi[j,m,l];

##################################################

data;

param NJ := 6;

param NM := 4;

param NL := 2;

param ConsumiRisorsa :=
[1, 1, 1] 5
[1, 2, 1] 7
[1, 3, 1] 8
[1, 4, 1] 10
[2, 1, 1] 6
[2, 2, 1] 9
[2, 3, 1] 10
[2, 4, 1] 5
[3, 1, 1] 7
[3, 2, 1] 8
[3, 3, 1] 13
[3, 4, 1] 7
[4, 1, 1] 15
[4, 2, 1] 12
[4, 3, 1] 16
[4, 4, 1] 13
[5, 1, 1] 2
[5, 2, 1] 1
[5, 3, 1] 3
[5, 4, 1] 2
[6, 1, 1] 8
[6, 2, 1] 9
[6, 3, 1] 7
[6, 4, 1] 8
[1, 1, 2] 8
[1, 2, 2] 12
[1, 3, 2] 13
[1, 4, 2] 15
[2, 1, 2] 11
[2, 2, 2] 20
[2, 3, 2] 14
[2, 4, 2] 8
[3, 1, 2] 14
[3, 2, 2] 12
[3, 3, 2] 17
[3, 4, 2] 13
[4, 1, 2] 18
[4, 2, 2] 14
[4, 3, 2] 18
[4, 4, 2] 16
[5, 1, 2] 5
[5, 2, 2] 4
[5, 3, 2] 7
[5, 4, 2] 5
[6, 1, 2] 11
[6, 2, 2] 13
[6, 3, 2] 13
[6, 4, 2] 14;

param Costi :=
[1, 1, 1] 34
[1, 2, 1] 31
[1, 3, 1] 22
[1, 4, 1] 33
[2, 1, 1] 25
[2, 2, 1] 23
[2, 3, 1] 20
[2, 4, 1] 20
[3, 1, 1] 19
[3, 2, 1] 18
[3, 3, 1] 16
[3, 4, 1] 15
[4, 1, 1] 28
[4, 2, 1] 25
[4, 3, 1] 18
[4, 4, 1] 12
[5, 1, 1] 31
[5, 2, 1] 38
[5, 3, 1] 29
[5, 4, 1] 30
[6, 1, 1] 6
[6, 2, 1] 8
[6, 3, 1] 9
[6, 4, 1] 10
[1, 1, 2] 25
[1, 2, 2] 18
[1, 3, 2] 10
[1, 4, 2] 22
[2, 1, 2] 18
[2, 2, 2] 15
[2, 3, 2] 13
[2, 4, 2] 15
[3, 1, 2] 14
[3, 2, 2] 13
[3, 3, 2] 10
[3, 4, 2] 9
[4, 1, 2] 26
[4, 2, 2] 20
[4, 3, 2] 9
[4, 4, 2] 6
[5, 1, 2] 25
[5, 2, 2] 30
[5, 3, 2] 23
[5, 4, 2] 27
[6, 1, 2] 3
[6, 2, 2] 4
[6, 3, 2] 5
[6, 4, 2] 7;

param Capacita := 20;

end;
