import 'package:flutter/material.dart';

class PerfilProvider with ChangeNotifier {
  String _nome = '';
  String _dataNascimento = '';
  String _primeiroNome = '';
  String _segundoNome = '';
  String _email = '';
  String _senha = '';

  // Getters
  String get nome => _nome;
  String get dataNascimento => _dataNascimento;
  String get primeiroNome => _primeiroNome;
  String get segundoNome => _segundoNome;
  String get email => _email;
  String get senha => _senha;

  // Setters
  void setNome(String value) {
    _nome = value;
    notifyListeners();
  }

  void setDataNascimento(String value) {
    _dataNascimento = value;
    notifyListeners();
  }

  void setPrimeiroNome(String value) {
    _primeiroNome = value;
    notifyListeners();
  }

  void setSegundoNome(String value) {
    _segundoNome = value;
    notifyListeners();
  }

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setSenha(String value) {
    _senha = value;
    notifyListeners();
  }
}
