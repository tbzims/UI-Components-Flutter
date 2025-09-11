import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'basic.dart';
import 'resource_delegate.dart';
import 'snto_default_theme.dart';

class SntoTheme extends StatelessWidget {
  const SntoTheme({
    super.key,
    required this.data,
    required this.child,
    this.systemData,
  });

  /// 仅使用Default主题，不需要切换主题功能
  static bool _needMultiTheme = false;

  /// 主题数据
  static SntoThemeData? _singleData;

  /// 子控件
  final Widget child;

  /// 主题数据
  final SntoThemeData data;

  /// Flutter系统主题数据
  final ThemeData? systemData;

  /// 开启多套主题功能
  static void needMultiTheme([bool value = true]) {
    _needMultiTheme = value;
  }

  /// 设置资源代理,
  /// needAlwaysBuild=true:每次都会走build方法;如果全局有多个Delegate,需要区分情况去获取,则可以设置needAlwaysBuild为true,业务自己判断返回哪个delegate
  /// needAlwaysBuild=false:返回delegate为null,则每次都会走build方法,返回了
  static void setResourceBuilder(
    TDTDResourceBuilder delegate, {
    bool needAlwaysBuild = false,
  }) {
    TDResourceManager.instance.setResourceBuilder(delegate, needAlwaysBuild);
  }

  /// 获取默认主题数据，全局唯一
  static SntoThemeData defaultData() {
    return SntoThemeData.defaultData();
  }

  /// 获取主题数据，如果未传context则获取全局唯一的默认数据,
  /// 传了context，则获取最近的主题，取不到则会获取全局唯一默认数据
  static SntoThemeData of([BuildContext? context]) {
    if (!_needMultiTheme || context == null) {
      // 如果context为null,则返回全局默认主题
      return _singleData ?? SntoThemeData.defaultData();
    }
    // 如果传了context，则从其中获取最近主题
    try {
      var data = Theme.of(context).extensions[SntoThemeData] as SntoThemeData?;
      return data ?? SntoThemeData.defaultData();
    } catch (e) {
      return SntoThemeData.defaultData();
    }
  }

  /// 获取主题数据，取不到则可空
  /// 传了context，则获取最近的主题，取不到或未传context则返回null,
  static SntoThemeData? ofNullable([BuildContext? context]) {
    if (context != null) {
      // 如果传了context，则从其中获取最近主题
      return Theme.of(context).extensions[SntoThemeData] as SntoThemeData?;
    } else {
      // 如果context为null,则返回null
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_needMultiTheme) {
      _singleData = data;
    }
    var extensions = [data];
    return Theme(
      data:
          systemData?.copyWith(extensions: extensions) ??
          ThemeData(extensions: extensions),
      child: child,
    );
  }
}

/// 主题数据
class SntoThemeData extends ThemeExtension<SntoThemeData> {
  static const String _defaultThemeName = 'default';
  static SntoThemeData? _defaultThemeData;

  /// 名称
  late String name;

  /// 颜色
  late SntoMap<String, Color> colorMap;

  /// 字体尺寸
  late SntoMap<String, Font> fontMap;

  /// 圆角
  late SntoMap<String, double> radiusMap;

  /// 字体样式
  late SntoMap<String, FontFamily> fontFamilyMap;

  /// 阴影
  late SntoMap<String, List<BoxShadow>> shadowMap;

  /// 间隔
  late SntoMap<String, double> spacerMap;

  /// 映射关系
  late SntoMap<String, String> refMap;

  /// 额外定义的结构
  late SntoExtraThemeData? extraThemeData;

  SntoThemeData({
    required this.name,
    required this.colorMap,
    required this.fontMap,
    required this.radiusMap,
    required this.fontFamilyMap,
    required this.shadowMap,
    required this.spacerMap,
    required this.refMap,
    this.extraThemeData,
  });

  /// 获取默认Data，一个App里只有一个，用于没有context的地方
  static SntoThemeData defaultData({SntoExtraThemeData? extraThemeData}) {
    _defaultThemeData ??=
        fromJson(
          _defaultThemeName,
          SntoDefaultTheme.defaultThemeConfig,
          extraThemeData: extraThemeData,
        ) ??
        _emptyData(_defaultThemeName, extraThemeData: extraThemeData);

    return _defaultThemeData!;
  }

