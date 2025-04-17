import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  // Controlador para o PageView
  final PageController _pageController = PageController(initialPage: 0);

  // Índice da página atual
  int _currentPage = 0;

  // Lista de dados para as páginas do onboarding
  final List<Map<String, String>> _onboardingData = [
    {
      "title": "Bem-vindo ao App!",
      "description":
          "Explore as funcionalidades incríveis que preparamos para você.",
      "image":
          "assets/logo_sem_fundo.png", // Substitua pelo caminho real das imagens
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

  // Verifica se o onboarding já foi concluído
  Future<bool> _checkIfOnboardingCompleted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboardingCompleted') ?? false;
  }

  // Marca o onboarding como concluído
  Future<void> _markOnboardingAsCompleted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingCompleted', true);
  }

  @override
  void initState() {
    super.initState();
    _redirectUserIfNeeded();
  }

  // Redireciona o usuário para a próxima tela se o onboarding já foi concluído
  Future<void> _redirectUserIfNeeded() async {
    bool onboardingCompleted = await _checkIfOnboardingCompleted();
    if (onboardingCompleted) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Exibição das páginas do onboarding
            Expanded(
              child: PageView.builder(
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

            // Indicadores de página (dots)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _onboardingData.length,
                (index) => _buildDot(index == _currentPage),
              ),
            ),

            // Botão "Próximo" ou "Concluir"
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () async {
                  if (_currentPage < _onboardingData.length - 1) {
                    // Avança para a próxima página
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
                child: Text(_currentPage == _onboardingData.length - 1
                    ? "Concluir"
                    : "Próximo"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Constrói uma única página do onboarding
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
          ),
          const SizedBox(height: 20),
          Text(
            data["title"]!,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            data["description"]!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[700],
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Constrói os indicadores de página (dots)
  Widget _buildDot(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 20 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
