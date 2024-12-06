import 'package:notes_app/feature/domain/entities/auth_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    String? name,
    String? email,
    String? password,
  }) : super(name: name, email: email, password: password);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      password: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      // Excluimos la contraseña para evitar problemas de seguridad.
    };
  }
}
