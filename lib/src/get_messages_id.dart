import 'dart:io';

import 'package:thiago_bot/config/strings.dart';

Future<Iterable<int>> getMessagesId() async {
  final lines = await File(idsFileName).readAsLines();
  return lines.map((e) => int.parse(e));
}