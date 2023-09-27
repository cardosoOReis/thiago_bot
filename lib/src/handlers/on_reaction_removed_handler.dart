import 'package:nyxx/nyxx.dart';
import 'package:thiago_bot/src/get_messages_id.dart';
import 'package:thiago_bot/src/handlers/message_handler.dart';

void onReactionRemovedHandler({
  required INyxxWebsocket bot,
  required IMessageReactionEvent event,
}) async {
  final messageId = event.messageId;
  final ids = await getMessagesId();

  if (!ids.contains(messageId.id)) return;

  final channelId = event.channel.id;
  final guild = event.guild!;

  final message = event.message ??
      await bot.httpEndpoints.fetchMessage(channelId, messageId);

  await handleMessage(
    message,
    bot,
    guild,
    channelId,
    messageId,
  );
}
