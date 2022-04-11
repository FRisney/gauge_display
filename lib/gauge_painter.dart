part of 'gauge_display.dart';

class GaugePainter extends CustomPainter {
  GaugePainter({
    required this.percentage,
    required this.pointerLength,
    required this.pointerInset,
    required this.fillColor,
    required this.pointerColor,
    required this.extend,
    required this.lineWidths,
    required this.blur,
    required this.shadowOpacity,
    required this.bgOpacity,
    required this.useWidth,
  }) : super();
  final double percentage;
  final double lineWidths;
  final double pointerLength;
  final double pointerInset;
  final Color pointerColor;
  final Color fillColor;
  final double extend;
  final double blur;
  final double shadowOpacity;
  final double bgOpacity;
  final bool useWidth;
  @override
  void paint(Canvas canvas, Size size) {
    final finalAngle = _angleToRadian(180 + (extend * 2));
    final initialAngle = _angleToRadian(180 - extend);
    final radius = (useWidth) ? (size.width / 2) : (size.height / 8 * 6);
    final center = Offset(size.width / 2, radius);
    final finalPoint = finalAngle * percentage - _angleToRadian(extend);
    final pointerStart = (radius - pointerInset) - pointerLength;
    final pointerEnd = radius - pointerInset;
    final Map arcs = {
      'shadow': {
        'line': Paint()
          ..isAntiAlias = true
          ..color = Colors.black.withOpacity(shadowOpacity)
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke
          ..strokeWidth = lineWidths
          ..imageFilter = ImageFilter.blur(sigmaX: blur, sigmaY: blur),
      },
      'bg': {
        'line': Paint()
          ..isAntiAlias = true
          ..color = Colors.black.withOpacity(bgOpacity)
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke
          ..strokeWidth = lineWidths,
      },
      'fill': {
        'line': Paint()
          ..isAntiAlias = true
          ..color = fillColor
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke
          ..strokeWidth = lineWidths,
        'final': finalAngle * percentage,
      },
    };
    arcs.forEach((key, value) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        initialAngle,
        value['final'] ?? finalAngle,
        false,
        value['line'],
      );
    });
    canvas.drawLine(
      Offset(
        center.dx - pointerEnd * cos(finalPoint),
        center.dy - pointerEnd * sin(finalPoint),
      ),
      Offset(
        center.dx - pointerStart * cos(finalPoint),
        center.dy - pointerStart * sin(finalPoint),
      ),
      Paint()
        ..style = PaintingStyle.stroke
        ..color = pointerColor
        ..strokeCap = StrokeCap.round
        ..strokeWidth = lineWidths,
    );
  }

  double _angleToRadian(double angle) {
    return angle * pi / 180;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
