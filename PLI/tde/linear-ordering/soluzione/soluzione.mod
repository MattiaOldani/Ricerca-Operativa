# TDE Linear ordering

# DATI
param V;                                                # Numero di vertici
set Vertici := 1 .. V;                                  # Vertici
param MatricePesi {Vertici,Vertici};                    # Matrice dei pesi [adimensionale]

# VARIABILI
var SceltaOrientamento {Vertici,Vertici} binary;        # Orientamento degli archi [binaria]
var Posizione {Vertici,Vertici} binary;                 # Posizione di ogni nodo [binaria]

# VINCOLI
# Orientamento degli archi [adimensionale]
subject to OrientamentoArchi {v1 in Vertici, v2 in Vertici : v1 < v2}:
        SceltaOrientamento[v1,v2] + SceltaOrientamento[v2,v1] = 1;
# Assegnamento di un vertice in riga [adimensionale]
subject to AssegnamentoVerticeRiga {v1 in Vertici}:
        sum {v2 in Vertici} Posizione[v1,v2] = 1;
# Assegnamento di un vertice in colonna [adimensionale]
subject to AssegnamentoVerticeColonna {v1 in Vertici}:
        sum {v2 in Vertici} Posizione[v2,v1] = 1;
# Ordinamento dei vertici scelti [adimensionale]
subject to Collegamento {v1 in Vertici, v2 in Vertici : v1 <> v2}:
        ( sum {v3 in Vertici} Posizione[v1,v3] * v3 - sum {v4 in Vertici} Posizione[v2,v4] * v4 ) <= SceltaOrientamento[v2,v1] * V;
        
# VINCOLI ALTERNATIVI
# Aciclicità del grafo
#subject to NoCicliOrdineTre {v1 in Vertici, v2 in Vertici, v3 in Vertici : v1 <> v2 and v1 <> v3 and v2 <> v3}:
#        SceltaOrientamento[v1,v2] + SceltaOrientamento[v1,v3] + SceltaOrientamento[v2,v3] <= 2;

# OBIETTIVO
# Minimizzare il peso degli archi orientati [adimensionale]
minimize z : sum {v1 in Vertici, v2 in Vertici} SceltaOrientamento[v1,v2] * MatricePesi[v1,v2];

##################################################

data;

param V := 7;

param MatricePesi:  1   2   3   4   5   6   7   :=
1                   0   68  81  23  45  20  37
2                   12  0   25  51  57  89  78
3                   34  27  0   12  9   71  20
4                   95  55  42  0   8   23  44
5                   60  60  51  34  0   2   40
6                   93  22  48  45  24  0   77
7                   75  64  36  25  16  21  0;

end;
