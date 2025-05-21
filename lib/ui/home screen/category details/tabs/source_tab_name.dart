import 'package:flutter/material.dart';
import 'package:news/model/source_response.dart';

class SourceTabName extends StatelessWidget {
  final Sources sources;
  final bool isSelected;
  const SourceTabName({
    super.key,
    required this.sources,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      sources.name ?? '',
      style:
          isSelected
              ? TextTheme.of(context).labelSmall
              : TextTheme.of(context).bodySmall,
    );
  }
}
