import 'package:nyxx/nyxx.dart';
import 'package:thiago_bot/config/strings.dart';
import 'package:thiago_bot/src/save_message_id.dart';

Future<void> sendPresencialMessage(INyxxWebsocket bot) async {
  for (final guild in bot.guilds.values) {
    final channel = guild.channels
        .where((channel) => channel.name == 'presença')
        .firstOrNull;

    if (channel == null) continue;

    final users = await bot.httpEndpoints
        .fetchGuildMembers(guild.id, limit: 100)
        .asyncMap((member) => member.user.getOrDownload())
        .where((user) => !user.bot)
        .toList();

    final notConfirmedMessage = formatMessage(naoConfirmado, users);

    final message = await bot.httpEndpoints.sendMessage(
      channel.id,
      MessageBuilder.content(
        '''
${tituloMensagem(DateTime.now().weekday == 5)}

$confirmado

$naoVao

$notConfirmedMessage
''',
      ),
    );

    await message.createReaction(UnicodeEmoji(checkEmoji));

    await Future.delayed(const Duration(seconds: 3));

    await message.createReaction(UnicodeEmoji(xEmoji));

    await saveMessageId(message.id.id);
  }
}
