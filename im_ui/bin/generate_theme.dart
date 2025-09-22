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
        // 品牌色系列 (添加100%透明度FF前缀)
        "brand1": derivedColors["normal"]!["colorHex"],      // 常规色
        "brand2": derivedColors["click"]!["colorHex"],       // 点击色
        "brand3": derivedColors["emphasis"]!["colorHex"],    // 强调色
        "brand4": derivedColors["disabled"]!["colorHex"],    // 禁用色
        "brand5": derivedColors["background_normal"]!["colorHex"], // 一般背景
        "brand6": derivedColors["background_light"]!["colorHex"],  // 浅色背景

        // 文字色系列 (添加100%透明度FF前缀)
        "text1": "#FF121212",   // 强调色
        "text2": "#FFA31212",   // 次要色
        "text3": "#FF701212",   // 辅助文字
        "text4": "#FF4D1212",   // 提示文字
        "text5": "#FF331212",   // 置灰文字
        "text6": "#FFFFFFFF",   // 纯白文字

        // 填充/边框色系列 (添加100%透明度FF前缀)
        "fill1": "#FF701212",   // 重/强调
        "fill2": "#FF4D1212",   // 重/强调
        "fill3": "#FF141212",   // 深/按钮描边
        "fill4": "#FF261212",   // 一般/边框
        "fill5": "#FF1A1212",   // 一般/分割线
        "fill6": "#FF0F1212",   // 浅/背景
        "fill7": "#FF081212",   // 浅/背景

        // 功能色系列 (添加100%透明度FF前缀)
        "normal1": "#FF0078FA",   // 常规
        "normal2": "#FF80BBFD",   // 特殊场景
        "normal3": "#FFE6F1FF",   // 浅色背景

        // 成功色系列 (添加100%透明度FF前缀)
        "success1": "#FF34C759",  // 常规
        "success2": "#FF99E3AC",  // 特殊场景
        "success3": "#FFEBF9EE",  // 浅色背景

        // 警告色系列 (添加100%透明度FF前缀)
        "warning1": "#FFFF9500",  // 常规
        "warning2": "#FFFFCA80",  // 特殊场景
        "warning3": "#FFFFF4E6",  // 浅色背景

        // 错误色系列 (添加100%透明度FF前缀)
        "error1": "#FFFF3B30",  // 常规
        "error2": "#FFFF9D97",  // 特殊场景
        "error3": "#FFFFEBEA",  // 浅色背景
      }
    }
  };

  // 返回格式化的JSON字符串
  return JsonEncoder.withIndent('  ').convert(themeData);
}

Map<String, Map<String, String>> _calculateDerivedColors(Map<String, int> primaryColor) {
  // 基于示例颜色 623ED8 的变化规律计算衍生色
  // brand1: 623ED8 (原始颜色)
  // brand2: 9982E6 (R*1.56, G*1.32, B*1.06)
  // brand3: 4A21CE (R*0.76, G*0.34, B*0.95)
  // brand4: C0B2EF (R*1.94, G*1.81, B*1.10)
  // brand5: E0D8F7 (R*2.26, G*2.19, B*1.14)
  // brand6: EFECFB (R*2.41, G*2.39, B*1.16)
  
  final r = primaryColor["red"]!;
  final g = primaryColor["green"]!;
  final b = primaryColor["blue"]!;
  
  return {
    "normal": {"colorHex": "#FF${r.toRadixString(16).padLeft(2, '0')}${g.toRadixString(16).padLeft(2, '0')}${b.toRadixString(16).padLeft(2, '0')}".toUpperCase()}, // 原始颜色
    "click": {"colorHex": "#FF${(r * 1.56).round().clamp(0, 255).toRadixString(16).padLeft(2, '0')}${(g * 1.32).round().clamp(0, 255).toRadixString(16).padLeft(2, '0')}${(b * 1.06).round().clamp(0, 255).toRadixString(16).padLeft(2, '0')}".toUpperCase()}, // 更亮
    "emphasis": {"colorHex": "#FF${(r * 0.76).round().clamp(0, 255).toRadixString(16).padLeft(2, '0')}${(g * 0.34).round().clamp(0, 255).toRadixString(16).padLeft(2, '0')}${(b * 0.95).round().clamp(0, 255).toRadixString(16).padLeft(2, '0')}".toUpperCase()}, // 更暗
    "disabled": {"colorHex": "#FF${(r * 1.94).round().clamp(0, 255).toRadixString(16).padLeft(2, '0')}${(g * 1.81).round().clamp(0, 255).toRadixString(16).padLeft(2, '0')}${(b * 1.10).round().clamp(0, 255).toRadixString(16).padLeft(2, '0')}".toUpperCase()}, // 更亮
    "background_normal": {"colorHex": "#FF${(r * 2.26).round().clamp(0, 255).toRadixString(16).padLeft(2, '0')}${(g * 2.19).round().clamp(0, 255).toRadixString(16).padLeft(2, '0')}${(b * 1.14).round().clamp(0, 255).toRadixString(16).padLeft(2, '0')}".toUpperCase()}, // 最亮
    "background_light": {"colorHex": "#FF${(r * 2.41).round().clamp(0, 255).toRadixString(16).padLeft(2, '0')}${(g * 2.39).round().clamp(0, 255).toRadixString(16).padLeft(2, '0')}${(b * 1.16).round().clamp(0, 255).toRadixString(16).padLeft(2, '0')}".toUpperCase()}, // 最亮
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

Future<void> _writeToFile(String content, String outputPath) async {
  final file = File(outputPath);
  await file.parent.create(recursive: true);
  await file.writeAsString(content);
}

bool _isValidHexColor(String hexColor) {
  final hexColorRegex = RegExp(r'^#?([A-Fa-f0-9]{6}|[A-Fa-f0-9]{8})$');
  return hexColorRegex.hasMatch(hexColor);
}