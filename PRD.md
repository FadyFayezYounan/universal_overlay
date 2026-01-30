# Product Requirements Document (PRD)
# Universal Overlay - Flutter Package

**Version:** 1.0.0  
**Author:** Fady  
**Date:** January 30, 2026  
**Status:** Draft

---

## Table of Contents

1. [Executive Summary](#1-executive-summary)
2. [Problem Statement](#2-problem-statement)
3. [Goals and Objectives](#3-goals-and-objectives)
4. [Target Audience](#4-target-audience)
5. [Package Overview](#5-package-overview)
6. [Architecture Design](#6-architecture-design)
7. [Core Components](#7-core-components)
8. [API Specification](#8-api-specification)
9. [Theming System](#9-theming-system)
10. [Animation System](#10-animation-system)
11. [Dismissal System](#11-dismissal-system)
12. [Display Modes](#12-display-modes)
13. [State Management](#13-state-management)
14. [Testing Utilities](#14-testing-utilities)
15. [Dependencies](#15-dependencies)
16. [File Structure](#16-file-structure)
17. [Usage Examples](#17-usage-examples)
18. [Future Enhancements](#18-future-enhancements)
19. [Success Metrics](#19-success-metrics)
20. [Appendix](#20-appendix)

---

## 1. Executive Summary

**Universal Overlay** is a comprehensive Flutter package that provides a unified, customizable overlay system for displaying toast notifications, loading indicators, and custom overlays. The package follows Flutter's InheritedWidget pattern, similar to `ScaffoldMessenger`, providing a familiar and intuitive API for Flutter developers.

The package prioritizes:
- **Familiar API**: Uses `UniversalOverlay.of(context)` pattern
- **Full Customization**: Every aspect is themeable and configurable
- **Type Safety**: Leverages Dart's type system for compile-time safety
- **Performance**: Efficient overlay management with minimal rebuilds
- **Testability**: Built-in testing utilities for widget tests

---

## 2. Problem Statement

### Current Challenges

1. **Fragmented Solutions**: Developers often use multiple packages for toasts, loading indicators, and custom overlays, leading to inconsistent APIs and behaviors.

2. **Limited Customization**: Many existing packages offer limited theming options, forcing developers to fork or wrap packages for custom designs.

3. **Context Dependency Issues**: Some packages require global setup or lack proper context-based access, making them incompatible with certain architectural patterns.

4. **Animation Limitations**: Built-in animations are often inflexible, and custom animations require significant boilerplate.

5. **Display Mode Constraints**: Few packages support multiple display modes (queue, stack, replace) for managing concurrent overlays.

6. **Testing Difficulties**: Overlay packages often lack testing utilities, making widget tests cumbersome.

### Solution

Universal Overlay addresses these challenges by providing a single, cohesive package with:
- Unified API following Flutter conventions
- Comprehensive theming with dark/light mode support
- Flexible animation system with presets and custom builders
- Multiple display modes for different use cases
- Built-in testing utilities

---

## 3. Goals and Objectives

### Primary Goals

| Goal | Description | Success Criteria |
|------|-------------|------------------|
| **Unified API** | Single package for all overlay needs | One import, consistent patterns |
| **Flutter-Native Feel** | API mirrors Flutter conventions | `UniversalOverlay.of(context)` pattern |
| **Full Customization** | Every visual aspect customizable | Theme system covers all properties |
| **Type Safety** | Compile-time error prevention | No runtime type errors |
| **Performance** | Minimal performance overhead | No measurable frame drops |

### Secondary Goals

| Goal | Description | Success Criteria |
|------|-------------|------------------|
| **Documentation** | Comprehensive docs and examples | 100% public API documented |
| **Testing** | High test coverage | >90% code coverage |
| **Accessibility** | Screen reader support | Future enhancement |
| **Platform Adaptive** | Platform-specific defaults | iOS/Android/Web variants |

---

## 4. Target Audience

### Primary Users

1. **Flutter Developers**: Building apps requiring toast notifications, loading states, and custom overlays.

2. **Design System Teams**: Creating consistent overlay behaviors across large applications.

3. **Package Maintainers**: Building higher-level packages that need overlay functionality.

### User Personas

**Persona 1: Mobile App Developer**
- Needs quick, reliable toast notifications
- Wants loading indicators that block interaction
- Values simple API with sensible defaults

**Persona 2: Design System Architect**
- Requires full control over styling
- Needs dark/light mode support
- Values consistent theming across the app

**Persona 3: Custom UI Developer**
- Needs custom overlay widgets
- Requires fine-grained animation control
- Values flexibility over convention

---

## 5. Package Overview

### Package Name
```
universal_overlay
```

### Supported Overlay Types

| Type | Description | Use Case |
|------|-------------|----------|
| **Toast** | Brief notification messages | Success/error feedback, info messages |
| **Loading** | Progress/loading indicators | Async operations, data fetching |
| **Custom** | Arbitrary widget overlays | Dialogs, tooltips, custom UI |

### Core Principles

1. **Convention over Configuration**: Sensible defaults with full override capability
2. **Composition over Inheritance**: Modular components that compose well
3. **Explicit over Implicit**: Clear API contracts, no hidden behavior
4. **Testable by Design**: All features accessible in test environments

---

## 6. Architecture Design

### High-Level Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                      MaterialApp                             │
│  ┌───────────────────────────────────────────────────────┐  │
│  │                 UniversalOverlayScope                  │  │
│  │  ┌─────────────────────────────────────────────────┐  │  │
│  │  │           _UniversalOverlayState                │  │  │
│  │  │  ┌───────────────────────────────────────────┐  │  │  │
│  │  │  │         OverlayManager                    │  │  │  │
│  │  │  │  ┌─────────┐ ┌─────────┐ ┌────────────┐  │  │  │  │
│  │  │  │  │ Toast   │ │ Loading │ │  Custom    │  │  │  │  │
│  │  │  │  │ Queue   │ │ Manager │ │  Manager   │  │  │  │  │
│  │  │  │  └─────────┘ └─────────┘ └────────────┘  │  │  │  │
│  │  │  └───────────────────────────────────────────┘  │  │  │
│  │  └─────────────────────────────────────────────────┘  │  │
│  │                        │                               │  │
│  │  ┌─────────────────────▼─────────────────────────────┐│  │
│  │  │              Overlay (Flutter)                     ││  │
│  │  │  ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐  ││  │
│  │  │  │ Toast 1 │ │ Toast 2 │ │ Loading │ │ Custom  │  ││  │
│  │  │  └─────────┘ └─────────┘ └─────────┘ └─────────┘  ││  │
│  │  └────────────────────────────────────────────────────┘│  │
│  └───────────────────────────────────────────────────────┘  │
│                          App Content                         │
└─────────────────────────────────────────────────────────────┘
```

### InheritedWidget Pattern

```dart
// Access pattern (similar to ScaffoldMessenger)
UniversalOverlay.of(context).showToast(
  content: ToastContent(message: "Hello!"),
);

// Theme inheritance
UniversalOverlayScope(
  toastTheme: ToastThemeData(...),
  loadingTheme: LoadingThemeData(...),
  child: child,
)
```

### Component Relationships

```
UniversalOverlayScope (InheritedWidget)
├── Provides: UniversalOverlayController
├── Manages: Theme inheritance
└── Contains: Overlay entry point

UniversalOverlayController
├── showToast() → UniversalOverlayItem
├── showLoading() → UniversalOverlayItem
├── showCustom() → UniversalOverlayItem
├── dismiss(id) → void
├── dismissAll() → void
└── State getters

UniversalOverlayItem (Controller)
├── id: String (UUID)
├── dismiss() → void
├── isPending: bool
├── isVisible: bool
└── onDismissed: Future<DismissalReason>
```

---

## 7. Core Components

### 7.1 UniversalOverlayScope

The root widget that provides overlay functionality to the widget tree.

```dart
@immutable
class UniversalOverlayScope extends StatefulWidget {
  const UniversalOverlayScope({
    super.key,
    required this.child,
    this.toastTheme,
    this.loadingTheme,
    this.customTheme,
  });

  final Widget child;
  final ToastThemeData? toastTheme;
  final LoadingThemeData? loadingTheme;
  final CustomOverlayThemeData? customTheme;
}
```

### 7.2 UniversalOverlay

Static accessor class providing the `of(context)` pattern.

```dart
@immutable
class UniversalOverlay {
  const UniversalOverlay._();

  static UniversalOverlayController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<_UniversalOverlayInherited>();
    assert(scope != null, 'No UniversalOverlayScope found in context');
    return scope!.controller;
  }
}
```

### 7.3 UniversalOverlayController

The main controller exposed via `UniversalOverlay.of(context)`.

```dart
abstract class UniversalOverlayController {
  // Toast methods
  UniversalOverlayItem showToast({
    required ToastContent content,
    ToastConfig? config,
    ToastThemeData? theme,
  });

  // Loading methods
  UniversalOverlayItem showLoading({
    String? message,
    LoadingConfig? config,
    LoadingThemeData? theme,
  });

  // Custom overlay methods
  UniversalOverlayItem showCustom({
    required CustomOverlayBuilder builder,
    CustomOverlayConfig? config,
    CustomOverlayThemeData? theme,
  });

  // Dismissal methods
  void dismiss(String id);
  void dismissAll();
  void dismissAllToasts();
  void dismissAllLoading();
  void dismissAllCustom();

  // State getters
  bool get isLoadingVisible;
  int get activeToastCount;
  bool get hasActiveOverlays;
  UniversalOverlayItem? getOverlayById(String id);
}
```

### 7.4 UniversalOverlayItem

Controller returned when showing an overlay.

```dart
@immutable
abstract class UniversalOverlayItem {
  /// Unique identifier (UUID v4)
  String get id;

  /// Dismiss this overlay
  void dismiss();

  /// Whether this overlay is waiting in queue
  bool get isPending;

  /// Whether this overlay is currently visible
  bool get isVisible;

  /// Future that completes when the overlay is dismissed
  Future<DismissalReason> get onDismissed;
}
```

---

## 8. API Specification

### 8.1 Toast API

#### ToastContent

```dart
@immutable
class ToastContent extends Equatable {
  const ToastContent({
    required this.message,
    this.leading,
    this.trailing,
    this.action,
    this.progress,
  });

  /// The main message text
  final String message;

  /// Leading widget (typically an icon)
  final Widget? leading;

  /// Trailing widget (typically a close icon)
  final Widget? trailing;

  /// Action button configuration
  final ToastAction? action;

  /// Optional progress indicator
  final ToastProgress? progress;

  @override
  List<Object?> get props => [message, leading, trailing, action, progress];
}
```

#### ToastAction

```dart
@immutable
class ToastAction extends Equatable {
  const ToastAction({
    required this.label,
    required this.onPressed,
    this.textStyle,
  });

  final String label;
  final VoidCallback onPressed;
  final TextStyle? textStyle;

  @override
  List<Object?> get props => [label, onPressed, textStyle];
}
```

#### ToastProgress

```dart
@immutable
class ToastProgress extends Equatable {
  const ToastProgress({
    this.value,
    this.color,
    this.backgroundColor,
  });

  /// Progress value (0.0 to 1.0). Null for indeterminate.
  final double? value;

  /// Progress indicator color
  final Color? color;

  /// Progress track color
  final Color? backgroundColor;

  @override
  List<Object?> get props => [value, color, backgroundColor];
}
```

#### ToastConfig

```dart
@immutable
class ToastConfig extends Equatable {
  const ToastConfig({
    this.duration = const Duration(seconds: 4),
    this.position = OverlayPosition.bottom,
    this.displayMode = ToastDisplayMode.queue,
    this.dismissalTypes = const {
      DismissalType.timer,
      DismissalType.swipe,
    },
    this.swipeDismissDirection,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationBuilder,
    this.enterAnimationBuilder,
    this.exitAnimationBuilder,
    this.barrier,
    this.onDismissed,
    this.onTap,
    this.onActionPressed,
    this.onShow,
  });

  final Duration duration;
  final OverlayPosition position;
  final ToastDisplayMode displayMode;
  final Set<DismissalType> dismissalTypes;
  final DismissDirection? swipeDismissDirection;
  final Duration animationDuration;
  final OverlayAnimationBuilder? animationBuilder;
  final OverlayAnimationBuilder? enterAnimationBuilder;
  final OverlayAnimationBuilder? exitAnimationBuilder;
  final BarrierConfig? barrier;
  final void Function(DismissalReason reason)? onDismissed;
  final VoidCallback? onTap;
  final VoidCallback? onActionPressed;
  final VoidCallback? onShow;

  ToastConfig copyWith({...});

  @override
  List<Object?> get props => [...];
}
```

### 8.2 Loading API

#### LoadingConfig

```dart
@immutable
class LoadingConfig extends Equatable {
  const LoadingConfig({
    this.style = LoadingStyle.adaptive,
    this.barrierColor = Colors.black54,
    this.barrierDismissible = false,
    this.blockInteraction = true,
    this.blockInteractionMode = BlockInteractionMode.full,
    this.allowBackButton = false,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationBuilder,
    this.onDismissed,
    this.onShow,
  });

  final LoadingStyle style;
  final Color? barrierColor;
  final bool barrierDismissible;
  final bool blockInteraction;
  final BlockInteractionMode blockInteractionMode;
  final bool allowBackButton;
  final Duration animationDuration;
  final OverlayAnimationBuilder? animationBuilder;
  final void Function(DismissalReason reason)? onDismissed;
  final VoidCallback? onShow;

  LoadingConfig copyWith({...});

  @override
  List<Object?> get props => [...];
}
```

#### LoadingStyle

```dart
enum LoadingStyle {
  /// Uses platform-appropriate indicator
  adaptive,

  /// Material CircularProgressIndicator
  material,

  /// Cupertino activity indicator
  cupertino,

  /// Custom builder
  custom,
}
```

#### BlockInteractionMode

```dart
enum BlockInteractionMode {
  /// Blocks entire screen
  full,

  /// Blocks only the area under the loading indicator
  partial,
}
```

### 8.3 Custom Overlay API

#### CustomOverlayBuilder

```dart
typedef CustomOverlayBuilder = Widget Function(
  BuildContext context,
  UniversalOverlayItem item,
);
```

#### CustomOverlayConfig

```dart
@immutable
class CustomOverlayConfig extends Equatable {
  const CustomOverlayConfig({
    this.position = OverlayPosition.center,
    this.dismissalTypes = const {DismissalType.programmatic},
    this.barrier,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationBuilder,
    this.enterAnimationBuilder,
    this.exitAnimationBuilder,
    this.onDismissed,
    this.onShow,
  });

  final OverlayPosition position;
  final Set<DismissalType> dismissalTypes;
  final BarrierConfig? barrier;
  final Duration animationDuration;
  final OverlayAnimationBuilder? animationBuilder;
  final OverlayAnimationBuilder? enterAnimationBuilder;
  final OverlayAnimationBuilder? exitAnimationBuilder;
  final void Function(DismissalReason reason)? onDismissed;
  final VoidCallback? onShow;

  CustomOverlayConfig copyWith({...});

  @override
  List<Object?> get props => [...];
}
```

---

## 9. Theming System

### 9.1 Theme Inheritance

Themes cascade from scope to individual overlays. Individual overlay themes override scope themes.

```
UniversalOverlayScope.toastTheme (base)
         │
         ▼
showToast(theme: ...) (override)
```

### 9.2 ToastThemeData

```dart
@immutable
class ToastThemeData extends Equatable {
  const ToastThemeData({
    // Display
    this.displayMode = ToastDisplayMode.queue,
    this.position = OverlayPosition.bottom,
    this.stackConfig,

    // Timing
    this.duration = const Duration(seconds: 4),
    this.animationDuration = const Duration(milliseconds: 300),

    // Animation
    this.animationBuilder,
    this.enterAnimationBuilder,
    this.exitAnimationBuilder,

    // Dismissal
    this.dismissalTypes = const {DismissalType.timer, DismissalType.swipe},
    this.swipeDismissDirection,

    // Light theme styling
    this.backgroundColor,
    this.textStyle,
    this.borderRadius,
    this.elevation,
    this.shadowColor,
    this.border,
    this.padding,
    this.margin,
    this.maxWidth,
    this.minHeight,

    // Dark theme styling (overrides light when in dark mode)
    this.darkBackgroundColor,
    this.darkTextStyle,
    this.darkShadowColor,
    this.darkBorder,

    // Icon styling
    this.leadingIconSize,
    this.leadingIconColor,
    this.trailingIconSize,
    this.trailingIconColor,

    // Action styling
    this.actionTextStyle,
    this.actionPadding,

    // Progress styling
    this.progressHeight,
    this.progressColor,
    this.progressBackgroundColor,

    // Barrier
    this.barrier,
  });

  // ... all properties

  /// Creates a copy with the given fields replaced
  ToastThemeData copyWith({...});

  /// Merges two themes, with [other] taking precedence
  ToastThemeData merge(ToastThemeData? other);

  /// Resolves theme based on brightness
  ToastThemeData resolve(Brightness brightness);

  @override
  List<Object?> get props => [...];
}
```

### 9.3 LoadingThemeData

```dart
@immutable
class LoadingThemeData extends Equatable {
  const LoadingThemeData({
    // Style
    this.style = LoadingStyle.adaptive,
    this.builder,

    // Barrier
    this.barrierColor = Colors.black54,
    this.barrierDismissible = false,
    this.blockInteraction = true,
    this.blockInteractionMode = BlockInteractionMode.full,
    this.allowBackButton = false,

    // Container
    this.backgroundColor,
    this.borderRadius,
    this.elevation,
    this.padding,
    this.minSize,

    // Indicator
    this.indicatorSize,
    this.indicatorColor,
    this.indicatorStrokeWidth,

    // Message
    this.messageTextStyle,
    this.messageSpacing,

    // Animation
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationBuilder,

    // Dark theme
    this.darkBackgroundColor,
    this.darkIndicatorColor,
    this.darkMessageTextStyle,
  });

  // ... all properties

  LoadingThemeData copyWith({...});
  LoadingThemeData merge(LoadingThemeData? other);
  LoadingThemeData resolve(Brightness brightness);

  @override
  List<Object?> get props => [...];
}
```

### 9.4 CustomOverlayThemeData

```dart
@immutable
class CustomOverlayThemeData extends Equatable {
  const CustomOverlayThemeData({
    this.position = OverlayPosition.center,
    this.dismissalTypes = const {DismissalType.programmatic},
    this.barrier,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationBuilder,
    this.enterAnimationBuilder,
    this.exitAnimationBuilder,
  });

  // ... all properties

  CustomOverlayThemeData copyWith({...});

  @override
  List<Object?> get props => [...];
}
```

### 9.5 Toast Presets

```dart
@immutable
abstract class ToastPresets {
  const ToastPresets._();

  // Material 3 Presets
  static ToastThemeData material3Success() => const ToastThemeData(
    backgroundColor: Color(0xFF2E7D32),
    darkBackgroundColor: Color(0xFF1B5E20),
    textStyle: TextStyle(color: Colors.white),
    // ... other success styling
  );

  static ToastThemeData material3Error() => const ToastThemeData(
    backgroundColor: Color(0xFFC62828),
    darkBackgroundColor: Color(0xFFB71C1C),
    textStyle: TextStyle(color: Colors.white),
    // ... other error styling
  );

  static ToastThemeData material3Warning() => const ToastThemeData(
    backgroundColor: Color(0xFFF57C00),
    darkBackgroundColor: Color(0xFFE65100),
    textStyle: TextStyle(color: Colors.white),
    // ... other warning styling
  );

  static ToastThemeData material3Info() => const ToastThemeData(
    backgroundColor: Color(0xFF1976D2),
    darkBackgroundColor: Color(0xFF0D47A1),
    textStyle: TextStyle(color: Colors.white),
    // ... other info styling
  );

  // Style Presets
  static ToastThemeData minimal() => const ToastThemeData(
    backgroundColor: Colors.black87,
    elevation: 0,
    borderRadius: BorderRadius.all(Radius.circular(4)),
    // ... minimal styling
  );

  static ToastThemeData elevated() => const ToastThemeData(
    backgroundColor: Colors.white,
    elevation: 8,
    borderRadius: BorderRadius.all(Radius.circular(12)),
    // ... elevated styling
  );

  // Platform Adaptive
  static ToastThemeData adaptive() => ToastThemeData(
    // Returns iOS style on iOS, Material on Android
    // Detected at runtime
  );
}
```

---

## 10. Animation System

### 10.1 Animation Builder Type

```dart
typedef OverlayAnimationBuilder = Widget Function(
  BuildContext context,
  Animation<double> animation,
  AlignmentGeometry alignment,
  Widget child,
);
```

### 10.2 Animation Presets

```dart
@immutable
abstract class OverlayAnimations {
  const OverlayAnimations._();

  /// Slide from top with fade
  static OverlayAnimationBuilder slideFromTop({
    Curve curve = Curves.easeOutCubic,
  }) {
    return (context, animation, alignment, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -1),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: curve)),
        child: FadeTransition(opacity: animation, child: child),
      );
    };
  }

  /// Slide from bottom with fade
  static OverlayAnimationBuilder slideFromBottom({
    Curve curve = Curves.easeOutCubic,
  }) {
    return (context, animation, alignment, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: curve)),
        child: FadeTransition(opacity: animation, child: child),
      );
    };
  }

  /// Slide from left with fade
  static OverlayAnimationBuilder slideFromLeft({
    Curve curve = Curves.easeOutCubic,
  });

  /// Slide from right with fade
  static OverlayAnimationBuilder slideFromRight({
    Curve curve = Curves.easeOutCubic,
  });

  /// Fade in/out
  static OverlayAnimationBuilder fade({
    Curve curve = Curves.easeInOut,
  }) {
    return (context, animation, alignment, child) {
      return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: curve),
        child: child,
      );
    };
  }

  /// Scale with fade
  static OverlayAnimationBuilder scale({
    Curve curve = Curves.easeOutBack,
    double beginScale = 0.8,
  }) {
    return (context, animation, alignment, child) {
      return ScaleTransition(
        scale: Tween<double>(begin: beginScale, end: 1.0)
            .animate(CurvedAnimation(parent: animation, curve: curve)),
        child: FadeTransition(opacity: animation, child: child),
      );
    };
  }

  /// Bounce effect
  static OverlayAnimationBuilder bounce({
    Curve curve = Curves.bounceOut,
  });

  /// Elastic effect
  static OverlayAnimationBuilder elastic({
    Curve curve = Curves.elasticOut,
  });

  /// No animation (instant)
  static OverlayAnimationBuilder none() {
    return (context, animation, alignment, child) => child;
  }
}
```

### 10.3 Separate Enter/Exit Animations

```dart
// Option 1: Single builder (reversed for exit)
ToastConfig(
  animationBuilder: OverlayAnimations.slideFromTop(),
)

// Option 2: Separate builders
ToastConfig(
  enterAnimationBuilder: OverlayAnimations.slideFromTop(),
  exitAnimationBuilder: OverlayAnimations.fade(),
)
```

When both `animationBuilder` and `enterAnimationBuilder`/`exitAnimationBuilder` are provided, the specific builders take precedence.

---

## 11. Dismissal System

### 11.1 Dismissal Types

```dart
enum DismissalType {
  /// Dismisses after duration expires
  timer,

  /// Dismisses on swipe gesture
  swipe,

  /// Dismisses when tapping the overlay
  tapOverlay,

  /// Dismisses when tapping outside the overlay
  tapOutside,

  /// Only dismisses via code (item.dismiss())
  programmatic,

  /// Dismisses on Android back button
  backButton,
}
```

### 11.2 Dismissal Reason

```dart
enum DismissalReason {
  /// Timer expired
  timer,

  /// User swiped
  swipe,

  /// User tapped overlay
  tapOverlay,

  /// User tapped outside
  tapOutside,

  /// Dismissed programmatically
  programmatic,

  /// Back button pressed
  backButton,

  /// Action button pressed
  action,

  /// Replaced by another overlay
  replaced,
}
```

### 11.3 Swipe Direction Configuration

```dart
ToastConfig(
  dismissalTypes: {DismissalType.swipe},
  swipeDismissDirection: DismissDirection.up, // Only swipe up to dismiss
)
```

Available directions: `up`, `down`, `left`, `right`, `horizontal`, `vertical`, `any` (default based on position).

---

## 12. Display Modes

### 12.1 Toast Display Modes

```dart
enum ToastDisplayMode {
  /// Show one toast at a time, queue others
  queue,

  /// Show multiple toasts stacked vertically
  stack,

  /// New toast immediately replaces current one
  replace,
}
```

### 12.2 Stack Configuration

```dart
@immutable
class StackConfig extends Equatable {
  const StackConfig({
    this.maxVisible = 3,
    this.spacing = 8.0,
    this.direction = StackDirection.up,
    this.overflowBehavior = StackOverflowBehavior.queue,
  });

  /// Maximum number of visible toasts
  final int maxVisible;

  /// Spacing between stacked toasts
  final double spacing;

  /// Direction new toasts push existing ones
  final StackDirection direction;

  /// Behavior when maxVisible is exceeded
  final StackOverflowBehavior overflowBehavior;

  @override
  List<Object?> get props => [maxVisible, spacing, direction, overflowBehavior];
}

enum StackDirection {
  /// New toasts push old ones up
  up,

  /// New toasts push old ones down
  down,
}

enum StackOverflowBehavior {
  /// Queue excess toasts
  queue,

  /// Dismiss oldest toast
  dismissOldest,
}
```

---

## 13. State Management

### 13.1 Internal State

The overlay manager maintains internal state for:
- Active overlays (Map<String, OverlayEntry>)
- Toast queue (Queue<PendingToast>)
- Loading state
- Animation controllers

### 13.2 Exposed State

```dart
abstract class UniversalOverlayController {
  /// Whether a loading overlay is currently visible
  bool get isLoadingVisible;

  /// Number of active (visible + queued) toasts
  int get activeToastCount;

  /// Whether any overlay is currently visible
  bool get hasActiveOverlays;

  /// Get an overlay item by its ID
  UniversalOverlayItem? getOverlayById(String id);
}
```

### 13.3 Item State

```dart
abstract class UniversalOverlayItem {
  /// Whether this item is waiting in queue
  bool get isPending;

  /// Whether this item is currently visible
  bool get isVisible;

  /// Future that completes with dismissal reason
  Future<DismissalReason> get onDismissed;
}
```

---

## 14. Testing Utilities

### 14.1 Test Finders

```dart
extension UniversalOverlayFinders on CommonFinders {
  /// Finds toast overlays by message
  Finder universalOverlayToast(String message) {
    return find.byWidgetPredicate(
      (widget) => widget is ToastWidget && widget.content.message == message,
    );
  }

  /// Finds any visible toast
  Finder universalOverlayToastAny() {
    return find.byType(ToastWidget);
  }

  /// Finds loading overlay
  Finder universalOverlayLoading() {
    return find.byType(LoadingOverlayWidget);
  }

  /// Finds loading overlay with message
  Finder universalOverlayLoadingWithMessage(String message) {
    return find.byWidgetPredicate(
      (widget) => widget is LoadingOverlayWidget && widget.message == message,
    );
  }

  /// Finds custom overlay
  Finder universalOverlayCustom() {
    return find.byType(CustomOverlayWidget);
  }
}
```

### 14.2 Test Helpers

```dart
class UniversalOverlayTester {
  UniversalOverlayTester._(this._controller);

  final UniversalOverlayController _controller;

  /// Gets tester from widget tester
  static UniversalOverlayTester of(WidgetTester tester) {
    final context = tester.element(find.byType(UniversalOverlayScope));
    return UniversalOverlayTester._(UniversalOverlay.of(context));
  }

  /// Whether a toast with the given message is visible
  bool isToastVisible(String message);

  /// Whether loading overlay is visible
  bool get isLoadingVisible => _controller.isLoadingVisible;

  /// Number of active toasts
  int get activeToastCount => _controller.activeToastCount;

  /// Dismisses all overlays
  void dismissAll() => _controller.dismissAll();

  /// Verifies a toast was shown
  void verifyToastShown({
    required String message,
    ToastThemeData? theme,
  });
}
```

### 14.3 Test Example

```dart
testWidgets('shows success toast', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      builder: (context, child) => UniversalOverlayScope(child: child!),
      home: Builder(
        builder: (context) => ElevatedButton(
          onPressed: () {
            UniversalOverlay.of(context).showToast(
              content: ToastContent(message: 'Success!'),
            );
          },
          child: Text('Show Toast'),
        ),
      ),
    ),
  );

  await tester.tap(find.text('Show Toast'));
  await tester.pump();
  await tester.pump(Duration(milliseconds: 300)); // Animation

  expect(find.universalOverlayToast('Success!'), findsOneWidget);

  final overlayTester = UniversalOverlayTester.of(tester);
  expect(overlayTester.activeToastCount, equals(1));
});
```

---

## 15. Dependencies

### 15.1 Required Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `uuid` | ^4.0.0 | Generate unique overlay IDs |
| `equatable` | ^2.0.0 | Value equality for models |
| `collection` | ^1.18.0 | Queue management (ListQueue) |
| `meta` | ^1.11.0 | Annotations (@immutable, @sealed) |

### 15.2 pubspec.yaml

```yaml
name: universal_overlay
description: A comprehensive Flutter overlay system for toasts, loading indicators, and custom overlays using InheritedWidget pattern.
version: 1.0.0
homepage: https://github.com/username/universal_overlay
repository: https://github.com/username/universal_overlay
issue_tracker: https://github.com/username/universal_overlay/issues
documentation: https://pub.dev/documentation/universal_overlay/latest/

environment:
  sdk: '>=3.0.0 <4.0.0'
  flutter: '>=3.10.0'

dependencies:
  flutter:
    sdk: flutter
  uuid: ^4.0.0
  equatable: ^2.0.0
  collection: ^1.18.0
  meta: ^1.11.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
  mocktail: ^1.0.0

flutter:
  # No assets required
```

---

## 16. File Structure

```
universal_overlay/
├── lib/
│   ├── universal_overlay.dart              # Main export file
│   └── src/
│       ├── core/
│       │   ├── universal_overlay.dart      # Static accessor
│       │   ├── universal_overlay_scope.dart
│       │   ├── universal_overlay_controller.dart
│       │   ├── universal_overlay_item.dart
│       │   └── overlay_manager.dart
│       │
│       ├── toast/
│       │   ├── toast_content.dart
│       │   ├── toast_action.dart
│       │   ├── toast_progress.dart
│       │   ├── toast_config.dart
│       │   ├── toast_theme_data.dart
│       │   ├── toast_presets.dart
│       │   ├── toast_widget.dart
│       │   └── toast_manager.dart
│       │
│       ├── loading/
│       │   ├── loading_config.dart
│       │   ├── loading_theme_data.dart
│       │   ├── loading_style.dart
│       │   ├── loading_widget.dart
│       │   └── loading_manager.dart
│       │
│       ├── custom/
│       │   ├── custom_overlay_config.dart
│       │   ├── custom_overlay_theme_data.dart
│       │   ├── custom_overlay_builder.dart
│       │   ├── custom_overlay_widget.dart
│       │   └── custom_overlay_manager.dart
│       │
│       ├── shared/
│       │   ├── enums/
│       │   │   ├── overlay_position.dart
│       │   │   ├── dismissal_type.dart
│       │   │   ├── dismissal_reason.dart
│       │   │   ├── toast_display_mode.dart
│       │   │   └── stack_direction.dart
│       │   ├── models/
│       │   │   ├── barrier_config.dart
│       │   │   └── stack_config.dart
│       │   ├── animations/
│       │   │   ├── overlay_animation_builder.dart
│       │   │   └── overlay_animations.dart
│       │   └── utils/
│       │       └── id_generator.dart
│       │
│       └── testing/
│           ├── universal_overlay_finders.dart
│           └── universal_overlay_tester.dart
│
├── test/
│   ├── core/
│   │   ├── universal_overlay_scope_test.dart
│   │   └── universal_overlay_controller_test.dart
│   ├── toast/
│   │   ├── toast_content_test.dart
│   │   ├── toast_theme_data_test.dart
│   │   └── toast_widget_test.dart
│   ├── loading/
│   │   └── loading_widget_test.dart
│   ├── custom/
│   │   └── custom_overlay_test.dart
│   └── integration/
│       ├── display_modes_test.dart
│       └── animation_test.dart
│
├── example/
│   └── lib/
│       └── main.dart
│
├── CHANGELOG.md
├── LICENSE
├── README.md
├── pubspec.yaml
└── analysis_options.yaml
```

---

## 17. Usage Examples

### 17.1 Basic Setup

```dart
import 'package:flutter/material.dart';
import 'package:universal_overlay/universal_overlay.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return UniversalOverlayScope(
          toastTheme: ToastThemeData(
            displayMode: ToastDisplayMode.queue,
            position: OverlayPosition.bottom,
            backgroundColor: Colors.black87,
            textStyle: TextStyle(color: Colors.white),
          ),
          loadingTheme: LoadingThemeData(
            backgroundColor: Colors.white,
            barrierColor: Colors.black54,
            blockInteraction: true,
          ),
          child: child!,
        );
      },
      home: HomePage(),
    );
  }
}
```

### 17.2 Simple Toast

```dart
// Basic toast
UniversalOverlay.of(context).showToast(
  content: ToastContent(message: "Hello, World!"),
);

// Toast with icon
UniversalOverlay.of(context).showToast(
  content: ToastContent(
    message: "File saved successfully",
    leading: Icon(Icons.check_circle, color: Colors.green),
  ),
);
```

### 17.3 Toast with Action

```dart
UniversalOverlay.of(context).showToast(
  content: ToastContent(
    message: "Message deleted",
    action: ToastAction(
      label: "Undo",
      onPressed: () => restoreMessage(),
    ),
  ),
);
```

### 17.4 Toast with Preset Theme

```dart
// Success toast
UniversalOverlay.of(context).showToast(
  content: ToastContent(
    message: "Operation successful!",
    leading: Icon(Icons.check_circle),
  ),
  theme: ToastPresets.material3Success(),
);

// Error toast
UniversalOverlay.of(context).showToast(
  content: ToastContent(
    message: "Something went wrong",
    leading: Icon(Icons.error),
  ),
  theme: ToastPresets.material3Error(),
);
```

### 17.5 Toast with Progress

```dart
UniversalOverlay.of(context).showToast(
  content: ToastContent(
    message: "Uploading file...",
    leading: Icon(Icons.cloud_upload),
    progress: ToastProgress(
      value: 0.65, // 65% complete
      color: Colors.blue,
    ),
  ),
  config: ToastConfig(
    dismissalTypes: {DismissalType.programmatic}, // Only dismiss via code
  ),
);
```

### 17.6 Custom Animation

```dart
UniversalOverlay.of(context).showToast(
  content: ToastContent(message: "Custom animation!"),
  config: ToastConfig(
    animationDuration: Duration(milliseconds: 300),
    animationBuilder: (context, animation, alignment, child) {
      return RotationTransition(
        turns: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
        child: ScaleTransition(
          scale: animation,
          child: child,
        ),
      );
    },
  ),
);
```

### 17.7 Separate Enter/Exit Animations

```dart
UniversalOverlay.of(context).showToast(
  content: ToastContent(message: "Slide in, fade out!"),
  config: ToastConfig(
    enterAnimationBuilder: OverlayAnimations.slideFromTop(),
    exitAnimationBuilder: OverlayAnimations.fade(),
  ),
);
```

### 17.8 Stacked Toasts

```dart
// Configure in scope
UniversalOverlayScope(
  toastTheme: ToastThemeData(
    displayMode: ToastDisplayMode.stack,
    stackConfig: StackConfig(
      maxVisible: 3,
      spacing: 8.0,
      direction: StackDirection.up,
    ),
  ),
  child: child,
)

// Show multiple toasts
UniversalOverlay.of(context).showToast(
  content: ToastContent(message: "First toast"),
);
UniversalOverlay.of(context).showToast(
  content: ToastContent(message: "Second toast"),
);
UniversalOverlay.of(context).showToast(
  content: ToastContent(message: "Third toast"),
);
```

### 17.9 Loading Indicator

```dart
// Show loading
final loading = UniversalOverlay.of(context).showLoading(
  message: "Processing...",
);

// Perform async operation
await performOperation();

// Dismiss loading
loading.dismiss();
```

### 17.10 Loading with Custom Widget

```dart
UniversalOverlay.of(context).showLoading(
  config: LoadingConfig(
    style: LoadingStyle.custom,
  ),
  theme: LoadingThemeData(
    builder: (context) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Lottie.asset('assets/loading.json', width: 100),
        SizedBox(height: 16),
        Text('Please wait...'),
      ],
    ),
  ),
);
```

### 17.11 Custom Overlay

```dart
UniversalOverlayItem item = UniversalOverlay.of(context).showCustom(
  builder: (context, item) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Custom Overlay',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Text('This is a custom overlay with full control.'),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => item.dismiss(),
            child: Text('Close'),
          ),
        ],
      ),
    );
  },
  config: CustomOverlayConfig(
    position: OverlayPosition.center,
    dismissalTypes: {DismissalType.tapOutside},
    barrier: BarrierConfig(
      color: Colors.black54,
      dismissible: true,
    ),
  ),
);
```

### 17.12 Dismissal Callbacks

```dart
UniversalOverlay.of(context).showToast(
  content: ToastContent(message: "Swipe to dismiss"),
  config: ToastConfig(
    dismissalTypes: {DismissalType.swipe, DismissalType.timer},
    onDismissed: (reason) {
      print("Toast dismissed by: $reason");
      if (reason == DismissalReason.swipe) {
        // Track swipe dismissal
      }
    },
    onShow: () {
      print("Toast is now visible");
    },
  ),
);
```

### 17.13 Dismiss by ID

```dart
// Store the item
final item = UniversalOverlay.of(context).showToast(
  content: ToastContent(message: "Persistent toast"),
  config: ToastConfig(
    dismissalTypes: {DismissalType.programmatic},
  ),
);

