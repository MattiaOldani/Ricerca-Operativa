# TDE Il tempo denaro

# DATI
param NM;											# Numero di motocicli
set Motocicli := 1 .. NM;							# Motocicli
param NC;											# Numero di componenti
set Componenti := 1 .. NC;							# Componenti
param RicaviVendite {Motocicli};					# Ricavi delle vendite [euro/motociclo]
param TempiAssemblaggio {Motocicli};				# Tempi di assemblaggio [giorni-uomo/motociclo]
param PezziNecessari {Componenti, Motocicli};		# Pezzi necessari per motociclo [pezzi/motociclo]
param ComponentiDisponibili {Componenti};			# Componenti disponibli [pezzi/mese]
param Tempo;										# PMO

# VARIABILI
var ProduzioneMotocicli {Motocicli} >= 0;			# Produzione mensile [motocicli/mese]
var Tempo >= 0;										# PMO

# VINCOLI
# Limiti uso componenti [pezzi/mese]
subject to MassimoUsoComponenti {c in Componenti}:
	sum {m in Motocicli} ProduzioneMotocicli[m] * PezziNecessari[c,m] <= ComponentiDisponibili[c];
# Visualizzazione del tempo di assemblaggio [giorni-uomo]
subject to VisualizzazioneTempo:
	sum {m in Motocicli} ProduzioneMotocicli[m] * TempiAssemblaggio[m] = Tempo;

# OBIETTIVO
# Massimizzare i ricavi [euro/mese]
maximize z : sum {m in Motocicli} ProduzioneMotocicli[m] * RicaviVendite[m];

##################################################

data;

param NM := 3;

param NC := 3;

param RicaviVendite :=
1	1200
2	1300
3	1200;

param TempiAssemblaggio :=
1	1
2	1
3	1;

param PezziNecessari:	1	2	3	:=
1						10	12	14
2						5	7	6
3						10	15	9;

param ComponentiDisponibili :=
1	91
2	40
3	59;

end;
