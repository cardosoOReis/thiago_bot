import 'package:nyxx/nyxx.dart';
import 'package:thiago_bot/config/strings.dart';

Future<void> handleReactions(
  INyxxWebsocket bot,
  String emoji,
  IMessage message,
  IUser user,
  IChannel channel,
  Snowflake messageId,
) async {
  if (![checkEmoji, xEmoji].contains(emoji)) return;

  final [usersWithCheckEmoji, usersWithXEmoji] = await Future.wait(
    [
      message
          .fetchReactionUsers(UnicodeEmoji(checkEmoji))
          .where((user) => !user.bot)
          .toList(),
      message
          .fetchReactionUsers(UnicodeEmoji(xEmoji))
          .where((user) => !user.bot)
          .toList(),
    ],
  );

  if (emoji == checkEmoji) {
    if (usersWithXEmoji.map((u) => u.id.id).contains(user.id.id)) {
      await bot.httpEndpoints.deleteMessageUserReaction(
        channel.id,
        messageId,
        UnicodeEmoji(xEmoji),
        user.id,
      );
    }
  } else {
    if (usersWithCheckEmoji.map((u) => u.id.id).contains(user.id.id)) {
      await bot.httpEndpoints.deleteMessageUserReaction(
        channel.id,
        messageId,
        UnicodeEmoji(checkEmoji),
        user.id,
      );
    }
  }
}
