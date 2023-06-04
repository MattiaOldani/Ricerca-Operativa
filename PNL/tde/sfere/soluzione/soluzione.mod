# TDE Sfere

# DATI
param NS;									# Numero di sfere
set Sfere := 1 .. NS;						# Sfere

# VARIABILI
# Vado a centrare le sfera nell'origine
var XS {Sfere};								# X delle sfere
var YS {Sfere};								# Y delle sfere
var ZS {Sfere};								# Z delle sfere
var Distanze {Sfere, Sfere} >= 0;			# Distanze tra sfere
var Raggio;									# Raggio

# VINCOLI
# Definizione delle distanze
subject to DefinizioneDistanze {s1 in Sfere, s2 in Sfere : s1 < s2}:
	Distanze[s1,s2] = sqrt( (XS[s1]-XS[s2])^2 + (YS[s1]-YS[s2])^2 + (ZS[s1]-ZS[s2])^2 );
# Non posso sovrapporre tra loro le sfere
subject to NonSovrapposizione {s1 in Sfere, s2 in Sfere : s1 < s2}:
	Distanze[s1,s2] >= 2;
# Le sfere non possono essere fuori dalla sfera più grande
subject to NonUscireX1 {s in Sfere}:
	XS[s] + 1 <= Raggio;
subject to NonUscireX2 {s in Sfere}:
	XS[s] - 1 >= - Raggio;
subject to NonUscireY1 {s in Sfere}:
	YS[s] + 1 <= Raggio;
subject to NonUscireY2 {s in Sfere}:
	YS[s] - 1 >= - Raggio;
subject to NonUscireZ1 {s in Sfere}:
	ZS[s] + 1 <= Raggio;
subject to NonUscireZ2 {s in Sfere}:
	ZS[s] - 1 >= - Raggio;

# OBIETTIVO
minimize z : Raggio;

##################################################

data;

param NS := 10;

var:	XS	YS	ZS	:=
1		1	1	1
2		2	2	2
3		3	3	3
4		4	4	4
5		5	5	5
6		6	6	6
7		7	7	7
8		8	8	8
9		9	9	9
10		10	10	10;

var Raggio = 15;

end;
