import 'package:fpdart/fpdart.dart';
import 'package:nyxx/nyxx.dart';
import 'package:thiago_bot/config/strings.dart';

Future<void> handleMessage(
  IMessage message,
  INyxxWebsocket bot,
  Cacheable<Snowflake, IGuild> guild,
  Snowflake channelId,
  Snowflake messageId,
) async {
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
    ].map(
      (futureUsers) => futureUsers.then(
        (users) => users.sortBy(Order.from(_sortUsers)),
      ),
    ),
  );

  final confirmedUsersMessage = formatMessage(confirmado, usersWithCheckEmoji);
  final confirmedIds = usersWithCheckEmoji.map((user) => user.id.id);

  final declinedUsersMessage = formatMessage(naoVao, usersWithXEmoji);
  final declinedIds = usersWithXEmoji.map((user) => user.id.id);

  final usersNotConfirmed = await bot.httpEndpoints
      .fetchGuildMembers(guild.id, limit: 100)
      .asyncMap((member) => member.user.getOrDownload())
      .where((user) => !confirmedIds.contains(user.id.id))
      .where((user) => !declinedIds.contains(user.id.id))
      .where((user) => !user.bot)
      .toList();

  final usersNotConfirmedMessage = formatMessage(
    naoConfirmado,
    usersNotConfirmed,
  );

  final newMessage = StringBuffer()
    ..writeln(tituloMensagem(DateTime.now().weekday == 5))
    ..writeln(confirmedUsersMessage)
    ..writeln(declinedUsersMessage)
    ..writeln(usersNotConfirmedMessage)
    ..writeln();

  await bot.httpEndpoints.editMessage(
    channelId,
    messageId,
    MessageBuilder.content(newMessage.toString()),
  );
}

int _sortUsers(IUser user1, IUser user2) => (user1.globalName ?? user1.username)
    .compareTo(user2.globalName ?? user2.username);
