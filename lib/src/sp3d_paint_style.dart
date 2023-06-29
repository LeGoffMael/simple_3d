import 'dart:ui';

///
/// (en) Flutter implementation of Sp3dPaintStyle.
/// Sp3dPaintStyle is a class used in Sp3dMaterial that handles information such as colors.
///
/// (ja) Sp3dPaintStyleのflutter実装です。
/// Sp3dPaintStyleはSp3dMaterial内で使用される、色などの情報を扱うクラスです。
///
/// Author Le Goff Maël
///
/// First edition creation date 2023-06-29 19:19:00
///
class Sp3dPaintStyle {
  final String className = 'Sp3dPaintStyle';
  final String version = '1';
  Color? color;
  BlendMode? blendMode;
  // ColorFilter? colorFilter;
  FilterQuality? filterQuality;
  // ImageFilter? imageFilter;
  bool? invertColors;
  bool? isAntiAlias;
  // MaskFilter? maskFilter;
  // Shader? shader;
  StrokeCap? strokeCap;
  StrokeJoin? strokeJoin;
  double? strokeMiterLimit;
  double? strokeWidth;
  PaintingStyle? style;

  /// Constructor
  /// * [color] The color to use when stroking or filling a shape.
  /// * [blendMode] A blend mode to apply when a shape is drawn or a layer is composited.
  /// * [filterQuality] Controls the performance vs quality trade-off to use when sampling bitmaps.
  /// * [invertColors] Whether the colors of the image are inverted when drawn.
  /// * [isAntiAlias] Whether to apply anti-aliasing to lines and images drawn on the canvas.
  /// * [strokeCap] The kind of finish to place on the end of lines drawn when [style] is set to [PaintingStyle.stroke].
  /// * [strokeJoin] The kind of finish to place on the joins between segments.
  /// * [strokeMiterLimit] The limit for miters to be drawn on segments when the join is set to [StrokeJoin.miter] and the [style] is set to [PaintingStyle.stroke].
  /// * [strokeWidth] How wide to make edges drawn when [style] is set to [PaintingStyle.stroke].
  /// * [style] Whether to paint inside shapes, the edges of shapes, or both.
  Sp3dPaintStyle({
    this.color,
    this.blendMode,
    this.filterQuality,
    this.invertColors,
    this.isAntiAlias,
    this.strokeCap,
    this.strokeJoin,
    this.strokeMiterLimit,
    this.strokeWidth,
    this.style,
  });

  /// Convert the object to a dictionary.
  Sp3dPaintStyle deepCopy() {
    final mcolor = color == null
        ? null
        : Color.fromARGB(color!.alpha, color!.red, color!.green, color!.blue);

    return Sp3dPaintStyle(
      color: mcolor,
      blendMode: blendMode,
      filterQuality: filterQuality,
      invertColors: invertColors,
      isAntiAlias: isAntiAlias,
      strokeCap: strokeCap,
      strokeJoin: strokeJoin,
      strokeMiterLimit: strokeMiterLimit,
      strokeWidth: strokeWidth,
      style: style,
    );
  }

