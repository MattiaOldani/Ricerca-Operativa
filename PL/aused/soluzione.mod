# Aused

# DATI
param nM;											# Numero mesi
set Mesi := 1..nM;									# Mesi
param CapacitaProduttiva;							# Capacità produttiva [unitò]
param CostoProduzione;								# Costo di produzione [euro/unità]
param CapacitaProduttivaExtra;						# Capacità produttiva extra [unità]
param CostoProduzioneExtra;							# Costo di produzione extra [euro/unitò]
param CostoGiacenza;								# Costo di giacenza [euro/unità]
param RichiestaMensile {Mesi};						# Richiesta mensile [unitò]
param ScorteIniziali;								# Scorte iniziali [unitò]

# VARIABILI
var x {Mesi} >= 0, <= CapacitaProduttiva;			# Produzione mensile [unità]
var y {Mesi} >= 0, <= CapacitaProduttivaExtra;		# Produzione extra mensile [unità]
var z {Mesi} >= 0;									# Giacienza alla fine del mese [unitò]

# VINCOLI
# Conservazione del flusso1 [unitò]
subject to Flusso1 {m in Mesi : m > 1}:
	z[m-1] + x[m] + y[m] = RichiestaMensile[m] + z[m];
# Conservazione del flusso2 [unitò]
subject to Flusso2:
	ScorteIniziali + x[1] + y[1] = RichiestaMensile[1] + z[1];

# OBIETTIVO
# Minimizzare i costi [euro]
minimize ob : sum {m in Mesi} (CostoProduzione*x[m] + CostoProduzioneExtra*y[m] + CostoGiacenza*z[m]);

##################################################

data;

param nM := 3;

param CapacitaProduttiva := 110;

param CostoProduzione := 300;

param CapacitaProduttivaExtra := 60;

param CostoProduzioneExtra := 330;

param CostoGiacenza := 10;

param RichiestaMensile :=
1	100
2	130
3	150;

param ScorteIniziali := 0;

end;
