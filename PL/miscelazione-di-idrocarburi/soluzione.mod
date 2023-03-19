# Miscelazione di Idrocarburi

# DATI
set Sostanze;                                       # Sostanze
set Benzine;                                        # Benzine
param minimePercentuali {Sostanze, Benzine};        # Percentuali minime [adimensionale]
param massimePercentuali {Sostanze, Benzine};       # Percentuali massime [adimensionale]
param sostanzeDisponibili {Sostanze};               # Sostanze disponibili [barili/giorno]
param costiSostanze {Sostanze};                     # Costi sostanze [dollari/barile]
param profittiBenzine {Benzine};                    # Profitti benzine [dollari/barile]

# VARIABILI
var x {Sostanze, Benzine} >= 0;						# Barili di sostanza usata per benzina [barili/giorno]

# VINCOLI
# Percentuali minime [barili/giorno]
subject to Minimo {s in Sostanze, b in Benzine}:
	x[s,b] >= ( sum {s1 in Sostanze} x[s1,b] ) * minimePercentuali[s,b];
# Percentuali massime [barili/giorno]
subject to Massimo {s in Sostanze, b in Benzine}:
	x[s,b] <= ( sum {s1 in Sostanze} x[s1,b] ) * massimePercentuali[s,b];
# Risorse disponibili [barili/giorno]
subject to Disponibilita {s in Sostanze}:
	sum {b in Benzine} x[s,b] <= sostanzeDisponibili[s];

# OBIETTIVO
# Massimizzare i profitti [dollari/giorno]
maximize z : ( sum {b in Benzine} ( sum {s in Sostanze} x[s,b] ) * profittiBenzine[b] )
		   - ( sum {s in Sostanze, b in Benzine} x[s,b] * costiSostanze[s] );

##################################################

data;

set Sostanze := A B C D;

set Benzine := super normale verde;

param minimePercentuali:    super   normale     verde :=
A                           0       0           0
B                           .4      .1          0
C                           0       0           0
D                           0       0           0;

param massimePercentuali:   super   normale     verde :=
A                           .3      .5          .7
B                           1       1           1
C                           .5      1           1
D                           1       1           1;

param sostanzeDisponibili :=
A   3000
B   2000
C   4000
D   1000;

param costiSostanze :=
A   3
B   6
C   4
D   5;

param profittiBenzine :=
super       5.5
normale     4.5
verde       3.5;

end;
