import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart';

//Usato nella creazione del file bat per rendere la creazione piu piacevole da vedere.

String simplify(String path) =>
    'start /MIN "RedundantFolder" "$path" "${dirname(path)}"';

//Mappa i nomi delle due cartelle in un json (Andrà in info.json)
String map(
  String cartella_inviatore,
  String cartella_ricevitore,
) =>
    {
      '"cartella_inviatore"':
          '"${Uri.file(absolute(cartella_inviatore)).toString()}"',
      '"cartella_ricevitore"':
          '"${Uri.file(absolute(cartella_ricevitore)).toString()}"',
    }.toString();

//Abbreviazione per la creazione e scrittura di un file (Stringa)
Future<File> createAndWriteS(String path, String content) async {
  return await File(path)
    ..create(recursive: true)
    ..writeAsString(content);
}

//Abbreviazione per la creazione e scrittura di un file (Uint8List)
Future<File> createAndWriteB(String path, Uint8List content) async =>
    await File(path)
      ..create(recursive: true)
      ..writeAsBytes(content);

String uriToPath(dynamic s) => s.toString().replaceAll("file:///", "");
