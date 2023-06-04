# TDE Proiettile

# DATI
param NR;												# Numero di rilevazioni
set Rilevazioni := 1 .. NR;								# Rilevazioni
param XR {Rilevazioni};									# Ascisse delle rilevazioni
param YR {Rilevazioni};									# Ordinate delle rilevazioni

# VARIABILI
var A <= 0;												# Coefficiente di x^2
var B;													# Coefficiente di x
var C;													# Termine noto
var ErroreQuadraticoMedio {Rilevazioni} >= 0;			# Errori quadratici medi

# VINCOLI
# Definizione errore quadratico medio
subject to Definizione {r in Rilevazioni}:
	ErroreQuadraticoMedio[r] = ( YR[r] - ( A*XR[r]^2 + B*XR[r] + C ) )^2 / NR;

# OBIETTIVO
# Minimizzare l'errore quadratico medio
minimize z : sum {r in Rilevazioni} ErroreQuadraticoMedio[r];

##################################################

data;

param NR := 4;

param:	XR	YR	:=
1		10	18
2		20	26
3		30	31
4		40	29;

end;
