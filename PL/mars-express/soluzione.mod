# Mars Express

# DATI
set Orbite := 1 .. 10;							# Orbite
set Memorie := 1 .. 5;							# Memorie
param DatiIngresso {Orbite, Memorie};			# Dati in ingresso [Mbit]
param DurataOrbite {Orbite};					# Durata delle orbite [minuti]
param VelocitaTrasmissione;						# Velocità di trasmissione [Mbit/minuto]
param Capacita {Memorie};						# Capcità delle memorie [Mbit]
param SpazioIniziale {Memorie};					# Spazio iniziale delle memorie [Mbit]

# VARIABILI
var x {Orbite, Memorie} >= 0;					# Memoria trasmessa prima della lettura dei nuovi dati [Mbit]
var y {Orbite, Memorie} >= 0;					# Memoria mantenuta alla fine della lettura dei nuovi dati [Mbit]
var z {Orbite, Memorie} >= 0;					# Memoria mantenuta dopo la trasmissione e prima della lettura [Mbit]
var aux;										# Variabile ausiliaria per la MinMax [adimensionale]

# VINCOLI
# Massima trasmissione per orbita [Mbit]
subject to MassimaTrasmissione {o in Orbite}:
	sum {m in Memorie} x[o,m] <= DurataOrbite[o] * VelocitaTrasmissione;
# Massima capacità [Mbit]
subject to MassimaCapacita {o in Orbite, m in Memorie}:
	y[o,m] <= Capacita[m];
# Conservazione del flusso1 [Mbit]
subject to Flusso1 {o in Orbite, m in Memorie : o > 1}:
	y[o-1,m] = x[o,m] + z[o,m];
# Conservazione del flusso2 [Mbit]
subject to Flusso2 {o in Orbite, m in Memorie}:
	z[o,m] + DatiIngresso[o,m] = y[o,m];
# Conservazione del flusso3 [Mbit]
subject to Flusso3 {m in Memorie}:
	SpazioIniziale[m] = x[1,m] + z[1,m];

# OBIETTIVO
# Minimizzare il massimo livello di riempimento [adimensionale]
minimize ob : aux;
subject to MinMax {o in Orbite, m in Memorie}:
	aux >= y[o,m] / Capacita[m];

##################################################

data;

param DatiIngresso:		1	2	3	4	5 :=
1						35	0	80	25	50
2						200	70	100	25	0
3						0	150	0	25	100
4						600	300	0	25	75
5						200	0	210	25	200
6						50	0	85	0	45
7						40	60	50	0	300
8						300	90	20	60	0
9						0	100	100	60	20
10						0	20	100	60	250;

param DurataOrbite :=
1	45
2	47
3	55
4	45
5	35
6	42
7	30
8	35
9	44
10	40;

param VelocitaTrasmissione := 9;

param Capacita :=
1	1000
2	1200
3	1000
4	500
5	700;

param SpazioIniziale :=
1	500
2	600
3	500
4	250
5	350;

end;
