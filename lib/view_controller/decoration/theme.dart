import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:snipe_commander/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

// THEME -----------------------------------------------------------------------
enum AppTheme {
  Light,
  Dark,
}

extension AppThemeExtension on AppTheme {
  String get name {
    return this.toString().split('.').last.toLowerCase();
  }

  AppTheme get invert {
    return AppTheme.values[(this.index + 1) % AppTheme.values.length];
  }

  Color get backgroundColor {
    switch (this) {
      case AppTheme.Light:
        return Colors.white;
      /*case AttachmentType.Drawing:
        return Icons.gesture;*/
      case AppTheme.Dark:
        return Colors.grey[900]!;
    }
  }

  Color get neumorphicBackgroundColor {
    switch (this) {
      case AppTheme.Light:
        return Color(0xffd8d8d8);
      /*case AttachmentType.Drawing:
        return Icons.gesture;*/
      case AppTheme.Dark:
        return Color(0xFF3E3E3E);
    }
  }

  Color get modalArticleCardBackgroundColor {
    switch (this) {
      case AppTheme.Light:
        return Colors.white;
    /*case AttachmentType.Drawing:
        return Icons.gesture;*/
      case AppTheme.Dark:
        return Color(0xFF3E3E3E);
    }
  }

  Color get normalArticleCardBackgroundColor {
    switch (this) {
      case AppTheme.Light:
        return Colors.white;
    /*case AttachmentType.Drawing:
        return Icons.gesture;*/
      case AppTheme.Dark:
        return Colors.grey[900]!;
    }
  }

  Color get regularTextColor {
    switch (this) {
      case AppTheme.Light:
        return Colors.black;
      /*case AttachmentType.Drawing:
        return Icons.gesture;*/
      case AppTheme.Dark:
        return Colors.white;
    }
  }

  Color get drawerTextColor {
    switch (this) {
      case AppTheme.Light:
        return Color(0xFF3E3E3E);
      case AppTheme.Dark:
        return Color(0xffd8d8d8);
    }
  }

  Color get drawerIconColor {
    switch (this) {
      case AppTheme.Light:
        return Color(0xFF3E3E3E);
      case AppTheme.Dark:
        return Color(0xffd8d8d8);
    }
  }

  Color get highlightColor {
    switch (this) {
      case AppTheme.Light:
        return Colors.indigo;
      /*case AttachmentType.Drawing:
        return Icons.gesture;*/
      case AppTheme.Dark:
        return Colors.amber;
    }
  }

  Color get defaultNeumorphic {
    switch (this) {
      case AppTheme.Light:
        return NeumorphicColors.background;
      /*case AttachmentType.Drawing:
        return Icons.gesture;*/
      case AppTheme.Dark:
        return NeumorphicColors.darkBackground;
    }
  }
}
