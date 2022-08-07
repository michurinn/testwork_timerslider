import 'package:flutter/material.dart';

class UnicornOutlineButton extends StatelessWidget {
  final _GradientPainter _painter;
  final Widget child;
  final VoidCallback? onPressed;
  final double radius;
  final bool fill;
  final double minWidth;
  final double minHeight;
  final String? bannerText;
  final Color? fillColor;

  UnicornOutlineButton({
    required double strokeWidth,
    required Gradient gradient,
    required this.radius,
    required this.child,
    required this.onPressed,
    this.minWidth = 100,
    this.minHeight = 50,
    this.fill = false,
    this.bannerText,
    this.fillColor,
  }) : _painter = _GradientPainter(
          strokeWidth: strokeWidth,
          radius: radius,
          gradient: gradient,
          fill: fill,
          fillColor: fillColor,
        );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          painter: _painter,
          child: Material(
            type: MaterialType.transparency,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: onPressed,
              child: InkWell(
                borderRadius: BorderRadius.circular(radius),
                onTap: onPressed,
                child: Container(
                  constraints: BoxConstraints(minWidth: minWidth, minHeight: minHeight),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      child,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        if (bannerText != null)
          IntrinsicHeight(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: Banner(
                message: bannerText!,
                location: BannerLocation.topStart,
                child: Container(
                  constraints: BoxConstraints(minWidth: minWidth, minHeight: minHeight),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _GradientPainter extends CustomPainter {
  final Paint _paint = Paint();
  final double radius;
  final double strokeWidth;
  final Gradient gradient;
  final bool fill;
  final Color? fillColor;

  _GradientPainter({
    required this.strokeWidth,
    required this.radius,
    required this.gradient,
    this.fill = false,
    this.fillColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // create outer rectangle equals size
    final outerRect = Offset.zero & size;
    final outerRRect = RRect.fromRectAndRadius(outerRect, Radius.circular(radius));

    // create inner rectangle smaller by strokeWidth
    final innerRect =
        Rect.fromLTWH(strokeWidth, strokeWidth, size.width - strokeWidth * 2, size.height - strokeWidth * 2);
    final innerRRect = RRect.fromRectAndRadius(innerRect, Radius.circular(radius - strokeWidth));

    // apply gradient shader
    _paint.shader = gradient.createShader(outerRect);

    // create difference between outer and inner paths and draw it
    final path1 = Path()..addRRect(outerRRect);
    final path2 = Path()..addRRect(innerRRect);
    if (!fill) {
      if (fillColor != null) {
        final bgrPaint = Paint();
        bgrPaint.color = fillColor!;
        canvas.drawPath(path1, bgrPaint);
      }
      final path = Path.combine(PathOperation.difference, path1, path2);
      canvas.drawPath(path, _paint);
    } else {
      canvas.drawPath(path1, _paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}
