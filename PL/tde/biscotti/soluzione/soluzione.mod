# TDE Biscotti

# DATI
set Biscotti;																		# Biscotti
set Ingredienti;																	# Ingredienti
param ComposizioneBiscotti {Ingredienti, Biscotti};									# Percentuale di composizione ingredienti [adimensionale]
param TempiLavorazione {Biscotti};													# Tempi di lavorazione [kg/giorno]
param PrezziVendita {Biscotti};														# Prezzo di vendita [euro/kg]
param PrezziIngredienti {Ingredienti};												# Prezzo degli ingredienti [euro/kg]
param IngredientiDaComprareMinimo {Ingredienti};									# Ingredienti minimi da comprare [kg/settimana]
param ProduzioneSettimanaleMinima {Biscotti};										# Produzione minima [kg/settimana]
param ProduzioneSettimanaleMassima {Biscotti};										# Produzione massima [kg/settimana]
param Budget;																		# Budget mensile [euro]
param CostoCampagna;																# Costo della campagna [euro/trimestre]

# VARIABILI
var ProduzioneSettimanale {b in Biscotti} >= ProduzioneSettimanaleMinima[b];		# Produzione settimanale [kg/settimana]
var IngredientiAcquistati {Ingredienti};											# Ingredienti acquistati [kg/settimana]

# VINCOLI
# Composizione dei biscotti [kg/settimana]
subject to Composizione {i in Ingredienti}:
	sum {b in Biscotti} ProduzioneSettimanale[b] * ComposizioneBiscotti[i,b] / 100 <= IngredientiAcquistati[i];
# Tempi di lavorazione [giorno/settimana]
subject to Tempo:
	sum {b in Biscotti} ProduzioneSettimanale[b] / TempiLavorazione[b] <= 5;
# Budget settimanale [euro/settimana]
subject to BudgetSettimanale:
	sum {i in Ingredienti} IngredientiAcquistati[i] * PrezziIngredienti[i] <= Budget / 12;
# Produzione massima di biscotti  [kg/settimana]
subject to Produzione {b in Biscotti}:
	ProduzioneSettimanale[b] <= ProduzioneSettimanaleMassima[b];
# Produzione minima di ingredienti [kg/settimana]
subject to Acquisti {i in Ingredienti}:
	IngredientiAcquistati[i] >= IngredientiDaComprareMinimo[i];

# OBIETTIVO
# Massimizzare i profitti [euro/settimana]
maximize z : sum {b in Biscotti} ProduzioneSettimanale[b] * PrezziVendita[b]
		   - sum {i in Ingredienti} IngredientiAcquistati[i] * PrezziIngredienti[i];

##################################################

data;

set Biscotti := Svegliallegra FrollinoDelMattino AlbaRadiosa ProntiVia;

set Ingredienti := Farina Uova Zucchero Burro Latte Additivi Nocciole;

param ComposizioneBiscotti:     Svegliallegra   FrollinoDelMattino  AlbaRadiosa ProntiVia :=
Farina                          20              25                  30          20
Uova                            15              0                   10          20
Zucchero                        20              15                  25          10
Burro                           0               0                   10          10
Latte                           10              20                  20          15
Additivi                        15              20                  0           15
Nocciole                        10              0                   0           0;

param TempiLavorazione :=
Svegliallegra       165
FrollinoDelMattino  250
AlbaRadiosa         500
ProntiVia           250;

param PrezziVendita :=
Svegliallegra       1.75
FrollinoDelMattino  1
AlbaRadiosa         1.25
ProntiVia           1.5;

param PrezziIngredienti :=
Farina      0.5
Uova        2
Zucchero    0.5
Burro       1
Latte       1.5
Additivi    1
Nocciole    5;

param IngredientiDaComprareMinimo :=
Farina      450
Uova        200
Zucchero    320
Burro       140
Latte       320
Additivi    100
Nocciole    50;

param ProduzioneSettimanaleMinima :=
Svegliallegra       50
FrollinoDelMattino  100
AlbaRadiosa         500
ProntiVia           300;

param ProduzioneSettimanaleMassima :=
Svegliallegra       300
FrollinoDelMattino  500
AlbaRadiosa         1000
ProntiVia           500;

param Budget := 21600;

param CostoCampagna := 5000;

end;
