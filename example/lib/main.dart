import 'package:flutter/material.dart';
import 'package:universal_overlay/universal_overlay.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Universal Overlay Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      builder: (context, child) {
        return UniversalOverlay(
          toastTheme: const ToastThemeData(
            displayMode: ToastDisplayMode.replace,
            position: OverlayPosition.bottom,
          ),
          loadingTheme: const LoadingThemeData(barrierColor: Colors.black54),
          child: child!,
        );
      },
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Universal Overlay Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSection(
              title: 'Toast Examples',
              children: [
                _DemoButton(
                  label: 'Simple Toast',
                  onPressed: () {
                    UniversalOverlay.of(context).showToast(
                      content: const ToastContent(message: 'Hello, World!'),
                    );
                  },
                ),
                _DemoButton(
                  label: 'Toast with Icon',
                  onPressed: () {
                    UniversalOverlay.of(context).showToast(
                      content: const ToastContent(
                        message: 'File saved successfully',
                        leading: Icon(Icons.check_circle, color: Colors.green),
                      ),
                    );
                  },
                ),
                _DemoButton(
                  label: 'Success Toast',
                  onPressed: () {
                    UniversalOverlay.of(context).showToast(
                      content: const ToastContent(
                        message: 'Operation successful!',
                        leading: Icon(Icons.check_circle),
                      ),
                      theme: ToastPresets.material3Success(),
                    );
                  },
                ),
                _DemoButton(
                  label: 'Error Toast',
                  onPressed: () {
                    UniversalOverlay.of(context).showToast(
                      content: const ToastContent(
                        message: 'Something went wrong',
                        leading: Icon(Icons.error),
                      ),
                      theme: ToastPresets.material3Error(),
                    );
                  },
                ),
                _DemoButton(
                  label: 'Warning Toast',
                  onPressed: () {
                    UniversalOverlay.of(context).showToast(
                      content: const ToastContent(
                        message: 'Please check your input',
                        leading: Icon(Icons.warning),
                      ),
                      theme: ToastPresets.material3Warning(),
                    );
                  },
                ),
                _DemoButton(
                  label: 'Info Toast',
                  onPressed: () {
                    UniversalOverlay.of(context).showToast(
                      content: const ToastContent(
                        message: 'New update available',
                        leading: Icon(Icons.info),
                      ),
                      theme: ToastPresets.material3Info(),
                    );
                  },
                ),
                _DemoButton(
                  label: 'Toast with Action',
                  onPressed: () {
                    UniversalOverlay.of(context).showToast(
                      content: ToastContent(
                        message: 'Message deleted',
                        action: ToastAction(
                          label: 'Undo',
                          onPressed: () {
                            UniversalOverlay.of(context).showToast(
                              content: const ToastContent(
                                message: 'Message restored',
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
                _DemoButton(
                  label: 'Toast with Progress',
                  onPressed: () {
                    UniversalOverlay.of(context).showToast(
                      content: const ToastContent(
                        message: 'Uploading file...',
                        leading: Icon(Icons.cloud_upload),
                        progress: ToastProgress(
                          value: 0.65,
                          color: Colors.blue,
                        ),
                      ),
                      theme: const ToastThemeData(
                        duration: Duration(seconds: 6),
                      ),
                    );
                  },
                ),
                _DemoButton(
                  label: 'Toast at Top',
                  onPressed: () {
                    UniversalOverlay.of(context).showToast(
                      content: const ToastContent(message: 'Toast at top!'),
                      theme: const ToastThemeData(
                        position: OverlayPosition.top,
                      ),
                    );
                  },
                ),
                _DemoButton(
                  label: 'Custom Animation',
                  onPressed: () {
                    UniversalOverlay.of(context).showToast(
                      content: const ToastContent(message: 'Bouncy toast!'),
                      theme: ToastThemeData(
                        animationBuilder: OverlayAnimations.bounce(),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Loading Examples',
              children: [
                _DemoButton(
                  label: 'Simple Loading',
                  onPressed: () async {
                    final loading = UniversalOverlay.of(
                      context,
                    ).showLoading(message: 'Processing...');
                    await Future.delayed(const Duration(seconds: 2));
                    loading.dismiss();
                  },
                ),
                _DemoButton(
                  label: 'Loading without Message',
                  onPressed: () async {
                    final loading = UniversalOverlay.of(context).showLoading();
                    await Future.delayed(const Duration(seconds: 2));
                    loading.dismiss();
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Custom Overlay Examples',
              children: [
                _DemoButton(
                  label: 'Custom Dialog',
                  onPressed: () {
                    UniversalOverlay.of(context).showCustom(
                      builder: (context, item) {
                        return Material(
                          child: Container(
                            margin: const EdgeInsets.all(32),
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.2),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.rocket_launch,
                                  size: 48,
                                  color: Colors.deepPurple,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Custom Overlay',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'This is a fully customizable overlay!',
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 24),
                                FilledButton(
                                  onPressed: () => item.dismiss(),
                                  child: const Text('Close'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      theme: const CustomOverlayThemeData(
                        position: OverlayPosition.center,
                        dismissalTypes: {DismissalType.tapOutside},
                        barrier: BarrierConfig(
                          color: Colors.black54,
                          dismissible: true,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Dismiss Controls',
              children: [
                _DemoButton(
                  label: 'Dismiss All',
                  onPressed: () {
                    UniversalOverlay.of(context).dismissAll();
                  },
                ),
                _DemoButton(
                  label: 'Dismiss All Toasts',
                  onPressed: () {
                    UniversalOverlay.of(context).dismissAllToasts();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Wrap(spacing: 8, runSpacing: 8, children: children),
      ],
    );
  }
}

class _DemoButton extends StatelessWidget {
  const _DemoButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(onPressed: onPressed, child: Text(label));
  }
}
