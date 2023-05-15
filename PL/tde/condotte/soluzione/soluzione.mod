# TDE Condotte

# DATI
param NO;												# Numero di origini
set Origini := 1 .. NO;									# Origini
param ND;												# Numero di destinazioni
set Destinazioni := 1 .. ND;							# Destinazioni
param CostiTrasporto {Origini, Destinazioni};			# Costi di trasporto [euro/quintale]
param ProduzioneOrigini {Origini};						# Produzione massima delle origini [quintali/giorno]
param RichiestaDestinazioni {Destinazioni};				# Richiesta minima delle destinazioni [quintali/giorno]
# param CapienzaCondotto;									# PMO [quintali/giorno]

# VARIABILI
var CapienzaCondotto >= 0;								# Capienza del condotto [quintali/giorno]
var Trasporto {Origini, Destinazioni} >= 0;				# Quintali trasportati da origine a destinazione [quintali/giorno]

# VINCOLI
# Produzione massima giornaliera [quintali/giorno]
subject to ProduzioneMassimaGiornaliera {o in Origini}:
	sum {d in Destinazioni} Trasporto[o,d] <= ProduzioneOrigini[o];
# Richiesta minima giornaliera [quintali/giorno]
subject to RichiestaMinimaGiornaliera {d in Destinazioni}:
	sum {o in Origini} Trasporto[o,d] >= RichiestaDestinazioni[d];
# Capienza del condotto [quintali/giorno]
subject to Capienza {o in Origini, d in Destinazioni}:
	CapienzaCondotto >= Trasporto[o,d];

# OBIETTIVO
# Minimizzare la capienza del condotto [quintali/giorno]
minimize z : CapienzaCondotto;
# Minimizzare i costi [euro/giorno]
# minimize z : sum {o in Origini, d in Destinazioni} Trasporto[o,d] * CostiTrasporto[o,d];
# subject to PMO {o in Origini, d in Destinazioni}: CapienzaCondotto >= Trasporto[o,d];

##################################################

data;

param NO := 5;

param ND := 5;

param CostiTrasporto:	1	2	3	4	5	:=
1						15	18	23	31	16
2						27	19	14	28	31
3						20	15	12	25	15
4						17	18	24	23	25
5						26	17	17	17	28;

param ProduzioneOrigini :=
1	340
2	290
3	310
4	325
5	360;

param RichiestaDestinazioni :=
1	410
2	200
3	400
4	315
5	300;

# param CapienzaCondotto := 289.5;

end;