  /// 从父类拷贝
  SntoThemeData copyWithTDThemeData(
    String name, {
    Map<String, Color>? colorMap,
    Map<String, Font>? fontMap,
    Map<String, double>? radiusMap,
    Map<String, FontFamily>? fontFamilyMap,
    Map<String, List<BoxShadow>>? shadowMap,
    Map<String, double>? marginMap,
    SntoExtraThemeData? extraThemeData,
  }) {
    return copyWith(
          name: name,
          colorMap: colorMap,
          fontMap: fontMap,
          radiusMap: radiusMap,
          fontFamilyMap: fontFamilyMap,
          shadowMap: shadowMap,
          marginMap: marginMap,
          extraThemeData: extraThemeData,
        )
        as SntoThemeData;
  }

  @override
  ThemeExtension<SntoThemeData> copyWith({
    String? name,
    Map<String, Color>? colorMap,
    Map<String, Font>? fontMap,
    Map<String, double>? radiusMap,
    Map<String, FontFamily>? fontFamilyMap,
    Map<String, List<BoxShadow>>? shadowMap,
    Map<String, double>? marginMap,
    SntoExtraThemeData? extraThemeData,
  }) {
    var result = SntoThemeData(
      name: name ?? 'default',
      colorMap: _copyMap<Color>(this.colorMap, colorMap),
      fontMap: _copyMap<Font>(this.fontMap, fontMap),
      radiusMap: _copyMap<double>(this.radiusMap, radiusMap),
      fontFamilyMap: _copyMap<FontFamily>(this.fontFamilyMap, fontFamilyMap),
      shadowMap: _copyMap<List<BoxShadow>>(this.shadowMap, shadowMap),
      spacerMap: _copyMap<double>(spacerMap, marginMap),
      refMap: _copyMap<String>(refMap, refMap),
      extraThemeData: extraThemeData ?? this.extraThemeData,
    );
    return result;
  }

  /// 拷贝Map,防止内层
  SntoMap<String, T> _copyMap<T>(SntoMap<String, T> src, Map<String, T>? add) {
    var map = SntoMap<String, T>(factory: () => src);

    src.forEach((key, value) {
      map[key] = value;
    });
    if (add != null) {
      map.addAll(add);
    }
    return map;
  }

  /// 创建空对象
  static SntoThemeData _emptyData(
    String name, {
    SntoExtraThemeData? extraThemeData,
  }) {
    var refMap = SntoMap<String, String>();
    return SntoThemeData(
      name: name,
      colorMap: SntoMap(factory: () => defaultData().colorMap, refs: refMap),
      fontMap: SntoMap(factory: () => defaultData().fontMap, refs: refMap),
      radiusMap: SntoMap(factory: () => defaultData().radiusMap, refs: refMap),
      fontFamilyMap: SntoMap(
        factory: () => defaultData().fontFamilyMap,
        refs: refMap,
      ),
      shadowMap: SntoMap(factory: () => defaultData().shadowMap, refs: refMap),
      spacerMap: SntoMap(factory: () => defaultData().spacerMap, refs: refMap),
      refMap: refMap,
    );
  }

