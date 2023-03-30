# Aused

# DATI
param nM;											# Numero mesi
set Mesi := 1..nM;									# Mesi
param CapacitaProduttiva;							# Capacit� produttiva [unit�]
param CostoProduzione;								# Costo di produzione [euro/unit�]
param CapacitaProduttivaExtra;						# Capacit� produttiva extra [unit�]
param CostoProduzioneExtra;							# Costo di produzione extra [euro/unit�]
param CostoGiacenza;								# Costo di giacenza [euro/unit�]
param RichiestaMensile {Mesi};						# Richiesta mensile [unit�]
param ScorteIniziali;								# Scorte iniziali [unit�]

# VARIABILI
var x {Mesi} >= 0, <= CapacitaProduttiva;			# Produzione mensile [unit�]
var y {Mesi} >= 0, <= CapacitaProduttivaExtra;		# Produzione extra mensile [unit�]
var z {Mesi} >= 0;									# Giacienza alla fine del mese [unit�]

# VINCOLI
# Conservazione del flusso1 [unit�]
subject to Flusso1 {m in Mesi : m > 1}:
	z[m-1] + x[m] + y[m] = RichiestaMensile[m] + z[m];
# Conservazione del flusso2 [unit�]
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
