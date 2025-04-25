import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'providers/home_provider.dart';
import 'providers/login_provider.dart';
import 'wigets/custom_flutter_error_widget.dart';
import 'database/database.dart';
import 'utils/app_theme.dart';
import 'routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final databaseApp = DatabaseApp();

  String envFileName = '.env';

  try {
    await dotenv.load(fileName: envFileName);
  } catch (e) {
    print("Erro ao carregar o arquivo .env: $e");
    return;
  }

  await databaseApp.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider(databaseApp)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    String appName = dotenv.env['APP_NAME'] ?? 'Default App Name';

    return MaterialApp(
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        ErrorWidget.builder = (errorDetails) {
          return CustomFlutterErrorWidget(errorDetails: errorDetails);
        };
        return child!;
      },
      title: appName,
      initialRoute: '/',
      routes: Routes.routes,
    );
  }
}
