# TDE Depositi e hubs

# DATI
param ND;																						# Numero di depositi
set Depositi := 1 .. ND;																		# Depositi
param NH;																						# Numero di hubs
set Hubs := 1 .. NH;																			# Hubs
param XD {Depositi};																			# Ascissa deposito
param YD {Depositi};																			# Ordinata deposito
param PrimoPeso;																				# Primo peso
param SecondoPeso;																				# Secondo peso

# VARIABILI
var XH {Hubs};																					# Ascissa hub
var YH {Hubs};																					# Ordinata hub
var Assegnamento {Hubs, Depositi} binary;														# Assegnamento hub-deposito
var DistanzaHD {h in Hubs, d in Depositi} = sqrt( (XH[h]-XD[d])^2 + (YH[h]-YD[d])^2 );			# Distanza hub-deposito
var DistanzaHH {h1 in Hubs, h2 in Hubs} = sqrt( (XH[h1]-XH[h2])^2 + (YH[h1]-YH[h2])^2 );		# Distanza hub-hub
var OB1 >= 0;																					# Primo obiettivo
var OB2 >= 0;																					# Secondo obiettivo

# VINCOLI
# Ogni hub ha assegnato un solo deposito
subject to singoloDeposito {h in Hubs}:
	sum {d in Depositi} Assegnamento[h,d] = 1;
# Definizione primo obiettivo
subject to DefinizioneOB1:
	OB1 = sum {h in Hubs, d in Depositi} Assegnamento[h,d] * DistanzaHD[h,d];
# Definizione secondo obiettivo
subject to DefinizioneOB2:
	OB2 = sum {h1 in Hubs, h2 in Hubs : h1 < h2} DistanzaHH[h1,h2]; 

# OBIETTIVO
# Minimizzare una combinazione lineare di due obiettivi
# OB1: minimizzare la distanza tra hub e il deposito più vicino
# OB2: minimizzare la distanza tra coppie di hub
minimize z : PrimoPeso * OB1 + SecondoPeso * OB2;

##################################################

data;

param ND := 12;

param NH := 4;

param:	XD	YD	:=
1		120	80
2		250	130
3		325	400
4		80	750
5		200	155
6		135	75
7		720	840
8		40	910
9		110	30
10		240	400
11		350	410
12		670	760;

param PrimoPeso := .7;

param SecondoPeso := .3;

var:	XH	YH	:=
1		150	200
2		300	400
3		450	600
4		600	800;

end;
