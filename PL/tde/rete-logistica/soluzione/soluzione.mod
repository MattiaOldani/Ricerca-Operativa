# TDE Rete logistica

# DATI
set Magazzini;											# Magazzini
set PuntiVendita;										# Punti vendita
param Domanda {PuntiVendita};							# Domanda [unit�/anno]
param TrasportoPM {Magazzini};							# Trasporto produzione-magazzino [euro/unit�]
param TrasportoMPV {Magazzini, PuntiVendita};			# Trasporto magazzino-puntovendita [euro/unit�]
param CapacitaMagazzino1;								# Capacit� magazzino1 [unit�/anno]
param CapacitaMagazzino2;								# Capacit� magazzino2 [unit�/anno]

# VARIABILI
var Trasporto {Magazzini, PuntiVendita} >= 0;			# Trasporto da un magazzino al punto vendita [unit�/anno]

# VINCOLI
# Rispetto la domanda richiesta [unit�/anno]
subject to RispettoDomanda {pv in PuntiVendita}:
	sum {m in Magazzini} Trasporto[m,pv] = Domanda[pv];
# Non eccedo la capienza del magazzino1 [unit�/anno]
subject to Capienza1:
	sum {pv in PuntiVendita} Trasporto['Middlesborough',pv] <= CapacitaMagazzino1;
# Non eccedo la capienza del magazzino2 [unit�/anno]
subject to Capienza2:
	sum {pv in PuntiVendita} Trasporto['Bristol',pv] <= CapacitaMagazzino1;

# OBIETTIVO
# Minimizzare i costi di trasporto [euro/anno]
minimize z : sum {m in Magazzini, pv in PuntiVendita} Trasporto[m,pv] * (TrasportoPM[m] + TrasportoMPV[m,pv]);

##################################################

data;

set Magazzini := Bristol Middlesborough;

set PuntiVendita := Londra Birmingham Leeds Edimburgo;

param Domanda :=
Londra		90000
Birmingham	80000
Leeds		50000
Edimburgo	70000;

param TrasportoPM :=
Bristol			24.5
Middlesborough	26;

param TrasportoMPV:		Londra	Birmingham	Leeds	Edimburgo	:=
Bristol					9.6		7			15.2	28.5
Middlesborough			19.5	13.3		5		11.3;

param CapacitaMagazzino1 := 150000;

param CapacitaMagazzino2 := 150000;

end;