// Later, dismiss by ID
UniversalOverlay.of(context).dismiss(item.id);

// Or dismiss directly
item.dismiss();
```

### 17.14 Await Dismissal

```dart
final item = UniversalOverlay.of(context).showToast(
  content: ToastContent(message: "Processing..."),
);

final reason = await item.onDismissed;
print("Toast was dismissed by: $reason");
```

### 17.15 Check State

```dart
final overlay = UniversalOverlay.of(context);

if (overlay.isLoadingVisible) {
  print("Loading is already showing");
  return;
}

if (overlay.activeToastCount >= 3) {
  print("Too many toasts, wait for some to clear");
  return;
}

if (overlay.hasActiveOverlays) {
  overlay.dismissAll();
}
```

### 17.16 Toast with Barrier

```dart
UniversalOverlay.of(context).showToast(
  content: ToastContent(
    message: "Important notification!",
    leading: Icon(Icons.warning, color: Colors.orange),
  ),
  config: ToastConfig(
    barrier: BarrierConfig(
      color: Colors.black26,
      dismissible: true,
    ),
  ),
);
```

---

## 18. Future Enhancements

### Phase 2 (v1.1.0)

| Feature | Description | Priority |
|---------|-------------|----------|
| **Accessibility** | Screen reader support, semantic labels | High |
| **Minimum Duration** | Accessibility-compliant display times | High |
| **Loading Message Update** | Update message/progress after showing | Medium |

### Phase 3 (v1.2.0)

| Feature | Description | Priority |
|---------|-------------|----------|
| **Dialogs** | Built-in dialog overlay type | Medium |
| **Bottom Sheets** | Built-in bottom sheet overlay type | Medium |
| **Tooltips** | Built-in tooltip overlay type | Low |

### Phase 4 (v2.0.0)

| Feature | Description | Priority |
|---------|-------------|----------|
| **Persistent Banners** | App-wide notification banners | Medium |
| **Grouped Overlays** | Manage related overlays as groups | Low |
| **History/Logging** | Track overlay history for debugging | Low |

---

## 19. Success Metrics

### Technical Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| Test Coverage | >90% | Code coverage tools |
| Performance | <16ms frame time | Flutter DevTools |
| Bundle Size | <50KB | Build analysis |
| API Surface | <30 public classes | Documentation |

### Adoption Metrics

| Metric | Target (6 months) | Measurement |
|--------|-------------------|-------------|
| Pub.dev Likes | >100 | Pub.dev |
| GitHub Stars | >200 | GitHub |
| Weekly Downloads | >1000 | Pub.dev |
| Issues Resolved | >90% | GitHub |

### Quality Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| Documentation | 100% public API | Dartdoc |
| Example Coverage | All features | Example app |
| Breaking Changes | 0 per minor version | Changelog |

---

## 20. Appendix

### A. Overlay Position Reference

```dart
enum OverlayPosition {
  /// Top center of the screen
  top,

