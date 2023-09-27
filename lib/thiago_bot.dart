import 'package:cron/cron.dart';
import 'package:nyxx/nyxx.dart';
import 'src/send_presencial_message.dart.dart';
import 'src/get_token.dart';
import 'src/register_bot.dart';

Future<void> runBot() async {
  final token = getToken();
  final bot = await registerBot(
    token.run(),
    GatewayIntents.all,
  );

  await Future.delayed(const Duration(seconds: 3));

  final cron = Cron();

  cron.schedule(Schedule.parse('30 18 * * 1-5'), () async {
    await sendPresencialMessage(bot);
  });
}
