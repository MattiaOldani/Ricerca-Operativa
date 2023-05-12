# TDE Potatura

# DATI
set Alberi;                                             # Alberi
set Potature;                                           # Potature
param CostiPotatura {Potature};                         # Costi della potatura [euro/ora-uomo]
param EffettoPotatura {Alberi};                         # Effetto della potatura [adimensionale]
param ManodoperaNecessaria {Alberi, Potature};          # Manodopera necessaria per una potatura [ore-uomo/albero]
param ManodoperaDisponibile {Potature};                 # Manodopera disponibile [ore-uomo]
param AlberiDaPotare {Alberi};                          # Numero di alberi da potare minimi [adimensionale]
# param z2;                                               # Multi-obiettivo

# VARIABILI
var Taglio {Alberi, Potature} >= 0;                     # Numero alberi potati con ogni potatura [adimensionale]
# var z2;                                                 # Multi-obiettivo

# VINCOLI
# Massima manodopera disponibile [ore-uomo]
subject to MassimaManodopera {p in Potature}:
        sum {a in Alberi} Taglio[a,p] * ManodoperaNecessaria[a,p] <= ManodoperaDisponibile[p];
# Minimo numero di alberi da potare [adimensionale]
subject to AlberiMinimiDaPotare {a in Alberi}:
        sum {p in Potature} Taglio[a,p] >= AlberiDaPotare[a];
# Vincolo per multi-obiettivo
# subject to MultiObiettivo:
#        sum {a in Alberi, p in Potature} Taglio[a,p] * ManodoperaNecessaria[a,p] * CostiPotatura[p] <= z2;

# OBIETTIVO
# Massimizzare l'effetto potatura [adimensionale]
maximize z1 : sum {a in Alberi, p in Potature} Taglio[a,p] * EffettoPotatura[a];
# Minimizzare la manodopera utilizzata [euro]
#minimize z2 : sum {a in Alberi, p in Potature} Taglio[a,p] * ManodoperaNecessaria[a,p] * CostiPotatura[p];

##################################################

data;

set Alberi := Pioppi Platani Betulle Olmi;

set Potature := Manuale Meccanico;

param CostiPotatura :=
Manuale     20
Meccanico   60;

param EffettoPotatura :=
Pioppi      5
Platani     7
Betulle     8
Olmi        15;

param ManodoperaNecessaria:     Manuale     Meccanico   :=
Pioppi                          5           0.8333
Platani                         10          2
Betulle                         2.5         1.6667
Olmi                            1           .6667;

param ManodoperaDisponibile :=
Manuale     100
Meccanico   75;

param AlberiDaPotare :=
Pioppi      35
Platani     20
Betulle     10
Olmi        5;

# param z2 := 4749.8;

end;
