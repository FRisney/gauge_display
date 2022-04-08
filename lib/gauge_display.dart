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
  }) : super(key: key);
  final String? unit;
  final num? min;
  final num? max;
  final num updatedValue;

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
          fillColor: Colors.grey.shade700,
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
