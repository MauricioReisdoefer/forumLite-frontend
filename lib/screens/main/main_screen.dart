import 'package:flutter/material.dart';
import 'package:forumlite/shared/topic_tile.dart'; 

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({super.key});
  final List<Map<String, dynamic>> topics = const [
    {
      "title": "Flutter 3.0 Lançamento",
      "description": "Vamos discutir as novidades do Flutter 3.0 e como elas impactam no desenvolvimento.",
      "authorName": "Maurício",
      "postCount": 12,
    },
    {
      "title": "Dicas de Dart",
      "description": "Compartilhe suas melhores práticas e truques em Dart.",
      "authorName": "Ana",
      "postCount": 7,
    },
    {
      "title": "State Management",
      "description": "Qual é a melhor abordagem para gerenciar estado em apps grandes?",
      "authorName": "Carlos",
      "postCount": 20,
    },
    {
      "title": "Widgets Customizados",
      "description": "Como criar widgets reutilizáveis e bonitos no Flutter.",
      "authorName": "Laura",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tópicos do Fórum"),
      ),
      body: ListView.builder(
        itemCount: topics.length,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (context, index) {
          final topic = topics[index];
          return TopicTile(
            title: topic['title'],
            description: topic['description'],
            authorName: topic['authorName'],
            postCount: topic['postCount'],
            onTap: () {
              // Ação ao clicar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Clicou no tópico: ${topic['title']}')),
              );
            },
            onLongPress: () {
              // Ação ao segurar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Segurou no tópico: ${topic['title']}')),
              );
            },
          );
        },
      ),
    );
  }
}
