import 'package:flutter/material.dart';

class PostTile extends StatelessWidget {
  final String title;
  final String textPreview;
  final String authorName;       
  final String topicTitle;      
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Widget? leading;         
  final Widget? trailing;       

  const PostTile({
    super.key,
    required this.title,
    required this.textPreview,
    required this.authorName,
    required this.topicTitle,
    this.onTap,
    this.onLongPress,
    this.leading,
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
            leading: leading ??
                CircleAvatar(
                  child: Text(
                    authorName.isNotEmpty ? authorName[0].toUpperCase() : '?',
                  ),
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
                  Text(
                    textPreview,
                    style: theme.textTheme.bodyMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Icon(Icons.person_rounded, size: 14, color: secondary?.color),
                      Text(authorName, style: secondary),
                      const Text('•'),
                      Icon(Icons.forum_rounded, size: 14, color: secondary?.color),
                      Text(topicTitle, style: secondary),
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