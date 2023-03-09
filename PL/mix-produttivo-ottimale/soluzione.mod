# Mix Produttivo Ottimale

# DATI
set Reparti;									# Reparti
set Modelli;									# Modelli
param Capacita {Reparti};						# Produzione oraria settimanale [h/settimana]
param Profitti {Modelli};						# Profitto unitario [euro/veicolo]
param TempiLavorazione {Reparti,Modelli};		# Tempi di lavorazione [h/veicolo]

# VARIABILI
var x {Modelli} >= 0;							# Modelli da produrre [veicoli/settimana]

# VINCOLI
# Limite alle capacità massime [h/settimana]
subject to ProduzioneMassimaOraria {r in Reparti}:
	sum {m in Modelli} x[m] * TempiLavorazione[r,m] <= Capacita[r];

# OBIETTIVO
maximize profitto : sum {m in Modelli} x[m] * Profitti[m];

##################################################

data;

set Reparti := Motori Carrozzeria A B C;

set Modelli := A B C;

param Capacita :=
Motori			120
Carrozzeria		80
A				96
B				102
C				40;

param Profitti :=
A	840
B	1120
C	1200;

param TempiLavorazione:		A	B	C :=
Motori						3	2	1
Carrozzeria					1	2	3
A							2	0	0
B							0	3	0
C							0	0	2;

end;
