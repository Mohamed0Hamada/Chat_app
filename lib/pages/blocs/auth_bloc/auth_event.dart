part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class LoginRequested extends AuthEvent {
  String email;
  String password;
  LoginRequested({required this.email, required this.password});
}
final class RegisterRequested extends AuthEvent {
  String email;
  String password;
  RegisterRequested({required this.email, required this.password});
}
