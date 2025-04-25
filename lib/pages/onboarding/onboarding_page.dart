import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController(initialPage: 0);

  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "title": "Bem-vindo ao App!",
      "description":
          "Explore as funcionalidades incríveis que preparamos para você.",
      "image": "assets/logo_sem_fundo.png",
    },
    {
      "title": "Gerencie Suas Tarefas",
      "description":
          "Organize suas tarefas diárias de forma simples e eficiente.",
      "image": "assets/logo_sem_fundo.png",
    },
    {
      "title": "Acompanhe Seu Progresso",
      "description":
          "Monitore seu progresso e alcance suas metas com facilidade.",
      "image": "assets/logo_sem_fundo.png",
    },
  ];

  Future<bool> _checkIfOnboardingCompleted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboardingCompleted') ?? false;
  }

  Future<void> _markOnboardingAsCompleted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingCompleted', true);
  }

  @override
  void initState() {
    super.initState();
    _redirectUserIfNeeded();
  }

  Future<void> _redirectUserIfNeeded() async {
    bool onboardingCompleted = await _checkIfOnboardingCompleted();
    if (onboardingCompleted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                key: const Key('onboardingPageView'),
                controller: _pageController,
                itemCount: _onboardingData.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return _buildOnboardingPage(_onboardingData[index]);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _onboardingData.length,
                (index) => _buildDot(index),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                key: Key('onboardingButton'),
                onPressed: () async {
                  if (_currentPage < _onboardingData.length - 1) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    await _markOnboardingAsCompleted();
                    Navigator.pushReplacementNamed(context, '/login');
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Semantics(
                  label: 'btn_onboarding',
                  enabled: true,
                  child: Text(_currentPage == _onboardingData.length - 1
                      ? "Concluir"
                      : "Próximo"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(Map<String, String> data) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            data["image"]!,
            height: 200,
            width: 200,
            key: Key('onboardingImage_${_currentPage}'),
          ),
          const SizedBox(height: 20),
          Text(
            data["title"]!,
            key: Key('onboardingTitle_${_currentPage}'),
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            data["description"]!,
            key: Key('onboardingDescription_${_currentPage}'),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[700],
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      key: Key('dot_$index'),
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: _currentPage == index ? 20 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.blue : Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
