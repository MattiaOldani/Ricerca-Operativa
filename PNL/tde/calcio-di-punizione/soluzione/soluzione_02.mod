# TDE Calcio di punizione

# DATI
param AltezzaPorta;						# Altezza della porta [m]
param AltezzaBarriera;					# Altezza della barriera [m]
param DistanzaTiro;						# Distanza dalla porta [m]
param DistanzaBarriera;					# Distanza della barriera [m]
param VelocitaIniziale;					# Velocità iniziale [m/s]
param G;								# Accelerazione [m/s^2]

# VARIABILI
var Alpha >= 0;							# Angolo di tiro [radianti]
var Pi;									# Pi-greco
var Vx >= 0;							# Velocità x [m/s]
var Vy >= 0;							# Velocità y [m/s]
var TempoDiVolo >= 0;					# Tempo di volo [s]
var TempoBarriera >= 0;					# Tempo nel quale incontro la barriera [s]
# var VelocitaIniziale >= 0;			# Velocità iniziale [m/s]

# VINCOLI
# Definizione di pigreco
subject to DefinizionePiGreco:
	Pi = 4 * atan(1);
# Angolo che non supera pi/2
subject to AngoloMassimo:
	Alpha <= Pi / 2;
# Definizione di Vx
subject to DefinizioneVx:
	Vx = VelocitaIniziale * cos(Alpha);
# Definizione di Vy
subject to DefinizioneVy:
	Vy = VelocitaIniziale * sin(Alpha);
# Definizione del tempo di barriera
subject to DefinizioneTempoBarriera:
	TempoBarriera = 9.15 / Vx;
# Al tempo TempoBarriera non colpisco la barriera
subject to NonColpiscoBarriera:
	-0.5 * G * (TempoBarriera)^2 + Vy * TempoBarriera >= AltezzaBarriera;
# Definizione del tempo di volo
subject to DefinizioneTempoDiVolo:
	TempoDiVolo = 25 / Vx;
# Cado nella porta
subject to CadoNellaPorta1:
	-0.5 * G * (TempoDiVolo)^2 + Vy * TempoDiVolo >= 0;
subject to CadoNellaPorta2:
	-0.5 * G * (TempoDiVolo)^2 + Vy * TempoDiVolo <= AltezzaPorta;

# OBIETTIVO
# Minimizzare l'angolo con il quale calciamo il pallone
minimize z : Alpha;
# minimize z : VelocitaIniziale;

##################################################

data;

param AltezzaPorta := 2.44;

param AltezzaBarriera := 1.8;

param DistanzaTiro := 25;

param DistanzaBarriera := 9.15;

param VelocitaIniziale := 20;

param G := 9.81;

var Vx = 5;

var Vy = 5;

end;
