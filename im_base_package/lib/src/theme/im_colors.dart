import 'dart:ui';

import 'package:flutter/material.dart';
import 'im_theme.dart';

extension IMColors on IMThemeData {
  /// 品牌色组----------------------------------------------------

  ///#FF007AFF
  Color get brand1 => colorMap['brand1'] ?? const Color(0xFF007AFF);

  ///#FF73B6FF
  Color get brand2 => colorMap['brand2'] ?? const Color(0xFF73B6FF);

  ///#FF0069DB
  Color get brand3 => colorMap['brand3'] ?? const Color(0xFF0069DB);

  ///#FF9CCBFF
  Color get brand4 => colorMap['brand4'] ?? const Color(0xFF9CCBFF);

  ///#FFD1E7FF
  Color get brand5 => colorMap['brand5'] ?? const Color(0xFFD1E7FF);

  ///#FFE5F2FF
  Color get brand6 => colorMap['brand6'] ?? const Color(0xFFE5F2FF);

  /// 文字色组----------------------------------------------------

  ///#FF121212
  Color get fontGyColor1 => colorMap['text1'] ?? const Color(0xFF121212);

  ///#A3121212
  Color get fontGyColor2 => colorMap['text2'] ?? const Color(0xA3121212);

  ///#70121212
  Color get fontGyColor3 => colorMap['text3'] ?? const Color(0x70121212);

  ///#4D121212
  Color get fontGyColor4 => colorMap['text4'] ?? const Color(0x4D121212);

  ///#33121212
  Color get fontGyColor5 => colorMap['text5'] ?? const Color(0x33121212);

  ///#FFFFFFFF
  Color get fontGyColor6 => colorMap['text6'] ?? const Color(0xFFFFFFFF);

  /// 填充/边框色组----------------------------------------------------

  ///#70121212
  Color get fill1 => colorMap['fill1'] ?? const Color(0x70121212);

  ///#4D121212
  Color get fill2 => colorMap['fill2'] ?? const Color(0x4D121212);

  ///#33121212
  Color get fill3 => colorMap['fill3'] ?? const Color(0x33121212);

  ///#26121212
  Color get fill4 => colorMap['fill4'] ?? const Color(0x26121212);

  ///#1A121212
  Color get fill5 => colorMap['fill5'] ?? const Color(0x1A121212);

  ///#0F121212
  Color get fill6 => colorMap['fill6'] ?? const Color(0x0F121212);

  ///#08121212
  Color get fill7 => colorMap['fill7'] ?? const Color(0x08121212);

  ///#FFFFFFFF
  Color get fill8 => colorMap['fill8'] ?? const Color(0xFFFFFFFF);

  /// 功能色组----------------------------------------------------

  ///#FF0078FA
  Color get normal1 => colorMap['normal1'] ?? const Color(0xFF0078FA);

  ///#FF80BBFD
  Color get normal2 => colorMap['normal2'] ?? const Color(0xFF80BBFD);

  ///#FFE6F1FF
  Color get normal3 => colorMap['normal3'] ?? const Color(0xFFE6F1FF);

  /// 成功色组----------------------------------------------------

  ///#FF34C759
  Color get successColor1 => colorMap['success1'] ?? const Color(0xFF34C759);

  ///#FF99E3AC
  Color get successColor2 => colorMap['success2'] ?? const Color(0xFF99E3AC);

  ///#FFEBF9EE
  Color get successColor3 => colorMap['success3'] ?? const Color(0xFFEBF9EE);

  /// 警告色组----------------------------------------------------

  ///#FFFF9500
  Color get warningColor1 => colorMap['warning1'] ?? const Color(0xFFFF9500);

  ///#FFFFCA80
  Color get warningColor2 => colorMap['warning2'] ?? const Color(0xFFFFCA80);

  ///#FFFFF4E6
  Color get warningColor3 => colorMap['warning3'] ?? const Color(0xFFFFF4E6);

  /// 错误色组----------------------------------------------------

  ///#FFFF3B30
  Color get errorColor1 => colorMap['error1'] ?? const Color(0xFFFF3B30);

  ///#FFFF9D97
  Color get errorColor2 => colorMap['error2'] ?? const Color(0xFFFF9D97);

  ///#FFFFEBEA
  Color get errorColor3 => colorMap['error3'] ?? const Color(0xFFFFEBEA);
}
