import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/constants/themes.dart';
import 'package:tech_node/core/custom/custom_text_style.dart';

class CustomScaffoldMessage {
  // ✅ Keep track of the currently visible message
  static OverlayEntry? _currentEntry;

  static void show(
    BuildContext context, {
    required String message,
    bool isError = false,
  }) {
    final overlay = Overlay.of(context);

    // ✅ 1. Remove the previous message if it's still showing
    _currentEntry?.remove();
    _currentEntry = null;

    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (overlayContext) => Positioned(
        top: MediaQuery.of(overlayContext).padding.top + 10,
        right: 16,
        left: 16,
        child: Material(
          color: Colors.transparent,
          child: _ToastWidget(
            message: message,
            isError: isError,
            onClose: () {
              if (entry.mounted) {
                entry.remove();
                // Clear the reference if this was the current one
                if (_currentEntry == entry) _currentEntry = null;
              }
            },
          ),
        ),
      ),
    );

    // ✅ 2. Store the new entry and insert it
    _currentEntry = entry;
    overlay.insert(entry);

    // ✅ 3. Auto-hide logic
    Future.delayed(const Duration(seconds: 30), () {
      if (entry.mounted && _currentEntry == entry) {
        entry.remove();
        _currentEntry = null;
      }
    });
  }
}

class _ToastWidget extends StatelessWidget {
  final String message;
  final bool isError;
  final VoidCallback onClose;

  const _ToastWidget({
    required this.message,
    required this.isError,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isError ? Colors.redAccent : context.primary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isError ? LucideIcons.alertCircle : LucideIcons.checkCircle,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: CustomTextStyle(
              text: message,
              fontSize: 14,
              textColor: Colors.white,
            ),
          ),
          IconButton(
            onPressed: onClose,
            icon: const Icon(LucideIcons.x, color: Colors.white, size: 18),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}

// class CustomScaffoldMessage {
//   static void show(
//     BuildContext context, {
//     required String message,
//     bool isError = false,
//   }) {
//     final overlay = Overlay.of(context);
//     late OverlayEntry entry;

//     entry = OverlayEntry(
//       builder: (overlayContext) => Positioned(
//         top: MediaQuery.of(overlayContext).padding.top + 10,
//         right: 16,
//         left: 16,
//         child: Material(
//           color: Colors.transparent,
//           child: _ToastWidget(
//             message: message,
//             isError: isError,
//             onClose: () => entry.remove(),
//           ),
//         ),
//       ),
//     );

//     overlay.insert(entry);
//     Future.delayed(const Duration(seconds: 7), () {
//       if (entry.mounted) entry.remove();
//     });
//   }
// }
