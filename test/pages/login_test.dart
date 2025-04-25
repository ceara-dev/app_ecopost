import 'package:app_ecopost/pages/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Teste da tela de login', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginPage(),
      ),
    );

    expect(find.text('Login'), findsOneWidget);
    expect(find.text('EcoPost'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('E-mail'), findsOneWidget);
    expect(find.text('Senha'), findsOneWidget);
    expect(find.byIcon(Icons.email), findsOneWidget);
    expect(find.byIcon(Icons.lock), findsOneWidget);
    expect(find.text('Entrar'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'teste@teste.com');

    await tester.enterText(find.byType(TextFormField).at(1), '123456');

    await tester.tap(find.text('Entrar'));

    await tester.pump();
  });
}
