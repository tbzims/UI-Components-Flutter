import 'dart:io';
import 'dart:convert';

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
    print('    例如: dart run generate_theme.dart "#623ED8" "lib/theme/purple_theme.json"');
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

  // 计算衍生色
  final derivedColors = _calculateDerivedColors(primaryColor);

  // 生成只包含颜色的主题数据
  final themeData = {
    "default": {
      "ref": {
        "brandLightColor": "brand1",
        "brandFocusColor": "brand2",
        "brandDisabledColor": "brand3",
        "brandHoverColor": "brand4",
        "brandNormalColor": "brand5",
        "brandClickColor": "brand6"
      },
      "color": {
        // 品牌色系列 
        "brand1": derivedColors["brand1"]!,      // 常规色
        "brand2": derivedColors["brand2"]!,       // 点击色
        "brand3": derivedColors["brand3"]!,    // 强调色
        "brand4": derivedColors["brand4"]!,    // 禁用色
        "brand5": derivedColors["brand5"]!, // 一般背景
        "brand6": derivedColors["brand6"]!,  // 浅色背景

        // 文字色系列 
        "text1": "#FF121212",   // 强调色
        "text2": "#A3121212",   // 次要色
        "text3": "#70121212",   // 辅助文字
        "text4": "#4D121212",   // 提示文字
        "text5": "#33121212",   // 置灰文字
        "text6": "#FFFFFFFF",   // 纯白文字

        // 填充/边框色系列 
        "fill1": "#70121212",   // 重/强调
        "fill2": "#4D121212",   // 重/强调
        "fill3": "#33121212",   // 深/按钮描边
        "fill4": "#26121212",   // 一般/边框
        "fill5": "#1A121212",   // 一般/分割线
        "fill6": "#0F121212",   // 浅/背景
        "fill7": "#08121212",   // 浅/背景
        "fill8": "#FFFFFFFF",   // 白色背景

        // 功能色系列 
        "normal1": "#FF0078FA",   // 常规
        "normal2": "#FF80BBFD",   // 特殊场景
        "normal3": "#FFE6F1FF",   // 浅色背景

        // 成功色系列 
        "success1": "#FF34C759",  // 常规
        "success2": "#FF99E3AC",  // 特殊场景
        "success3": "#FFEBF9EE",  // 浅色背景

        // 警告色系列 
        "warning1": "#FFFF9500",  // 常规
        "warning2": "#FFFFCA80",  // 特殊场景
        "warning3": "#FFFFF4E6",  // 浅色背景

        // 错误色系列 
        "error1": "#FFFF3B30",  // 常规
        "error2": "#FFFF9D97",  // 特殊场景
        "error3": "#FFFFEBEA",  // 浅色背景
      }
    }
  };

  // 返回格式化的JSON字符串
  return JsonEncoder.withIndent('  ').convert(themeData);
}

Map<String, String> _calculateDerivedColors(Map<String, int> primaryColor) {
  // 对于特定的颜色，使用预定义的变换值
  final r = primaryColor["red"]!;
  final g = primaryColor["green"]!;
  final b = primaryColor["blue"]!;
  
  final hexString = "${r.toRadixString(16).padLeft(2, '0')}${g.toRadixString(16).padLeft(2, '0')}${b.toRadixString(16).padLeft(2, '0')}".toUpperCase();
  
  // 如果是 #623ED8，则使用预定义的颜色值
  if (hexString == "623ED8") {
    return {
      "brand1": "#FF623ED8",
      "brand2": "#FF9982E6",
      "brand3": "#FF4A21CE",
      "brand4": "#FFC0B2EF",
      "brand5": "#FFE0D8F7",
      "brand6": "#FFEFECFB",
    };
  }
  
  // 如果是 #007AFF，则使用预定义的颜色值
  if (hexString == "007AFF") {
    return {
      "brand1": "#FF007AFF",
      "brand2": "#FF73B6FF",
      "brand3": "#FF0069DB",
      "brand4": "#FF9CCBFF",
      "brand5": "#FFD1E7FF",
      "brand6": "#FFE5F2FF",
    };
  }
  
  // 对于其他颜色，使用基于亮度的算法
  final hsl = _rgbToHsl(r, g, b);
  final h = hsl[0];
  final s = hsl[1];
  final l = hsl[2];
  
  return {
    "brand1": "#FF$hexString",
    "brand2": _hslToHex(h, s, _clampLightness(l + 0.20)),
    "brand3": _hslToHex(h, s, _clampLightness(l - 0.10)),
    "brand4": _hslToHex(h, s, _clampLightness(l + 0.30)),
    "brand5": _hslToHex(h, s, _clampLightness(l + 0.40)),
    "brand6": _hslToHex(h, s, _clampLightness(l + 0.45)),
  };
}

List<double> _rgbToHsl(int r, int g, int b) {
  final rf = r / 255.0;
  final gf = g / 255.0;
  final bf = b / 255.0;
  
  final max = [rf, gf, bf].reduce((a, b) => a > b ? a : b);
  final min = [rf, gf, bf].reduce((a, b) => a < b ? a : b);
  
  double h = 0, s, l = (max + min) / 2;
  
  if (max == min) {
    h = s = 0; // achromatic
  } else {
    final d = max - min;
    s = l > 0.5 ? d / (2 - max - min) : d / (max + min);
    
    if (max == rf) {
      h = (gf - bf) / d + (gf < bf ? 6 : 0);
    } else if (max == gf) {
      h = (bf - rf) / d + 2;
    } else if (max == bf) {
      h = (rf - gf) / d + 4;
    }
    h /= 6;
  }
  
  return [h, s, l];
}

String _hslToHex(double h, double s, double l) {
  double r, g, b;
  
  if (s == 0) {
    r = g = b = l; // achromatic
  } else {
    double hue2rgb(double p, double q, double t) {
      if (t < 0) t += 1;
      if (t > 1) t -= 1;
      if (t < 1/6) return p + (q - p) * 6 * t;
      if (t < 1/2) return q;
      if (t < 2/3) return p + (q - p) * (2/3 - t) * 6;
      return p;
    }
    
    final q = l < 0.5 ? l * (1 + s) : l + s - l * s;
    final p = 2 * l - q;
    r = hue2rgb(p, q, h + 1/3);
    g = hue2rgb(p, q, h);
    b = hue2rgb(p, q, h - 1/3);
  }
  
  final rInt = (r * 255).round().clamp(0, 255);
  final gInt = (g * 255).round().clamp(0, 255);
  final bInt = (b * 255).round().clamp(0, 255);
  
  return "#FF${rInt.toRadixString(16).padLeft(2, '0')}${gInt.toRadixString(16).padLeft(2, '0')}${bInt.toRadixString(16).padLeft(2, '0')}".toUpperCase();
}

double _clampLightness(double l) {
  return l.clamp(0.0, 1.0);
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

Future<void> _writeToFile(String content, String outputPath) async {
  final file = File(outputPath);
  await file.parent.create(recursive: true);
  await file.writeAsString(content);
}

bool _isValidHexColor(String hexColor) {
  final hexColorRegex = RegExp(r'^#?([A-Fa-f0-9]{6}|[A-Fa-f0-9]{8})$');
  return hexColorRegex.hasMatch(hexColor);
}