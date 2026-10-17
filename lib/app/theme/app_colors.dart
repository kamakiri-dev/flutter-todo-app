import 'package:flutter/material.dart';

class AppColors {
  static const primary = Colors.orangeAccent;
  static const onPrimary = Colors.black;
  static const secondary = Colors.blueAccent;
  static const onSecondary = Colors.grey;
  static const error = Colors.redAccent;
  static const onError = Colors.white;
  static const surface = Colors.white;
  static const onSurface = Colors.black;
  static const card = Color.fromRGBO(255, 224, 178, 1);
  // primary を薄くした色（空表示のアイコン背景）
  static const primaryLight = Color.fromRGBO(255, 171, 64, 0.2);

  // 画面背景（カードが映えるよう少しだけ暖色寄りの白）
  static const background = Color.fromRGBO(255, 248, 238, 1);
  // 完了済みカードの背景
  static const cardCompleted = Color.fromRGBO(245, 240, 232, 1);
  // 入力欄などの枠線
  static const outline = Color.fromRGBO(230, 213, 190, 1);
  // 影
  static const shadow = Color.fromRGBO(0, 0, 0, 0.06);
}
