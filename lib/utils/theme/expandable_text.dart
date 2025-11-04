import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText({
    super.key,
    required this.text,
    this.trimLines = 2,
    this.style,
    this.textAlign,
    this.moreText = 'More',
    this.lessText = 'Less',
    this.buttonStyle,
  });

  final String text;
  final int trimLines;
  final TextStyle? style;
  final TextAlign? textAlign;

  /// Labels
  final String moreText;
  final String lessText;

  /// Optional style for the toggle button (falls back to Theme text button)
  final ButtonStyle? buttonStyle;

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _expanded = false;
  bool _isOverflow = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        // Measure once per build to know if it overflows with trimLines
        final span = TextSpan(text: widget.text, style: widget.style);
        final tp = TextPainter(
          text: span,
          maxLines: widget.trimLines,
          textDirection: Directionality.of(context),
        )..layout(maxWidth: constraints.maxWidth);

        _isOverflow = tp.didExceedMaxLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.text,
              style: widget.style,
              textAlign: widget.textAlign,
              maxLines: _expanded ? null : widget.trimLines,
              overflow:
                  _expanded ? TextOverflow.visible : TextOverflow.ellipsis,
            ),
            if (_isOverflow)
              TextButton(
                style: widget.buttonStyle,
                onPressed: () => setState(() => _expanded = !_expanded),
                child: Text(_expanded ? widget.lessText : widget.moreText),
              ),
          ],
        );
      },
    );
  }
}
