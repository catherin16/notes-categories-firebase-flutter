import 'package:firebase_auth/firebase_auth.dart';

/// Clase base para los estados de autenticación
abstract class AuthState {}

/// Estado inicial de la autenticación
class AuthInitial extends AuthState {}

/// Estado de carga mientras se realiza una operación (login, registro, etc.)
class AuthLoading extends AuthState {}

/// Estado de autenticación exitosa
class AuthAuthenticated extends AuthState {
  final User user;

  AuthAuthenticated(this.user);
}

/// Estado cuando el usuario cierra sesión
class AuthLoggedOut extends AuthState {}

/// Estado de error en autenticación
class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}
