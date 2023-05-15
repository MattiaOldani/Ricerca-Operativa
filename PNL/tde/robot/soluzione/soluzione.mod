# TDE Robot

# DATI
param NR;									# Numero di robot
set Robot := 1 .. NR;						# Robot
param Raggi {Robot};						# Raggio d'azione dei robot [cm]

# VARIABILI
var X {Robot};								# Ascissa dei centri [cm]
var Y {Robot};								# Ordinate dei centri [cm]
var DistanzeCentri {Robot,Robot} >= 0;		# Distanza tra due centri [cm]

# VINCOLI
# Distanze dei centri [cm]
subject to DefinizioneDistanze {r1 in Robot, r2 in Robot : r1 < r2}:
	DistanzeCentri[r1,r2]^2 = (X[r1]^2 - X[r2]^2) + (Y[r1]^2 - Y[r2]^2);
# Non sovrapposizione [cm]
subject to NonSovrapposizione {r1 in Robot, r2 in Robot : r1 < r2}:
	DistanzeCentri[r1,r2] >= Raggi[r1] + Raggi[r2];

# OBIETTIVO
# Minimizzare la distanza
minimize z : sum {r1 in Robot, r2 in Robot : r1 < r2} DistanzeCentri[r1,r2];

##################################################

data;

param NR := 6;

param Raggi :=
1	120
2	80
3	100
4	70
5	45
6	120;

var X :=
1	0
2	500
3	0
4	-500
5	0
6	500;

var Y :=
1	0
2	0
3	500
4	0
5	-500
6	500;

end;
