import 'package:flutter_bloc/flutter_bloc.dart';
import 'main_event.dart';
import 'main_state.dart';

class TopicsBloc extends Bloc<TopicsEvent, TopicsState> {
  TopicsBloc() : super(TopicsInitial()) {
    on<LoadTopicsEvent>((event, emit) async {
      emit(TopicsLoading());

      try {
        // GET WITH AN API, TO-DO CONNECT WITH DB
        await Future.delayed(const Duration(seconds: 1));
        final topics = [
          Topic(
            title: "Flutter 3.0 Lançamento",
            description: "Vamos discutir as novidades do Flutter 3.0 e como elas impactam no desenvolvimento.",
            authorName: "Maurício",
            postCount: 12,
          ),
          Topic(
            title: "Dicas de Dart",
            description: "Compartilhe suas melhores práticas e truques em Dart.",
            authorName: "Ana",
            postCount: 7,
          ),
          Topic(
            title: "State Management",
            description: "Qual é a melhor abordagem para gerenciar estado em apps grandes?",
            authorName: "Carlos",
            postCount: 20,
          ),
          Topic(
            title: "Widgets Customizados",
            description: "Como criar widgets reutilizáveis e bonitos no Flutter.",
            authorName: "Laura",
          ),
        ];
        emit(TopicsLoaded(topics));
      } catch (e) {
        emit(TopicsError("Erro ao carregar tópicos"));
      }
    });
  }
}
