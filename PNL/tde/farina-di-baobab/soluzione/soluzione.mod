# TDE Farina di baobab

# DATI
param CostiProduzione;								# Costi variabili di produzione [euro/kg]
param CoefficienteProporzione;						# Coefficiente di proporzionalit� [adimensionale]
param VenditaMassima;								# Quantit� massima vendibile [kg/mese]
param PrezzoMassimoVendita;							# Prezzo massimo di vendita [euro/kg]

# VARIABILI
var Produzione >= 0, <= VenditaMassima := 35;		# Produzione mensile [kg/mese]

# VINCOLI

# OBIETTIVO
# Massimizzare i ricavi [euro/mese]
maximize z : (PrezzoMassimoVendita - CostiProduzione) * Produzione - CoefficienteProporzione * sqrt(Produzione);

##################################################

data;

param CostiProduzione := 10;

param CoefficienteProporzione := 80;

param VenditaMassima := 70;

param PrezzoMassimoVendita := 20;

end;
