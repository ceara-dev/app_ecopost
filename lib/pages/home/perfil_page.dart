import 'package:app_ecopost/utils/app_theme.dart';
import 'package:flutter/material.dart';
import '../../helpers/validador.dart';
import '../../providers/perfil_provider.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscureSenha = true;
  bool _isObscureConfirmarSenha = true;

  @override
  Widget build(BuildContext context) {
    final perfilProvider = PerfilProvider();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Primeiro Nome'),
              validator: (value) =>
                  Validador.validarCampoGenerico(value, "Primeiro Nome"),
              onChanged: (value) => perfilProvider.setPrimeiroNome(value),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Segundo Nome'),
              validator: (value) =>
                  Validador.validarCampoGenerico(value, "Segundo Nome"),
              onChanged: (value) => perfilProvider.setSegundoNome(value),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration:
                  const InputDecoration(labelText: 'Data de Nascimento'),
              keyboardType: TextInputType.datetime,
              validator: (value) =>
                  Validador.validarCampoGenerico(value, "Data de Nascimento"),
              onChanged: (value) => perfilProvider.setDataNascimento(value),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'E-mail'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) => Validador.validarEmail(value),
              onChanged: (value) => perfilProvider.setEmail(value),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Senha',
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscureSenha ? Icons.visibility_off : Icons.visibility,
                    color: AppTheme.primaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscureSenha = !_isObscureSenha;
                    });
                  },
                ),
              ),
              obscureText: _isObscureSenha,
              validator: (value) => Validador.validarSenha(value),
              onChanged: (value) => perfilProvider.setSenha(value),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Confirmar Senha',
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscureConfirmarSenha
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppTheme.primaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscureConfirmarSenha = !_isObscureConfirmarSenha;
                    });
                  },
                ),
              ),
              obscureText: _isObscureConfirmarSenha,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Por favor, confirme sua senha.";
                } else if (value != perfilProvider.senha) {
                  return "As senhas não coincidem.";
                }
                return null;
              },
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Dados salvos com sucesso!')),
                    );
                  }
                },
                child: const Text('Salvar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
