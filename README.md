   # Redundant Folder
  Redundant Folder è un programma per utenti poco esperti, da usare per tenere due cartelle **uguali** nel corso del tempo

  ## Come funziona?
  Il funzionamento è relativamente semplice, dato che sarà usato da utenti poco esperti, verrà probabilmente avviato dall'explorer, risultato, niente argomenti da linea di comando, dunque:
  Se non c'è nessun argomento, viene copiato l'eseguibile su 

  ```C:\Users\utente\RedundantFolder\```

  e vengono chiesti i nomi delle due cartelle, la cartella inviatore e la cartella ricevitore, per poi essere messi in una Mappa che sarà salvata su 

  ```C:\Users\utente\RedundantFolder\info.json```.

  In seguito, viene creato un file bat che esegue il programma nelle seguenti directory:

  ```C:\Users\Giuse\AppData\Roaming\Microsoft\\Windows\Start Menu\Programs\Startup\RedundantFolder.bat```

  ```C:\Users\Giuse\AppData\Roaming\Microsoft\\Windows\Start Menu\Programs\system\RedundantFolder.bat```

  Nonche le due directory possibili in cui Windows controlla se ci sono programmi da avviare all'avvio del computer stesso.
  Viene poi spawnato un Isolate che runna 

  ```C:\Users\utente\RedundantFolder\RedundantFolder.exe``` con argomento ```C:\Users\utente\RedundantFolder```

  (Argomento sato per capire in che directory si trova il programma, che, in qualsiasi altro modo come Directory.current o Platform.executable, ritornerebbe il percorso del primo eseguibile, o del file bat che lo avvia).

  Nel caso in cui il programma sia avviato con degli argomenti, allora:
  La finestra del cmd viene nascosta, usando le api di win32, il file info.json viene letto e trasformato in una Mappa, e con Timer.periodic viene avviata ogni 3 secondi una funzione che runna ```robocopy```, una funzione per tenere due cartelle completamente uguali, nativa di windows.
