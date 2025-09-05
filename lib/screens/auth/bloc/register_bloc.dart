import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
      if (event.password != event.confirmPassword) {
        emit(const RegisterFailure("As senhas não coincidem"));
        return;
      }

      if (event.name.isEmpty || event.password.isEmpty) {
        emit(const RegisterFailure("Preencha todos os campos"));
        return;
      }

      final apiUrl = dotenv.env['API_URL'];
      if (apiUrl == null) {
        emit(const RegisterFailure("API_URL não configurada"));
        return;
      }

      final response = await http.post(
        Uri.parse("$apiUrl/users/create"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "username": event.name,
          "password": event.password,
        }),
      );

      if (response.statusCode == 200) {
        emit(const RegisterSuccess());
      } else {
        emit(RegisterFailure("Erro no cadastro: ${response.body}"));
      }
    } catch (e) {
      emit(RegisterFailure("Erro inesperado: $e"));
    }
  }
}
