import 'package:flutter/material.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<bool> _checkIfOnboardingCompleted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboardingCompleted') ?? false;
  }

  Future<void> _redirectUserIfNeeded(BuildContext context) async {
    bool onboardingCompleted = await _checkIfOnboardingCompleted();
    await Future.delayed(const Duration(seconds: 1));
    if (onboardingCompleted) {
      await Navigator.pushReplacementNamed(context, '/login');
      return;
    }
    await Navigator.pushReplacementNamed(context, '/onboarding');
  }

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.white,
      onInit: () {
        print("Splash iniciado");
      },
      onEnd: () {
        print("Splash concluído");
      },
      childWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/logo_sem_fundo.png',
            width: 250,
            height: 250,
          ),
        ],
      ),
      onAnimationEnd: () async {
        await _redirectUserIfNeeded(context);
      },
    );
  }
}
