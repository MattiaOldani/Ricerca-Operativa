# Comandi AMPL

## Compilazione e osservazione dei risultati

Per compilare il modello:
* Eseguire il `reset` della console
* Compilare il modello con `model soluzione.mod`
* Eseguire il modello con `solve`

Per osservare i risultati:
* Eseguire `display XXX` passando il nome di parametri, variabili, vincoli o funzione obiettivo
* Eseguire `display XXX.slack` per vedere lo slack di un vincolo

## Cambio solver

Per modificare un solutore usare `option solver XXX`

Principali solver dentro AMPL:
* baron
* snopt
