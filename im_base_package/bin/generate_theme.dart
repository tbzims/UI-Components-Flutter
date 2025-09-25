import 'dart:io';
import 'dart:convert';
import 'dart:math' show min, max;

void main(List<String> arguments) async {
  if (arguments.isEmpty) {
    // 如果没有参数，交互式生成主题
    await generateInteractiveTheme();
  } else if (arguments.length == 2) {
    // 如果有两个参数，生成单个主题
    final primaryColor = arguments[0];
    final outputPath = arguments[1];

    if (!_isValidHexColor(primaryColor)) {
      print('❌ 无效的颜色格式: $primaryColor');
      print('请使用类似 "#0078FA" 的十六进制颜色格式');
      exit(1);
    }

    try {
      final jsonString = _generateThemeString(primaryColor);
      await _writeToFile(jsonString, outputPath);
      print('✅ 主题文件生成成功!');
      print('📁 输出路径: $outputPath');
      print('🎨 主色: $primaryColor');
    } catch (e) {
      print('❌ 生成主题文件失败: $e');
      exit(1);
    }
  } else {
    print('用法:');
    print('  dart run generate_theme.dart');
    print('    交互式生成主题文件');
    print('');
    print('  dart run generate_theme.dart <主色> <输出路径>');
    print('    生成单个主题文件');
    print(
        '    例如: dart run generate_theme.dart "#623ED8" "lib/theme/purple_theme.json"');
    exit(1);
  }
}

Future<void> generateInteractiveTheme() async {
  print('🎨 IM UI 主题生成工具');
  print('====================');

  // 获取主色调
  String? primaryColor;
  while (primaryColor == null || !_isValidHexColor(primaryColor)) {
    stdout.write('请输入主色调 (十六进制格式，例如: #0078FA): ');
    primaryColor = stdin.readLineSync();

    if (primaryColor == null) {
      print('❌ 输入不能为空');
      continue;
    }

    // 如果用户没有输入#，自动添加
    if (!primaryColor.startsWith('#')) {
      primaryColor = '#$primaryColor';
    }

    if (!_isValidHexColor(primaryColor)) {
      print('❌ 无效的颜色格式，请使用类似 "#0078FA" 的十六进制颜色格式');
    }
  }

  // 获取输出路径
  String? outputPath;
  while (outputPath == null || outputPath.isEmpty) {
    stdout.write('请输入存储路径和文件名 (例如: lib/theme/blue_theme.json): ');
    outputPath = stdin.readLineSync();

    if (outputPath == null || outputPath.isEmpty) {
      print('❌ 路径不能为空');
    }
  }

  try {
    final jsonString = _generateThemeString(primaryColor);
    await _writeToFile(jsonString, outputPath);
    print('\n✅ 主题文件生成成功!');
    print('📁 输出路径: $outputPath');
    print('🎨 主色: $primaryColor');
  } catch (e) {
    print('❌ 生成主题文件失败: $e');
    exit(1);
  }
}

