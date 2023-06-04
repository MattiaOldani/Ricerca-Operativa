# TDE Calcio di punizione

# DATI
param AltezzaPorta;						# Altezza della porta [m]
param AltezzaBarriera;					# Altezza della barriera [m]
param DistanzaTiro;						# Distanza di tiro [m]
param DistanzaBarriera;					# Distanza dal punto di tiro [m]

# VARIABILI
var A <= 0;								# Coefficiente A di x^2, rivolta verso il basso
var B;									# Coefficiente B di x
var C >= 0, <= AltezzaPorta;			# Termine noto, vedi vincoli per i bound

# VINCOLI
# La parabola, calcolata in 0, cade nella porta
# subject to LowerPorta:
# A*0*2 + B*0 + C >= 0 --> C >= 0

# La parabola, calcolata in 0, non supera la porta
# subject to UpperPorta:
# A*0^2 + B*0 + C <= AltezzaPorta --> C <= AltezzaPorta

# La parabola, calcolata in DistanzaTiro, deve essere 0, il punto di battuta
subject to PuntoDiBattuta:
	A*(DistanzaTiro)^2 + B*DistanzaTiro + C = 0;

# La parabola, calcolata in DistanzaTiro-DistanzaBarriera, non deve colpire la barriera
subject to NonColpireBarriera:
	A*(DistanzaTiro-DistanzaBarriera)^2 + B*(DistanzaTiro-DistanzaBarriera) + C >= AltezzaBarriera;

# OBIETTIVO
# Massimizzare il valore di A per avere una parabola il più piatta possibile
maximize z : A;

##################################################

data;

param AltezzaPorta := 2.44;

param AltezzaBarriera := 1.8;

param DistanzaTiro := 25;

param DistanzaBarriera := 9.15;

end;
