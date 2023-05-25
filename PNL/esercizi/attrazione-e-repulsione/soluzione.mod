# Attrazione e repulsione

# DATI
param NPA;						# Numero di punti A
set PuntiA := 1 .. NPA;			# Punti A
param NPB;						# Numero di punti B
set PuntiB := 1 .. NPB;			# Punti B
param XA {PuntiA};				# Ascisse A
param YA {PuntiA};				# Ordinate A
param XB {PuntiB};				# Ascisse B
param YB {PuntiB};				# Ordinate B

# VARIABILI
var XP integer;					# Ascissa punto
var YP integer;					# Ordinata punto
var XPOdd = 2 * XP + 1;			# Ascissa dispari
var YPOdd = 2 * YP + 1;			# Ordinata dispari

# VINCOLI

# OBIETTIVO
# Minimizzare attrazione e repulsione
minimize z : sum {pa in PuntiA} sqrt( (XPOdd-XA[pa])^2 + (YPOdd-YA[pa])^2 )
		   - 1/2 * sum {pb in PuntiB} sqrt( (XPOdd-XB[pb])^2 + (YPOdd-YB[pb])^2 );

##################################################

data;

param NPA := 6;

param NPB := 6;

param:	XA	YA	:=
1		16	34
2		24	16
3		56	22
4		23	27
5		52	49
6		61	32;

param:	XB	YB	:=
1		25	41
2		14	21
3		46	58
4		29	42
5		30	18
6		24	37;

end;
