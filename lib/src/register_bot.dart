import 'package:nyxx/nyxx.dart';
import 'package:thiago_bot/src/handlers/on_reaction_added_handler.dart';
import 'package:thiago_bot/src/handlers/on_reaction_removed_handler.dart';

Future<INyxxWebsocket> registerBot(
  String token,
  int intents,
) async {
  final bot = NyxxFactory.createNyxxWebsocket(token, intents)
    ..registerPlugin(Logging())
    ..registerPlugin(CliIntegration())
    ..registerPlugin(IgnoreExceptions());

  await bot.connect();

  bot.eventsWs.onMessageReactionAdded.listen((event) {
    onReactionAddedHandler(bot: bot, event: event);
  });

  bot.eventsWs.onMessageReactionRemove.listen((event) {
    onReactionRemovedHandler(bot: bot, event: event);
  });

  return bot;
}
