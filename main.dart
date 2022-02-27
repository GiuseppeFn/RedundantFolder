import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:isolate';

import 'package:echodfile/utility.dart';
import 'package:path/path.dart';
import 'package:watcher/watcher.dart';
import 'package:win32/win32.dart';

import './lib/functions.dart';

void main(List<String> args) async {
  String? prgm;
  if (args.length > 0) prgm = args[0];

  if (prgm == null) {
    String newExePath = (await initFirstTime()).absolute.path;
    await Isolate.spawn(createProcess, newExePath);
    await createBat(newExePath);
    print("Premi un tasto per continuare...");
    Future.delayed(Duration(seconds: 1));
    stdin
      ..echoMode = false
      ..lineMode = false;
    stdin.listen((_) => exit(0));
    return;
  }

  ShowWindow(GetConsoleWindow(), SW_HIDE);

  File json_info = File(join(prgm, 'info.json'));
  Map<String, dynamic> info = json.decode(await json_info.readAsString());

  String inviatore = uriToPath(info['cartella_inviatore']),
      ricevitore = uriToPath(info['cartella_ricevitore']);

  await DirectoryWatcher(inviatore)
      .events
      .listen((event) => debouncedRobocopy(inviatore, ricevitore, 500));

  await DirectoryWatcher(ricevitore)
      .events
      .listen((event) => debouncedRobocopy(inviatore, ricevitore, 500));
}
