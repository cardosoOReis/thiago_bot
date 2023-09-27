import 'package:nyxx/nyxx.dart';

const idsFileName = 'ids.txt';

const checkEmoji = '✅';

const xEmoji = '❌';

String tituloMensagem(bool isSexta) =>
    'Eai pessoal, tranquilo? Quero ver quem vai ${isSexta ? 'segunda' : 'amanhã'} presencial comigo 🤩';

const confirmado = 'Vou sim Thiagão (Alfas 💪😎👍):';

const ninguemConfirmado = 'Ninguém confirmado? 😿';

const todoMundoConfirmado = 'Todo mundo confirmado, isso que é time!';

const naoVao = 'Não vou (Cringes 🙄🤢):';

const naoConfirmado = 'Não confirmado (Devem tá dormindo 😴):';

String formatMessage(
  String title,
  Iterable<IUser> users, [
  String? noUser,
]) {
  final usernames = users.map((user) => user.globalName ?? user.username);
  return switch ((users.isEmpty, noUser != null)) {
    (false, _) => '''
$title
${usernames.join('\n')}
''',
    (true, true) => '''
$title
$noUser
''',
    (true, false) => '''
$title
''',
  };
}
