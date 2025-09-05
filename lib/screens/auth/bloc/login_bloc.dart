import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginInitial()) {
    on<LoginSubmittedEvent>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmittedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginLoading());

    try {
      if (event.username.isEmpty || event.password.isEmpty) {
        emit(const LoginFailure("Preencha todos os campos"));
        return;
      }

      final apiUrl = dotenv.env['API_URL'];
      if (apiUrl == null) {
        emit(const LoginFailure("API_URL não configurada"));
        return;
      }

      final response = await http.post(
        Uri.parse("$apiUrl/users/login"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "username": event.username,
          "password": event.password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'] ?? "";
        emit(LoginSuccess(token));
      } else {
        emit(LoginFailure("Erro no login: ${response.body}"));
      }
    } catch (e) {
      emit(LoginFailure("Erro inesperado: $e"));
    }
  }
}