  /// Creates a copy with only the specified values rewritten.
  /// * [color] The color to use when stroking or filling a shape.
  /// * [blendMode] A blend mode to apply when a shape is drawn or a layer is composited.
  /// * [filterQuality] Controls the performance vs quality trade-off to use when sampling bitmaps.
  /// * [invertColors] Whether the colors of the image are inverted when drawn.
  /// * [isAntiAlias] Whether to apply anti-aliasing to lines and images drawn on the canvas.
  /// * [strokeCap] The kind of finish to place on the end of lines drawn when [style] is set to [PaintingStyle.stroke].
  /// * [strokeJoin] The kind of finish to place on the joins between segments.
  /// * [strokeMiterLimit] The limit for miters to be drawn on segments when the join is set to [StrokeJoin.miter] and the [style] is set to [PaintingStyle.stroke].
  /// * [strokeWidth] How wide to make edges drawn when [style] is set to [PaintingStyle.stroke].
  /// * [style] Whether to paint inside shapes, the edges of shapes, or both.
  Sp3dPaintStyle copyWith({
    Color? color,
    BlendMode? blendMode,
    FilterQuality? filterQuality,
    bool? invertColors,
    bool? isAntiAlias,
    StrokeCap? strokeCap,
    StrokeJoin? strokeJoin,
    double? strokeMiterLimit,
    double? strokeWidth,
    PaintingStyle? style,
  }) {
    final mcolor = this.color == null
        ? null
        : Color.fromARGB(this.color!.alpha, this.color!.red, this.color!.green,
            this.color!.blue);

    return Sp3dPaintStyle(
      color: color ?? mcolor,
      blendMode: blendMode ?? this.blendMode,
      filterQuality: filterQuality ?? this.filterQuality,
      invertColors: invertColors ?? this.invertColors,
      isAntiAlias: isAntiAlias ?? this.isAntiAlias,
      strokeCap: strokeCap ?? this.strokeCap,
      strokeJoin: strokeJoin ?? this.strokeJoin,
      strokeMiterLimit: strokeMiterLimit ?? this.strokeMiterLimit,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      style: style ?? this.style,
    );
  }

  /// Convert the object to a dictionary.
  Map<String, dynamic> toDict() {
    Map<String, dynamic> d = {};
    d['class_name'] = className;
    d['version'] = version;
    d['color'] = color == null
        ? null
        : [color!.alpha, color!.red, color!.green, color!.blue];
    d['blend_mode'] = blendMode?.name;
    d['filter_quality'] = filterQuality?.name;
    d['invert_colors'] = invertColors;
    d['is_anti_alias'] = isAntiAlias;
    d['stroke_cap'] = strokeCap?.name;
    d['stroke_join'] = strokeJoin?.name;
    d['stroke_miter_limit'] = strokeMiterLimit;
    d['stroke_width'] = strokeWidth;
    d['style'] = style?.name;
    return d;
  }

  /// Restore this object from the dictionary.
  /// * [src] : A dictionary made with toDict of this class.
  static Sp3dPaintStyle fromDict(Map<String, dynamic> src) {
    final mcolor = src.containsKey('blend_mode') && src['color'] != null
        ? Color.fromARGB(
            src['color'][0], src['color'][1], src['color'][2], src['color'][3])
        : null;

    return Sp3dPaintStyle(
      color: mcolor,
      blendMode: src.containsKey('blend_mode') && src['blend_mode'] != null
          ? BlendMode.values.asNameMap()[src['blend_mode']]
          : null,
      filterQuality:
          src.containsKey('filter_quality') && src['filter_quality'] != null
              ? FilterQuality.values.asNameMap()[src['filter_quality']]
              : null,
      invertColors:
          src.containsKey('invert_colors') && src['invert_colors'] != null
              ? src['invert_colors']
              : null,
      isAntiAlias:
          src.containsKey('is_anti_alias') && src['is_anti_alias'] != null
              ? src['is_anti_alias']
              : null,
      strokeCap: src.containsKey('stroke_cap') && src['stroke_cap'] != null
          ? StrokeCap.values.asNameMap()[src['stroke_cap']]
          : null,
      strokeJoin: src.containsKey('stroke_join') && src['stroke_join'] != null
          ? StrokeJoin.values.asNameMap()[src['stroke_join']]
          : null,
      strokeMiterLimit: src.containsKey('stroke_miter_limit') &&
              src['stroke_miter_limit'] != null
          ? src['stroke_miter_limit']
          : null,
      strokeWidth:
          src.containsKey('stroke_width') && src['stroke_width'] != null
              ? src['stroke_width']
              : null,
      style: src.containsKey('style') && src['style'] != null
          ? PaintingStyle.values.asNameMap()[src['style']]
          : null,
    );
  }
}
