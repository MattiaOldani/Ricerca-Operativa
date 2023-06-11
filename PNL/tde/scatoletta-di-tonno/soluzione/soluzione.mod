# TDE Scatoletta di tonno

# DATI
param Volume;							# Volume del tornno [cmc]
param PiGreco := 4 * atan(1);			# PiGreco

# VARIABILI
var Raggio >= 0;						# Raggio della scatoletta [cm]
var Altezza >= 0;						# Altezza della scatoletta [cm]
var Superficie >= 0;					# Superficie [cmq]

# VINCOLI
# Definizione superficie [cmq]
subject to DefinizioneSuperficie:
	Superficie = 2 * PiGreco * Raggio^2 + 2 * PiGreco * Raggio * Altezza;
# Volume della scatoletta [cmc]
subject to VolumeTotale:
	PiGreco  * Raggio^2 * Altezza >= Volume;

# OBIETTIVO
# Minimizzare la superficie [cmq]
minimize z : Superficie;

##################################################

data;

param Volume := 1;

var Raggio := 10;

var Altezza := 5;

end;
