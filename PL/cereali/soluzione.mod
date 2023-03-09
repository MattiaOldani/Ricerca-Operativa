# Cereali

# DATI
set Lotti;                                  # Lotti
set Cereali;                                # Cereali
param TerrenoDisponibile {Lotti};           # Terreno [acri]
param Profitti {Cereali};                   # Profitti unitari [euro/quintale]
param AcquaNecessaria {Cereali};            # Acqua necessaria [metricubi/quintale]
param AreaNecessaria {Lotti, Cereali};      # Terreno necessario [acri/quintale]
param Acqua;                                # Acqua disponibile [metricubi]

# VARIABILI
var x {Lotti, Cereali} >= 0;                # Cereali coltivati per lotto [quintali]

# VINCOLI
# Acqua massima disponibile [metricubi]
subject to AcquaMassima:
   sum {c in Cereali, l in Lotti} x[l,c] * AcquaNecessaria[c] <= Acqua;
# Terreno massimo disponibile [acri]
subject to TerrenoColtivabile {l in Lotti}:
   sum {c in Cereali} x[l,c] * AreaNecessaria[l,c] <= TerrenoDisponibile[l];

# OBIETTIVO
# Massimizzare i profitti
maximize z : sum {c in Cereali, l in Lotti} x[l,c] * Profitti[c]; 

##################################################

data;

set Lotti := A B;

set Cereali := 1 2 3 4 5 6;

param TerrenoDisponibile :=
A   200
B   400;

param Profitti :=
1   48
2   62
3   28
4   36
5   122
6   94;

param AcquaNecessaria :=
1   120
2   160
3   100
4   140
5   215
6   180;

param AreaNecessaria:       1       2       3       4       5       6 :=
A                           .02     .03     .02     .016    .05     .04
B                           .02     .034    .024    .02     .06     .034;

param Acqua := 400000;

end;
