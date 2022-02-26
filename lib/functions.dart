import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart';
import 'consts.dart';
import 'utility.dart';

//Chiede all'utente una cartella finquando non è una cartella valida
Future<String> getFolderName(String fname) async {
  bool doesExist;
  Directory cartella;
  do {
    print("Qual'è il percorso della cartella '$fname'?: ");
    cartella = Directory(stdin.readLineSync() ?? '');
    doesExist = await cartella.exists();
    if (!doesExist)
      print("Percorso invalido o cartella non esistente, riprova.");
  } while (!doesExist);
  return cartella.absolute.path;
}

//Chiede all'utente le due cartelle da cui dovra copiare e in cui dovra copiare.
//(La copia avviene usando la funzione robocopy di windows.)
Future<List<String>> getFilePaths() async {
  print("Sembra che è la prima volta che avvii il programma. ");
  String cartella_inviatore = debug ? inv : await getFolderName('inviatore');
  print("Perfetto, file 'inviatore' settato.");
  String cartella_ricevitore = debug ? ric : await getFolderName('ricevitore');
  print("Perfetto, file 'ricevitore' settato.");
  return [cartella_inviatore, cartella_ricevitore];
}

//Inizializza il programma, prendendo i percorsi delle cartelle
//Spostandosi in una nuova cartella (Verra avviato all'avvio del pc da un file bat)
Future<File> initFirstTime() async {
  try {
    List<String> fpaths = await getFilePaths();
    String inviatore = fpaths[0], ricevitore = fpaths[1];

    String path = user + r'\RedundantFolder\';

    await createAndWriteS(join(path, "info.json"), map(inviatore, ricevitore));
    Uint8List content = await File(Platform.executable).readAsBytes();
    return await createAndWriteB(join(path, prgmName), content);
  } catch (e) {
    print("Errore nell'inizializzazione del programma con errore:\n");
    stderr.write(e);
    Future.delayed(Duration(minutes: 2)).then((_) => exit(1));
    //Altrimenti il linter è triste
    exit(-1);
  }
}

//Crea due file bat nelle due possibili directory di startup di windows
//Cioe C:\Users\$user\[baseStartupPath] e C:\Users\$user\[secondStartupPath]
Future createBat(String pathToStart) async {
  await createAndWriteS(user + baseStartupPath, simplify(pathToStart));
  await createAndWriteS(user + secondStartupPath, simplify(pathToStart));
}

/*Se il programma non è avviato per la prima volta, runnerà all'infinito.
 *Se non viene spawnato un isolate che si occupa di avviarlo, il cmd che avvia il programma
 *Runnerà all'infinito, quindi, l'utente dovrebbe occuparsi di chiuderlo.
 *Per evitarlo, lascio che un isolate runni la funzione createProcess
 *Che dato che runna in background, sarà killata alla morte del programma.
 */
void createProcess(String path) => Process.run(
      'start',
      ['/MIN', '"RedundantFolder"', path, dirname(path)],
      runInShell: true,
    ).ignore();
