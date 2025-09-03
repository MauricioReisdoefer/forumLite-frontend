import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object?> get props => [];
}

// Estado inicial (nada digitado)
class RegisterInitial extends RegisterState {
  const RegisterInitial();
}

// Estado de submissão (quando usuário preencheu os dados e clicou no botão)
class RegisterSubmitted extends RegisterState {
  final String confirmPassword;
  final String password;
  final String name;

  const RegisterSubmitted({
    required this.confirmPassword,
    required this.password,
    required this.name,
  });

  @override
  List<Object?> get props => [confirmPassword, password, name];
}

// Estado de sucesso
class RegisterSuccess extends RegisterState {
  const RegisterSuccess();
}

// Estado de erro
class RegisterFailure extends RegisterState {
  final String message;
  const RegisterFailure(this.message);

  @override
  List<Object?> get props => [message];
}
