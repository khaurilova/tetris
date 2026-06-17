// base_url/5/tetris/lib/app/context_ext.dart
import 'package:flutter/material.dart';
import 'package:tetris/app/di/depends.dart';
import 'package:tetris/app/di/di_container.dart';

/// Удобный доступ к контейнеру зависимостей
/// из любого места приложения посредством BuildContext
extension ContextExt on BuildContext {
  DiContainer get die => DiContainer.of(this);
  Depends get di => DiContainer.of(this).depends;
}
