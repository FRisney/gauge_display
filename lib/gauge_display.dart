library gauge_display;

import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
part 'gauge_painter.dart';

class GaugeDisplay extends StatefulWidget {
  const GaugeDisplay({
    Key? key,
    this.unit,
    this.min,
    this.max,
    required this.updatedValue,
    this.percentage,
    this.lineWidths,
    this.pointerLength,
    this.pointerInset,
    this.pointerColor,
    this.fillColor,
    this.extend,
    this.blur,
    this.shadowOpacity,
    this.bgOpacity,
  }) : super(key: key);
  final String? unit;
  final num? min;
  final num? max;
  final num updatedValue;

  final double? percentage;
  final double? lineWidths;
  final double? pointerLength;
  final double? pointerInset;
  final Color? pointerColor;
  final Color? fillColor;
  final double? extend;
  final double? blur;
  final double? shadowOpacity;
  final double? bgOpacity;

  @override
  State<GaugeDisplay> createState() => _GaugeDisplayState();
}

class _GaugeDisplayState extends State<GaugeDisplay> {
  @override
  Widget build(BuildContext context) {
    double _percentage =
        widget.updatedValue / ((widget.max ?? 100) - (widget.min ?? 0));
    if (_percentage > 1.0) _percentage = 1.0;
    var maxSize = MediaQuery.of(context).size / 2;
    return Container(
      constraints: BoxConstraints.loose(maxSize),
      child: CustomPaint(
        child: Container(
          margin: const EdgeInsets.only(top: 32.0),
          child: RichText(
            textAlign: TextAlign.center,
            text: _text(context),
          ),
        ),
        painter: GaugePainter(
          percentage: _percentage,
          pointerLength: widget.pointerLength ?? 5.0,
          pointerInset: widget.pointerInset ?? 0.0,
          fillColor: widget.fillColor ?? Colors.black,
          pointerColor: widget.pointerColor ?? Colors.black,
          extend: widget.extend ?? 15,
          lineWidths: widget.lineWidths ?? 5.0,
          blur: widget.blur ?? 3.0,
          shadowOpacity: widget.shadowOpacity ?? 0.3,
          bgOpacity: widget.bgOpacity ?? 0.1,
        ),
      ),
    );
  }

  _text(context) {
    if (widget.unit == null) {
      return TextSpan(
        text: widget.updatedValue.toString(),
        style: Theme.of(context).textTheme.titleLarge,
      );
    } else {
      return TextSpan(
        children: <InlineSpan>[
          TextSpan(
            text: widget.updatedValue.toString(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          TextSpan(
            text: '\n${widget.unit}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      );
    }
  }
}