String _generateThemeString(String primaryColorHex) {
  // 解析主色
  final primaryColor = _parseColor(primaryColorHex);
  if (primaryColor == null) {
    throw ArgumentError("无效的主色格式，请使用类似'$primaryColorHex'的格式");
  }

  // 转换为HSV
  final primaryHsv = _rgbToHsv(
      primaryColor["red"]!, primaryColor["green"]!, primaryColor["blue"]!);

  // 计算衍生色（基于HSV模型）
  final derivedColors = _calculateDerivedColorsWithHsv(primaryHsv);

  // 生成只包含颜色的主题数据
  final themeData = {
    "default": {
      "color": {
        // 品牌色系列 (添加100%透明度FF前缀)
        "brand1": derivedColors["normal"]!["colorHex"], // 常规色
        "brand2": derivedColors["click"]!["colorHex"], // 点击色
        "brand3": derivedColors["emphasis"]!["colorHex"], // 强调色
        "brand4": derivedColors["disabled"]!["colorHex"], // 禁用色
        "brand5": derivedColors["background_normal"]!["colorHex"], // 一般背景
        "brand6": derivedColors["background_light"]!["colorHex"], // 浅色背景

        // 文字色系列 (添加100%透明度FF前缀)
        "text1": "#FF121212", // 强调色
        "text2": "#FFA31212", // 次要色
        "text3": "#FF701212", // 辅助文字
        "text4": "#FF4D1212", // 提示文字
        "text5": "#FF331212", // 置灰文字
        "text6": "#FFFFFFFF", // 纯白文字

        // 填充/边框色系列 (添加100%透明度FF前缀)
        "fill1": "#FF701212", // 重/强调
        "fill2": "#FF4D1212", // 重/强调
        "fill3": "#FF141212", // 深/按钮描边
        "fill4": "#FF261212", // 一般/边框
        "fill5": "#FF1A1212", // 一般/分割线
        "fill6": "#FF0F1212", // 浅/背景
        "fill7": "#FF081212", // 浅/背景

        // 功能色系列 (添加100%透明度FF前缀)
        "normal1": "#FF0078FA", // 常规
        "normal2": "#FF80BBFD", // 特殊场景
        "normal3": "#FFE6F1FF", // 浅色背景

        // 成功色系列 (添加100%透明度FF前缀)
        "success1": "#FF34C759", // 常规
        "success2": "#FF99E3AC", // 特殊场景
        "success3": "#FFEBF9EE", // 浅色背景

        // 警告色系列 (添加100%透明度FF前缀)
        "warning1": "#FFFF9500", // 常规
        "warning2": "#FFFFCA80", // 特殊场景
        "warning3": "#FFFFF4E6", // 浅色背景

        // 错误色系列 (添加100%透明度FF前缀)
        "error1": "#FFFF3B30", // 常规
        "error2": "#FFFF9D97", // 特殊场景
        "error3": "#FFFFEBEA", // 浅色背景
      },
      'font': {
        'mobile': {
          "captionText": {"fontSize": 10, "lineHeight": 12, "fontWeight": 400},
          "auxiliaryTextSmall": {
            "fontSize": 12,
            "lineHeight": 16,
            "fontWeight": 400,
          },
          "auxiliaryText": {
            "fontSize": 14,
            "lineHeight": 20,
            "fontWeight": 400,
          },
          "bodyContent": {
            "fontSize": 16,
            "lineHeight": 22,
            "fontWeight": 400,
          },
          "bodyContentLarge": {
            "fontSize": 18,
            "lineHeight": 24,
            "fontWeight": 400,
          },
          "titleMin": {
            "fontSize": 14,
            "lineHeight": 20,
            "fontWeight": 500,
          },
          "titleSmall": {
            "fontSize": 16,
            "lineHeight": 22,
            "fontWeight": 500,
          },
          "titleMedium": {
            "fontSize": 18,
            "lineHeight": 24,
            "fontWeight": 500,
          },
          "titleLarge": {
            "fontSize": 20,
            "lineHeight": 28,
            "fontWeight": 500,
          },
          "headlineMin": {
            "fontSize": 24,
            "lineHeight": 36,
            "fontWeight": 600,
          },
          "headlineSmall": {
            "fontSize": 28,
            "lineHeight": 36,
            "fontWeight": 600,
          },
          "headlineMedium": {
            "fontSize": 32,
            "lineHeight": 44,
            "fontWeight": 600,
          },
          "headlineLarge": {
            "fontSize": 40,
            "lineHeight": 24,
            "fontWeight": 600,
          },
          "headlineSuperLarge": {
            "fontSize": 48,
            "lineHeight": 56,
            "fontWeight": 600,
          },
          "headlineSuperLargeX": {
            "fontSize": 56,
            "lineHeight": 64,
            "fontWeight": 600,
          }
        },
        'pc': {
          "captionText": {
            "fontSize": 10,
            "lineHeight": 12,
            "fontWeight": 400,
          },
          "auxiliaryText": {
            "fontSize": 12,
            "lineHeight": 20,
            "fontWeight": 400,
          },
          "bodyContent": {
            "fontSize": 14,
            "lineHeight": 22,
            "fontWeight": 400,
          },
          "bodyContentLarge": {
            "fontSize": 16,
            "lineHeight": 24,
            "fontWeight": 400,
          },
          "titleMin": {
            "fontSize": 12,
            "lineHeight": 20,
            "fontWeight": 500,
          },
          "titleSmall": {
            "fontSize": 14,
            "lineHeight": 22,
            "fontWeight": 500,
          },
          "titleMedium": {
            "fontSize": 16,
            "lineHeight": 24,
            "fontWeight": 500,
          },
          "titleLarge": {
            "fontSize": 20,
            "lineHeight": 28,
            "fontWeight": 500,
          },
          "headlineMin": {
            "fontSize": 24,
            "lineHeight": 36,
            "fontWeight": 600,
          },
          "headlineSmall": {
            "fontSize": 28,
            "lineHeight": 36,
            "fontWeight": 600,
          },
          "headlineMedium": {
            "fontSize": 32,
            "lineHeight": 44,
            "fontWeight": 600,
          },
          "headlineLarge": {
            "fontSize": 40,
            "lineHeight": 24,
            "fontWeight": 600,
          },
          "headlineSuperLarge": {
            "fontSize": 48,
            "lineHeight": 56,
            "fontWeight": 600,
          },
          "headlineSuperLargeX": {
            "fontSize": 56,
            "lineHeight": 64,
            "fontWeight": 600,
          }
        },
      }
    }
  };

  // 返回格式化的JSON字符串
  return JsonEncoder.withIndent('  ').convert(themeData);
}

