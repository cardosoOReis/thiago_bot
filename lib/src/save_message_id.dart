import 'dart:io';

import 'package:thiago_bot/config/strings.dart';

Future<void> saveMessageId(int id) async {
  final file = await File(idsFileName).readAsLines();
  final ids = file.map((id) => int.parse(id)).toList();
  ids.add(id);
  await File(idsFileName).writeAsString(ids.join('\n'));
}