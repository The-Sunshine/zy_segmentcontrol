import 'package:flutter/material.dart';

/// 分类组件，实现TabController指示器的宽度自定义
class TabIndicatorline extends Decoration {

  const TabIndicatorline({
    this.borderSide = const BorderSide(width: 2.0, color: Colors.white),
    this.insets = EdgeInsets.zero,
    this.IndicatorWidth = 24,
  }) : assert(borderSide != null),
        assert(insets != null);

  final BorderSide borderSide;
  final EdgeInsetsGeometry insets;
  final IndicatorWidth;

  @override
  Decoration? lerpFrom(Decoration? a, double t) {
    if (a is TabIndicatorline) {
      return TabIndicatorline(
        borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
        insets: EdgeInsetsGeometry.lerp(a.insets, insets, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration? lerpTo(Decoration? b, double t) {
    if (b is TabIndicatorline) {
      return TabIndicatorline(
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
        insets: EdgeInsetsGeometry.lerp(insets, b.insets, t)!,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  BoxPainter createBoxPainter([ VoidCallback? onChanged ]) {
    return _indicatorlinePainter(this, onChanged);
  }

  Rect _indicatorRectFor(Rect rect, TextDirection textDirection) {
    assert(rect != null);
    assert(textDirection != null);
    final Rect indicator = insets.resolve(textDirection).deflateRect(rect);

    double cw = (indicator.left + indicator.right) / 2;
    return Rect.fromLTWH(
      cw - this.IndicatorWidth / 2,
      indicator.bottom - borderSide.width,
      this.IndicatorWidth,
      borderSide.width,
    );
  }

  @override
  Path getClipPath(Rect rect, TextDirection textDirection) {
    return Path()..addRect(_indicatorRectFor(rect, textDirection));
  }
}

class _indicatorlinePainter extends BoxPainter {
  _indicatorlinePainter(this.decoration, VoidCallback? onChanged)
      : assert(decoration != null),
        super(onChanged);

  final TabIndicatorline decoration;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size!;
    final TextDirection textDirection = configuration.textDirection!;
    final Rect indicator = decoration._indicatorRectFor(rect, textDirection).deflate(decoration.borderSide.width / 2.0);
    final Paint paint = decoration.borderSide.toPaint()..strokeCap = StrokeCap.square;
    canvas.drawLine(indicator.bottomLeft, indicator.bottomRight, paint);
  }
}
