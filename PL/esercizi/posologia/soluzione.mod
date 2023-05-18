# Posologia

# DATI
param NFO;																						# Numero di fasce orarie
set FasceOrarie := 0 .. NFO-1;																	# Fasce orarie
param ProteineMinime {FasceOrarie};																# Proteine minime [mg/cc]
param ProteineMassime;																			# Proteine massime [mg/cc]
param NF;																						# Numero di farmaci
set Farmaci := 1 .. NF;																			# Farmaci
param ProteinaProdotta {FasceOrarie, Farmaci} default 0;										# Produzione proteica per g assunti [mg/cc]
param PrezzoFarmaci {Farmaci};																	# Prezzo dei farmaci [euro/g]

# VARIABILI
var AssunzioneFarmaci {FasceOrarie, Farmaci} >= 0;												# Farmaci assunti in un dato istante [g]
var ProteineInCircolo {fo in FasceOrarie} >= ProteineMinime[fo], <= ProteineMassime;			# Proteine in circolo in un dato istante [mg/cc]

# VINCOLI
# Calcolo delle proteine in circolo [mg/cc]
subject to CalcoloProteine {fo1 in FasceOrarie}:
	sum {fo2 in FasceOrarie, f in Farmaci : fo2 <= fo1} AssunzioneFarmaci[fo2,f] * ProteinaProdotta[fo1-fo2,f] = ProteineInCircolo[fo1];

# OBIETTIVO
# Minimizzare i grammi di farmaci assunti [g]
minimize z : sum {fo in FasceOrarie, f in Farmaci} AssunzioneFarmaci[fo,f];
# Minimizzare il costo dei farmaci assunti [euro]
# minimize z : sum {fo in FasceOrarie, f in Farmaci} AssunzioneFarmaci[fo,f] * PrezzoFarmaci[f];

##################################################

data;

param NFO := 24;

param ProteineMinime :=
0	5
1	1
2	0
3	0
4	0
5	0
6	4
7	15
8	12
9	5
10	4
11	3
12	25
13	30
14	25
15	15
16	5
17	4
18	3
19	25
20	30
21	25
22	20
23	10;

param ProteineMassime := 45;

param NF := 2;

param ProteinaProdotta:		1	2	:=
0							1.5	2.5
1							3	4
2							4	5.5
3							2.5	4
4							1.9	3
5							1.4	1.5
6							1	.7
7							.7	.4
8							.5	.2
9							.3	0
10							.2	0
11							.1	0;

param PrezzoFarmaci :=
1	.7
2	.95;

end;
