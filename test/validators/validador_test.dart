// test/validators/validador_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:app_ecopost/helpers/validador.dart';

void main() {
  group('Validador', () {
    group('validarEmail', () {
      test('deve retornar null para um email válido', () {
        final resultado = Validador.validarEmail("usuario@example.com");
        expect(resultado, isNull);
      });

      test('deve retornar erro para um email vazio', () {
        final resultado = Validador.validarEmail("");
        expect(resultado, equals("O campo email é obrigatório."));
      });

      test('deve retornar erro para um email sem @', () {
        final resultado = Validador.validarEmail("usuarioexample.com");
        expect(resultado, equals("Por favor, insira um email válido."));
      });
    });

    // Subgrupo para testar o método validarSenha
    group('validarSenha', () {
      test('deve retornar null para uma senha válida', () {
        final resultado = Validador.validarSenha("senha12345");
        expect(resultado, isNull);
      });

      test('deve retornar erro para uma senha vazia', () {
        final resultado = Validador.validarSenha("");
        expect(resultado, equals("O campo senha é obrigatório."));
      });

      test('deve retornar erro para uma senha com menos de 8 caracteres', () {
        final resultado = Validador.validarSenha("1234");
        expect(resultado, equals("A senha deve ter pelo menos 8 caracteres."));
      });
    });

    group('validarCampoGenerico', () {
      test('deve retornar null para um campo preenchido', () {
        final resultado = Validador.validarCampoGenerico("valor", "Nome");
        expect(resultado, isNull);
      });

      test('deve retornar erro para um campo vazio', () {
        final resultado = Validador.validarCampoGenerico("", "Nome");
        expect(resultado, equals("O campo Nome é obrigatório."));
      });
    });
  });
}
