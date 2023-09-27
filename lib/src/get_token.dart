import 'package:dotenv/dotenv.dart';
import 'package:fpdart/fpdart.dart';

IO<String> getToken() => IO(() {
      final env = DotEnv()..load();
      return env['DISCORD_TOKEN'] ?? '';
    });