  /// Top left corner
  topLeft,

  /// Top right corner
  topRight,

  /// Center of the screen
  center,

  /// Center left
  centerLeft,

  /// Center right
  centerRight,

  /// Bottom center of the screen
  bottom,

  /// Bottom left corner
  bottomLeft,

  /// Bottom right corner
  bottomRight,
}
```

### B. Barrier Configuration

```dart
@immutable
class BarrierConfig extends Equatable {
  const BarrierConfig({
    this.color = Colors.black54,
    this.dismissible = false,
    this.label,
  });

  /// Barrier color
  final Color color;

  /// Whether tapping the barrier dismisses the overlay
  final bool dismissible;

  /// Semantic label for accessibility
  final String? label;

  @override
  List<Object?> get props => [color, dismissible, label];
}
```

### C. Default Values Reference

| Property | Default Value |
|----------|---------------|
| Toast Duration | 4 seconds |
| Toast Position | bottom |
| Toast Display Mode | queue |
| Animation Duration | 300ms |
| Loading Barrier Color | Colors.black54 |
| Loading Block Interaction | true |
| Stack Max Visible | 3 |
| Stack Spacing | 8.0 |

### D. Glossary

| Term | Definition |
|------|------------|
| **Overlay** | A widget displayed above the main content |
| **Toast** | A brief notification message |
| **Barrier** | A semi-transparent layer behind an overlay |
| **Queue** | FIFO display mode for overlays |
| **Stack** | Multiple overlays visible simultaneously |
| **Dismissal** | The act of hiding an overlay |

---

**Document Version History**

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0.0 | January 30, 2026 | Fady | Initial PRD |

---

*End of Document*