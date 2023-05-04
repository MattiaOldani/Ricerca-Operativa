# Sessismo

# DATI
param V;											# Numero di vertici
set Vertici := 1 .. V;								# Vertici
set Archi within Vertici cross Vertici;				# Archi come sottoinsieme del prodotto cartesiano dei vertici
param Peso {Vertici};								# Peso dei vertici [unità di sessismo]

# VARIABILI
var SelezionaVertice {Vertici} binary;				# Selezione di un vertice [binaria]

# VINCOLI
# Evitare la selezione di vertici che siano collegati da un arco [adimensionale]
# Se volessimo la massima clique dovremmo imporre la non presenza di (v1,v2) e (v2,v1) per la simmetria, eliminata poi con v1<v2
subject to Amicizia {v1 in Vertici, v2 in Vertici : (v1,v2) in Archi}:
	SelezionaVertice[v1] + SelezionaVertice[v2] <= 1;

# OBIETTIVO
# Massimizzare il sessismo [unità di sessismo]
maximize z : sum {v in Vertici} SelezionaVertice[v] * Peso[v];

##################################################

data;

param V := 8;

set Archi := (1,2) (1,3) (2,3) (2,4) (3,4) (2,5) (3,6) (4,7) (5,6) (5,7) (6,7) (5,8) (6,8);

param Peso :=
1	100
2	100
3	90
4	85
5	50
6	20
7	15
8	10;

end;
