// main.dart
import 'package:flutter/material.dart';
import 'providers/login_provider.dart';
import 'database/database.dart';
import 'routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'wigets/custom_flutter_error_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final databaseApp = DatabaseApp();

  await Future.wait([
    dotenv.load(),
    databaseApp.init(),
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        ErrorWidget.builder = (errorDetails) {
          return CustomFlutterErrorWidget(errorDetails: errorDetails);
        };
        return child!;
      },
      title: 'EcoPost',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/onboarding',
      routes: Routes.routes,
    );
  }
}
