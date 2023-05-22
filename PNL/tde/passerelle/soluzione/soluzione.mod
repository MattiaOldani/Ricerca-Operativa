# TDE Passerelle

# DATI
param NV;																													# Numero vicoli
set Vicoli := 1 .. NV;																										# Vicoli
param XVicoli {Vicoli};																										# Ascissa vicoli
param YVicoli {Vicoli};																										# Ordinata vicoli
param NP;																													# Numero piattaforme
set Piattaforme := 1 .. NP;																									# Piattaforme

# VARIABILI
var XPiattaforme {Piattaforme};																								# Ascissa piattaforma
var YPiattaforme {Piattaforme};																								# Ordinata piattaforma
var Assegnamento {Vicoli, Piattaforme} binary;																				# Assegnamento [binaria]
var DistanzePV {v in Vicoli} =
	sum {p in Piattaforme} Assegnamento[v,p] * sqrt( (XVicoli[v]-XPiattaforme[p])^2 + (YVicoli[v]-YPiattaforme[p])^2 );		# Distanze PV
var DistanzePP {p in Piattaforme : p > 1} =
	sqrt( (XPiattaforme[p]-XPiattaforme[p-1])^2 + (YPiattaforme[p]-YPiattaforme[p-1])^2 );									# Distanze PP

# VINCOLI
# Assegnamento vicolo-piattaforma
subject to DefinizioneAssegnamento {v in Vicoli}:
	sum {p in Piattaforme} Assegnamento[v,p] = 1;

# OBIETTIVO
# Minimizzare le distanze PP e PV
# Garantisco anche il cammino con gli indici
minimize z : sum {p in Piattaforme : p > 1} DistanzePP[p] + sum {v in Vicoli} DistanzePV[v];

##################################################

data;

param NV := 10;

param:	XVicoli		YVicoli	:=
1		0			1
2		0			3
3		3			7
4		5			9
5		9			9
6		11			8
7		11			7
8		11			4
9		8			1
10		6			1;

var:	XPiattaforme	YPiattaforme	:=
1		3				5
2		6				5
3		9				5;

param NP := 3;

end;
