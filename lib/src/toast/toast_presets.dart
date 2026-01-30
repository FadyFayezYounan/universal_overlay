import 'package:flutter/material.dart';

import 'toast_theme_data.dart';

/// Preset toast themes.
@immutable
abstract class ToastPresets {
  const ToastPresets._();

  // Material 3 Success Preset
  static ToastThemeData material3Success() => const ToastThemeData(
        backgroundColor: Color(0xFF2E7D32),
        darkBackgroundColor: Color(0xFF1B5E20),
        textStyle: TextStyle(color: Colors.white, fontSize: 14),
        borderRadius: BorderRadius.all(Radius.circular(8)),
        elevation: 4,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: EdgeInsets.all(16),
        leadingIconColor: Colors.white,
      );

  // Material 3 Error Preset
  static ToastThemeData material3Error() => const ToastThemeData(
        backgroundColor: Color(0xFFC62828),
        darkBackgroundColor: Color(0xFFB71C1C),
        textStyle: TextStyle(color: Colors.white, fontSize: 14),
        borderRadius: BorderRadius.all(Radius.circular(8)),
        elevation: 4,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: EdgeInsets.all(16),
        leadingIconColor: Colors.white,
      );

  // Material 3 Warning Preset
  static ToastThemeData material3Warning() => const ToastThemeData(
        backgroundColor: Color(0xFFF57C00),
        darkBackgroundColor: Color(0xFFE65100),
        textStyle: TextStyle(color: Colors.white, fontSize: 14),
        borderRadius: BorderRadius.all(Radius.circular(8)),
        elevation: 4,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: EdgeInsets.all(16),
        leadingIconColor: Colors.white,
      );

  // Material 3 Info Preset
  static ToastThemeData material3Info() => const ToastThemeData(
        backgroundColor: Color(0xFF1976D2),
        darkBackgroundColor: Color(0xFF0D47A1),
        textStyle: TextStyle(color: Colors.white, fontSize: 14),
        borderRadius: BorderRadius.all(Radius.circular(8)),
        elevation: 4,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: EdgeInsets.all(16),
        leadingIconColor: Colors.white,
      );

  // Minimal Style Preset
  static ToastThemeData minimal() => const ToastThemeData(
        backgroundColor: Color(0xDD000000),
        darkBackgroundColor: Color(0xDDFFFFFF),
        textStyle: TextStyle(color: Colors.white, fontSize: 14),
        darkTextStyle: TextStyle(color: Colors.black, fontSize: 14),
        borderRadius: BorderRadius.all(Radius.circular(4)),
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        margin: EdgeInsets.all(16),
      );

  // Elevated Style Preset
  static ToastThemeData elevated() => const ToastThemeData(
        backgroundColor: Colors.white,
        darkBackgroundColor: Color(0xFF424242),
        textStyle: TextStyle(color: Colors.black87, fontSize: 14),
        darkTextStyle: TextStyle(color: Colors.white, fontSize: 14),
        borderRadius: BorderRadius.all(Radius.circular(12)),
        elevation: 8,
        shadowColor: Colors.black26,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        margin: EdgeInsets.all(16),
      );

  // Rounded Style Preset
  static ToastThemeData rounded() => const ToastThemeData(
        backgroundColor: Color(0xFF323232),
        darkBackgroundColor: Color(0xFFE0E0E0),
        textStyle: TextStyle(color: Colors.white, fontSize: 14),
        darkTextStyle: TextStyle(color: Colors.black87, fontSize: 14),
        borderRadius: BorderRadius.all(Radius.circular(24)),
        elevation: 6,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        margin: EdgeInsets.all(16),
      );

  // iOS Style Preset
  static ToastThemeData ios() => const ToastThemeData(
        backgroundColor: Color(0xF0FFFFFF),
        darkBackgroundColor: Color(0xF01C1C1E),
        textStyle: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        darkTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        borderRadius: BorderRadius.all(Radius.circular(14)),
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: EdgeInsets.all(16),
        border: Border.fromBorderSide(
          BorderSide(color: Color(0x1A000000), width: 0.5),
        ),
        darkBorder: Border.fromBorderSide(
          BorderSide(color: Color(0x1AFFFFFF), width: 0.5),
        ),
      );
}
