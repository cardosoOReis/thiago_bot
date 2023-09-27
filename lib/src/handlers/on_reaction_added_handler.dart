import 'package:nyxx/nyxx.dart';
import 'package:thiago_bot/src/get_messages_id.dart';
import 'package:thiago_bot/src/handlers/message_handler.dart';
import 'package:thiago_bot/src/handlers/reaction_handler.dart';

void onReactionAddedHandler({
  required INyxxWebsocket bot,
  required IMessageReactionEvent event,
}) async {
  final messageId = event.messageId;
  final ids = await getMessagesId();

  if (!ids.contains(messageId.id)) return;

  final emoji = event.emoji.formatForMessage();
  final channel = event.channel;
  final user = await event.user.getOrDownload();
  final guild = event.guild!;

  final message = event.message ??
      await bot.httpEndpoints.fetchMessage(channel.id, messageId);

  await handleReactions(bot, emoji, message, user, channel, messageId);
  await handleMessage(message, bot, guild, channel.id, messageId);
}

