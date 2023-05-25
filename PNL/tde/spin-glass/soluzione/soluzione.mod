# TDE Spin glass

# DATI
param NP;													# Numero di particelle
set Particelle := 1 .. NP;									# Particelle
param EnergiaInterazione {Particelle,Particelle};			# Energia di interazione tra particelle
param CampoMagnetico {Particelle};							# Campo magnetico

# VARIABILI
var Spin {Particelle} binary;								# Spin delle particelle [1 o 0]
var Trasformazione {Particelle};							# Trasformazione dello spin [1 o -1]

# VINCOLI
# Trasformazione dello spin
subject to ApplicoTrasformazione {p in Particelle}:
	Trasformazione[p] = 2 * Spin[p] - 1;

# OBIETTIVO
# Minimizzare lo spin
maximize z : sum {p1 in Particelle, p2 in Particelle : p1 < p2} EnergiaInterazione[p1,p2] * Trasformazione[p1] * Trasformazione[p2]
		   + sum {p in Particelle} CampoMagnetico[p] * Trasformazione[p];

##################################################

data;

param NP := 9;

param EnergiaInterazione:	1	2	3	4	5	6	7	8	9	:=
1							3	-1	-4	5	-8	4	-2	-3	-1
2 							-1	-2	2	-4	7	-1	2	-2	2
3 							-4	2	-3	-3	-3	5	-2	-1	-3
4 							5	-4	-3	2	-1	-2	-2	-2	-7
5 							-8	7	-3	-1	3	-7	7	-2	8
6 							4	-1	5	-2	-7	-5	3	-3	-1
7 							-2	2	-2	-2	7	3	-1	9	-5
8 							-3	-2	-1	-2	-2	-3	9	1	9
9 							-1	2	-3	-7	8	-1	-5	9	-6;

param CampoMagnetico :=
1	1
2	2
3	2
4	9
5	1
6	9
7	1
8	8
9	2;

end;
