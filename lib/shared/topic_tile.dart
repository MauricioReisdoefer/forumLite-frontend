import 'package:flutter/material.dart';

class TopicTile extends StatelessWidget {
  final String title;
  final String description;
  final String authorName;      
  final int? postCount;          
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Widget? trailing;

  const TopicTile({
    super.key,
    required this.title,
    required this.description,
    required this.authorName,
    this.postCount,
    this.onTap,
    this.onLongPress,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondary = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );

    return Card(
      elevation: 1.5,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.topic_rounded),
            ),
            title: Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Descrição do tópico
                  Text(
                    description,
                    style: theme.textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Metadados: autor e contagem de posts
                  Row(
                    children: [
                      Icon(Icons.person_rounded, size: 14, color: secondary?.color),
                      const SizedBox(width: 4),
                      Text(authorName, style: secondary),
                      if (postCount != null) ...[
                        const SizedBox(width: 12),
                        const Text('•'),
                        const SizedBox(width: 12),
                        Icon(Icons.message_rounded, size: 14, color: secondary?.color),
                        const SizedBox(width: 4),
                        Text('$postCount posts', style: secondary),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            trailing: trailing,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ),
      ),
    );
  }
}