  /// 解析配置的json文件为主题数据
  static SntoThemeData? fromJson(
    String name,
    String themeJson, {
    var recoverDefault = false,
    SntoExtraThemeData? extraThemeData,
  }) {
    if (themeJson.isEmpty) {
      return null;
    }
    try {
      /// 要求json配置必须正确
      final themeConfig = json.decode(themeJson);
      if (themeConfig.containsKey(name)) {
        var theme = _emptyData(name);
        Map<String, dynamic> curThemeMap = themeConfig['$name'];

        /// 设置颜色
        Map<String, dynamic>? colorsMap = curThemeMap['color'];
        colorsMap?.forEach((key, value) {
          var color = toColor(value);
          if (color != null) {
            theme.colorMap[key] = color;
          }
        });

        /// 设置颜色
        Map<String, dynamic>? refMap = curThemeMap['ref'];
        refMap?.forEach((key, value) {
          theme.refMap[key] = value;
        });

        /// 设置字体尺寸
        Map<String, dynamic>? fontsMap = curThemeMap['font'];
        fontsMap?.forEach((key, value) {
          theme.fontMap[key] = Font.fromJson(value);
        });

        /// 设置圆角
        Map<String, dynamic>? cornersMap = curThemeMap['radius'];
        cornersMap?.forEach((key, value) {
          theme.radiusMap[key] = value.toDouble();
        });

        /// 设置字体
        Map<String, dynamic>? fontFamilyMap = curThemeMap['fontFamily'];
        fontFamilyMap?.forEach((key, value) {
          theme.fontFamilyMap[key] = FontFamily.fromJson(value);
        });

        /// 设置阴影
        Map<String, dynamic>? shadowMap = curThemeMap['shadow'];
        shadowMap?.forEach((key, value) {
          var list = <BoxShadow>[];
          for (var element in (value as List)) {
            list.add(
              BoxShadow(
                color: toColor(element['color']) ?? Colors.black,
                blurRadius: element['blurRadius'].toDouble(),
                spreadRadius: element['spreadRadius'].toDouble(),
                offset: Offset(
                  element['offset']?['x'].toDouble() ?? 0,
                  element['offset']?['y'].toDouble() ?? 0,
                ),
              ),
            );
          }

          theme.shadowMap[key] = list;
        });

        /// 设置Margin
        Map<String, dynamic>? marginsMap = curThemeMap['margin'];
        marginsMap?.forEach((key, value) {
          theme.spacerMap[key] = value.toDouble();
        });

        if (extraThemeData != null) {
          extraThemeData.parse(name, curThemeMap);
          theme.extraThemeData = extraThemeData;
        }
        if (recoverDefault) {
          _defaultThemeData = theme;
        }
        return theme;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Color? ofColor(String? key) {
    return colorMap[key];
  }

  Font? ofFont(String? key) {
    return fontMap[key];
  }

  double? ofCorner(String? key) {
    return radiusMap[key];
  }

  FontFamily? ofFontFamily(String? key) {
    return fontFamilyMap[key];
  }

  List<BoxShadow>? ofShadow(String? key) {
    return shadowMap[key];
  }

  T? ofExtra<T extends SntoExtraThemeData>() {
    try {
      return extraThemeData as T;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  @override
  ThemeExtension<SntoThemeData> lerp(
    ThemeExtension<SntoThemeData>? other,
    double t,
  ) {
    if (other is! SntoThemeData) {
      return this;
    }
    return SntoThemeData(
      name: other.name,
      colorMap: other.colorMap,
      fontMap: other.fontMap,
      radiusMap: other.radiusMap,
      fontFamilyMap: other.fontFamilyMap,
      shadowMap: other.shadowMap,
      spacerMap: other.spacerMap,
      refMap: other.refMap,
    );
  }
}

/// 扩展主题数据
abstract class SntoExtraThemeData {
  /// 解析json
  void parse(String name, Map<String, dynamic> curThemeMap);
}

typedef DefaultMapFactory = SntoMap? Function();

/// 自定义Map
class SntoMap<K, V> extends DelegatingMap<K, V> {
  SntoMap({this.factory, this.refs}) : super({});
  DefaultMapFactory? factory;
  SntoMap? refs;

  @override
  V? operator [](Object? key) {
    // return super[key];
    key = refs?[key] ?? key;
    var value = super[key];
    if (value != null) {
      return value;
    }
    var defaultValue = factory?.call()?.get(key);
    if (defaultValue is V) {
      return defaultValue;
    }
    return null;
  }

  V? get(Object? key) {
    return super[key];
  }
}

Color? toColor(String colorStr, {double alpha = 1}) {
  try {
    var hexColor = colorStr.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      if (alpha < 0) {
        alpha = 0;
      } else if (alpha > 1) {
        alpha = 1;
      }
      var alphaInt = (0xFF * alpha).toInt();
      var alphaString = alphaInt.toRadixString(16);

      hexColor = '$alphaString$hexColor';
    }
    return Color(int.parse(hexColor, radix: 16));
  } catch (e) {
    // Log.w('toColor', 'error: $e');
  }
  return null;
}