Map<String, Map<String, String>> _calculateDerivedColorsWithHsv(
    Map<String, double> primaryHsv) {
  final h = primaryHsv["hue"]!;
  final s = primaryHsv["saturation"]!;
  final v = primaryHsv["value"]!;

  // 基于提供的示例数据进行计算
  // #007AFF 的 HSV 约为 (211, 100%, 100%)
  // #73B6FF: HSV  (211, 54.9%, 100%) - 点击色（降低饱和度）
  // #0069DB: HSV  (211, 100%, 85.9%) - 强调色（降低明度）
  // #9CCBFF: HSV  (211, 38.8%, 100%) - 禁用色（进一步降低饱和度）
  // #D1E7FF: HSV  (211, 18.0%, 100%) - 一般背景（大大降低饱和度）
  // #E5F2FF: HSV  (211, 10.2%, 100%) - 浅色背景（极低饱和度）

  return {
    "normal": {
      "colorHex": _hsvToHex(h, s, v) // 原始颜色
    },
    "click": {
      "colorHex": _hsvToHex(h, s * 0.55, v) // 降低饱和度到约55%
    },
    "emphasis": {
      "colorHex": _hsvToHex(h, s, v * 0.86) // 降低明度到约86%
    },
    "disabled": {
      "colorHex": _hsvToHex(h, s * 0.39, v) // 降低饱和度到约39%
    },
    "background_normal": {
      "colorHex": _hsvToHex(h, s * 0.18, v) // 大大降低饱和度到约18%
    },
    "background_light": {
      "colorHex": _hsvToHex(h, s * 0.10, v) // 极低饱和度到约10%
    },
  };
}

Map<String, int>? _parseColor(String hex) {
  try {
    // 处理不带#的情况
    String normalizedHex = hex.startsWith('#') ? hex.substring(1) : hex;

    // 确保格式正确
    if (normalizedHex.length == 6) {
      // RGB格式
      return {
        "red": int.parse(normalizedHex.substring(0, 2), radix: 16),
        "green": int.parse(normalizedHex.substring(2, 4), radix: 16),
        "blue": int.parse(normalizedHex.substring(4, 6), radix: 16),
      };
    } else if (normalizedHex.length == 8) {
      // ARGB格式
      return {
        "red": int.parse(normalizedHex.substring(2, 4), radix: 16),
        "green": int.parse(normalizedHex.substring(4, 6), radix: 16),
        "blue": int.parse(normalizedHex.substring(6, 8), radix: 16),
      };
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

Map<String, double> _rgbToHsv(int r, int g, int b) {
  final rf = r / 255.0;
  final gf = g / 255.0;
  final bf = b / 255.0;

  final maxVal = max(rf, max(gf, bf));
  final minVal = min(rf, min(gf, bf));
  final delta = maxVal - minVal;

  double h = 0.0;
  double s = 0.0;
  final v = maxVal;

  if (maxVal != 0) {
    s = delta / maxVal;
  }

  if (delta != 0) {
    if (maxVal == rf) {
      h = (gf - bf) / delta + (gf < bf ? 6 : 0);
    } else if (maxVal == gf) {
      h = (bf - rf) / delta + 2;
    } else {
      h = (rf - gf) / delta + 4;
    }
    h /= 6;
  }

  return {
    "hue": h,
    "saturation": s,
    "value": v,
  };
}

String _hsvToHex(double h, double s, double v) {
  int r, g, b;

  if (s == 0) {
    r = g = b = (v * 255).round();
  } else {
    final i = (h * 6).floor();
    final f = h * 6 - i;
    final p = v * (1 - s);
    final q = v * (1 - f * s);
    final t = v * (1 - (1 - f) * s);

    switch (i % 6) {
      case 0:
        r = (v * 255).round();
        g = (t * 255).round();
        b = (p * 255).round();
        break;
      case 1:
        r = (q * 255).round();
        g = (v * 255).round();
        b = (p * 255).round();
        break;
      case 2:
        r = (p * 255).round();
        g = (v * 255).round();
        b = (t * 255).round();
        break;
      case 3:
        r = (p * 255).round();
        g = (q * 255).round();
        b = (v * 255).round();
        break;
      case 4:
        r = (t * 255).round();
        g = (p * 255).round();
        b = (v * 255).round();
        break;
      case 5:
        r = (v * 255).round();
        g = (p * 255).round();
        b = (q * 255).round();
        break;
      default:
        r = g = b = 0;
    }
  }

  return "#FF${r.toRadixString(16).padLeft(2, '0')}${g.toRadixString(16).padLeft(2, '0')}${b.toRadixString(16).padLeft(2, '0')}"
      .toUpperCase();
}

Future<void> _writeToFile(String content, String outputPath) async {
  final file = File(outputPath);
  await file.parent.create(recursive: true);
  await file.writeAsString(content);
}

bool _isValidHexColor(String hexColor) {
  final hexColorRegex = RegExp(r'^#?([A-Fa-f0-9]{6}|[A-Fa-f0-9]{8})$');
  return hexColorRegex.hasMatch(hexColor);
}
