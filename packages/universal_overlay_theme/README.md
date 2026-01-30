# Universal Overlay Theme

Theme data and InheritedTheme widget for the `universal_overlay` package. Provides customizable theming for toasts, loading indicators, and custom overlays.

## Features

- **UniversalOverlayTheme** - InheritedTheme widget for providing theme data to descendants
- **UniversalOverlayThemeData** - Combined theme data class holding all overlay themes
- **ToastThemeData** - Comprehensive theming for toast notifications
- **LoadingThemeData** - Theming for loading indicators
- **CustomOverlayThemeData** - Theming for custom overlays

## Getting Started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  universal_overlay_theme: ^1.0.0
```

## Usage

Wrap your app with `UniversalOverlayTheme` to provide default theming:

```dart
import 'package:flutter/material.dart';
import 'package:universal_overlay_theme/universal_overlay_theme.dart';

void main() {
  runApp(
    UniversalOverlayTheme(
      data: UniversalOverlayThemeData(
        toastTheme: ToastThemeData(
          position: OverlayPosition.bottom,
          displayMode: ToastDisplayMode.replace,
          backgroundColor: Colors.grey[800],
          borderRadius: BorderRadius.circular(8),
        ),
        loadingTheme: LoadingThemeData(
          barrierColor: Colors.black54,
          indicatorColor: Colors.blue,
        ),
      ),
      child: MaterialApp(
        builder: (context, child) {
          return UniversalOverlay(
            child: child!,
          );
        },
        home: HomePage(),
      ),
    ),
  );
}
```

### Accessing Theme Data

```dart
// Get theme data anywhere in the widget tree
final theme = UniversalOverlayTheme.of(context);
final toastTheme = theme.toastTheme;
final loadingTheme = theme.loadingTheme;

// Or check if theme exists
final maybeTheme = UniversalOverlayTheme.maybeOf(context);
```

## Additional Information

This package is part of the `universal_overlay` monorepo. For more information, see the [main repository](https://github.com/FadyFayezYounan/universal_overlay).

