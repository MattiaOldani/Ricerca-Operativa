# TDE Container

# DATI
param N;                                                                                                # Numero di tipi di oggetti
set TipiOggetti := 1 .. N;                                                                              # Tipi di oggetti
param NumeroOggetti {TipiOggetti};                                                                      # Numero di oggetti per ogni tipo [adimensionale]
param VolumeOggetti {TipiOggetti};                                                                      # Volume di ogni tipo di oggetto [metricubi]
param CapacitaContainer;                                                                                # Volume dei container [metricubi]
# param CapacitaContainerAlternativi;                                                                     # Volume del container alternativo [metricubi]
param M := ceil( sum {t in TipiOggetti}VolumeOggetti[t] * NumeroOggetti[t] / CapacitaContainer);        # Numero di container disponibili
set Container := 1 .. M;                                                                                # Insieme dei container

# VARIABILI
var x {Container} binary;                                                                               # Utilizzo o meno di un container [binaria]
var y {TipiOggetti, Container} >= 0 integer;                                                            # Numeri di oggetti di ogni tipo in ogni container [adimensionale]

# VINCOLI
# Vincolo di capacit� massima [metricubi]
subject to CapacitaMassima {c in Container}:
     sum {t in TipiOggetti} VolumeOggetti[t] * y[t,c] <= CapacitaContainer * x[c];
# Uso di ogni oggetto [adimensionale]
subject to TotaleOggetti {t in TipiOggetti}:
     sum {c in Container} y[t,c] = NumeroOggetti[t];

# OBIETTIVO
# Minimizzare il numero di container
minimize z : sum {c in Container} x[c];

##################################################

data;

param N := 10;

param:  NumeroOggetti       VolumeOggetti   :=
1          68                   30
2          90                   25
3          10                   200 
4          48                   40
5          28                   105
6          70                   150
7          56                   18
8          10                   250
9          45                   54
10         12                   67;

param CapacitaContainer := 5000;

end;
