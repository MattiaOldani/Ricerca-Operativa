# Pianificazione multi-periodo

# DATI
set Mesi;                               # Mesi
param domandaMensile {Mesi};            # Gelato minimo da produrre [tonnellate]
param capacitaProduttiva {Mesi};        # Capacità massima mensile [tonnellate]
param costoIngredienti {Mesi};          # Costo unitario ingredienti [euro/tonnellata]
param costoMagazzino {Mesi};            # Costo unitario magazzino [euro/chilogrammo]
param y0;								# Scorta iniziale magazzino [tonnellate]

# VARIABILI
var x {Mesi} >= 0;                      # Produzione mensile [tonnellate]
var y {Mesi} >= 0;						# Gelato invenduto [tonnellate]

# VINCOLI
# CONSERVAZIONE DEL FLUSSO
# [vecchio stock] + [prodotto] = [domanda] + [nuovo stock]

# Conservazione del flusso1 [tonnellate]
subject to ConservazioneFlusso1 {m in Mesi : m > 1}:
	y[m-1] + x[m] = domandaMensile[m] + y[m];
# Conservazione del flusso2 [tonnellate]
subject to ConservazioneFlusso2:
	y0 + x[1] = domandaMensile[1] + y[1];
# Massima capacità produttiva mensile [tonnellate]
subject to ProduzioneMensile {m in Mesi}:
	x[m] <= capacitaProduttiva[m];

# OBIETTIVO
# Minimizzare i costi [euro]
minimize z : sum {m in Mesi} (x[m] * costoIngredienti[m] + y[m] * costoMagazzino[m] * 1000);

##################################################

data;

set Mesi := 1 2 3 4;

param domandaMensile :=
1	200
2	300
3	500
4	400;

param capacitaProduttiva :=
1	400
2	500
3	300
4   500;

param costoIngredienti :=
1	34
2	36
3	32
4	38;

param costoMagazzino :=
1	2
2	3
3	2
4	3;

param y0 := 0;

end;
