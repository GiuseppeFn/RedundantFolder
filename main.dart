import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:isolate';

import 'package:path/path.dart';
import 'package:win32/win32.dart';

import './lib/functions.dart';

void main(List<String> args) async {
  String? prgm;
  if (args.length > 0) prgm = args[0];

  if (prgm == null) {
    String newExePath = (await initFirstTime()).absolute.path;
    await Isolate.spawn(createProcess, newExePath);
    await createBat(newExePath);
    return;
  }

  ShowWindow(GetConsoleWindow(), SW_HIDE);

  File json_info = File(join(prgm, 'info.json'));
  Map<String, dynamic> info = json.decode(await json_info.readAsString());

  await Timer.periodic(Duration(seconds: 3), (timer) async {
    await Process.run(
      'robocopy',
      [
        info['cartella_inviatore']!.toString().replaceAll("file:///", ""),
        info['cartella_ricevitore']!.toString().replaceAll("file:///", ""),
        '/E',
        '/MIR'
      ],
      runInShell: true,
    );
  });
}
