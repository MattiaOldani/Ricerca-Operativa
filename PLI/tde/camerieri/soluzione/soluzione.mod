# TDE Camerieri

# DATI
set Giorni := 0 .. 6;									# Giorni
param CamerieriRichiesti {Giorni};						# Camerieri richiesti

# VARIABILI
var ConvocazioniQuattro {Giorni} integer >= 0;			# Convocazioni da quattro giorni
var ConvocazioniCinque {Giorni} integer >= 0;			# Convocazioni da cinque giorni

# VINCOLI
# Devo coprire le richieste giornaliere
subject to Copertura {g1 in Giorni}:
	ConvocazioniQuattro[g1] + sum {g2 in 1..3} ConvocazioniQuattro[(g1-g2+7) mod 7] +
	ConvocazioniCinque[g1] + sum {g3 in 1..4} ConvocazioniCinque[(g1-g3+7) mod 7]
	>= CamerieriRichiesti[g1];

# OBIETTIVO
# Minimizzare le convocazioni
# minimize z : sum {g in Giorni} ConvocazioniQuattro[g];
minimize z : sum {g in Giorni} (320 * ConvocazioniQuattro[g] + 375 * ConvocazioniCinque[g]);

##################################################

data;

param CamerieriRichiesti :=
0	4
1	5
2	5
3	10
4	12
5	12
6	2;

end;
