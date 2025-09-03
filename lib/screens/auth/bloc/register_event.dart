import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}
class RegisterSubmittedEvent extends RegisterEvent {
  final String name;
  final String password;
  final String confirmPassword;

  const RegisterSubmittedEvent({
    required this.name,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [name, password, confirmPassword];
}
