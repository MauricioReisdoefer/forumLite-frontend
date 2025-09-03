import 'package:flutter_bloc/flutter_bloc.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterInitial()) {
    on<RegisterSubmittedEvent>(_onRegisterSubmitted);
  }

  Future<void> _onRegisterSubmitted(
    RegisterSubmittedEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterInitial()); 
    try {
      
      // TO-DO CONNECT WITH BACKEND

      // Verificação simples de senha
      if (event.password != event.confirmPassword) {
        emit(const RegisterFailure("As senhas não coincidem"));
        return;
      }

      if (event.name.isEmpty || event.password.isEmpty) {
        emit(const RegisterFailure("Preencha todos os campos"));
        return;
      }

      // Sucesso
      emit(const RegisterSuccess());
    } catch (e) {
      emit(RegisterFailure("Erro inesperado: $e"));
    }
  }
}
