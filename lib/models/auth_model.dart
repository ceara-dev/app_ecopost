class AuthModel {
  String id;
  String primeiro_nome;
  String segundo_nome;
  String token;
  String data_nascimento;
  String email;

  AuthModel({
    required this.id,
    required this.primeiro_nome,
    required this.segundo_nome,
    required this.token,
    required this.data_nascimento,
    required this.email,
  });
}
