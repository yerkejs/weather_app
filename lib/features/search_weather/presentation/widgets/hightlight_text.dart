import 'package:flutter/material.dart';

class HighlightText extends StatelessWidget {
  final String text;
  final String highlight;
  final TextStyle style;
  final Color highlightColor;
  final int maxLines;

  const HighlightText({
    @required this.style,
    @required this.text,
    @required this.highlight,
    this.highlightColor,
    this.maxLines,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String text = this.text ?? '';
    if ((highlight?.isEmpty ?? true) || text.isEmpty) {
      return Text(text, style: style);
    }

    List<TextSpan> spans = [];
    int start = 0;
    int indexOfHighlight;
    
    do {
      indexOfHighlight = text.indexOf(highlight, start);
      if (indexOfHighlight < 0) {
        
        // Показываем простой текст
        spans.add(_normalSpan(text.substring(start, text.length)));
        break;
      }
      if (indexOfHighlight == start) {
        // Начинается с highlighted
        spans.add(_highlightSpan(highlight));
        start += highlight.length;
      } else {
        // Начинается не с highlighted text 
        spans.add(_normalSpan(text.substring(start, indexOfHighlight)));
        spans.add(_highlightSpan(highlight));
        start = indexOfHighlight + highlight.length;
      }
    } while (true);

    return Text.rich(
      TextSpan(children: spans),
      maxLines: maxLines,
    );
  }

  TextSpan _highlightSpan(String content) {
    return TextSpan(text: content, style: style.copyWith(color: highlightColor));
  }

  TextSpan _normalSpan(String content) {
    return TextSpan(text: content, style: style);
  }
}