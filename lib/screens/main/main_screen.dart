import 'package:flutter/material.dart';
import 'package:forumlite/shared/topic_tile.dart'; 
import 'bloc/main_bloc.dart';
import 'bloc/main_event.dart';
import 'bloc/main_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TopicsBloc()..add(LoadTopicsEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Tópicos do Fórum")),
        body: BlocBuilder<TopicsBloc, TopicsState>(
          builder: (context, state) {
            if (state is TopicsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TopicsLoaded) {
              final topics = state.topics;
              return ListView.builder(
                itemCount: topics.length,
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemBuilder: (context, index) {
                  final topic = topics[index];
                  return TopicTile(
                    title: topic.title,
                    description: topic.description,
                    authorName: topic.authorName,
                    postCount: topic.postCount,
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Clicou no tópico: ${topic.title}'))),
                    onLongPress: () => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Segurou no tópico: ${topic.title}'))),
                  );
                },
              );
            } else if (state is TopicsError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
