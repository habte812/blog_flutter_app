// import 'package:flutter/material.dart';
// import 'package:tech_node/view/followings/following_state.dart';

// class GuestIllustrationPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final w = size.width;
//     final h = size.height;

//     // Background circle
//     canvas.drawCircle(
//       Offset(w / 2, h / 2),
//       w / 2,
//       Paint()..color = AppTheme.accentLight,
//     );

//     // Decorative rings
//     final ringPaint = Paint()
//       ..color = AppTheme.accent.withOpacity(0.12)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 1.5;
//     canvas.drawCircle(Offset(w / 2, h / 2), w / 2 - 8, ringPaint);
//     canvas.drawCircle(
//       Offset(w / 2, h / 2),
//       w / 2 - 18,
//       ringPaint..color = AppTheme.accent.withOpacity(0.07),
//     );

//     // Open book shape
//     final bookPaint = Paint()
//       ..color = AppTheme.cardBg
//       ..style = PaintingStyle.fill;
//     final shadowPaint = Paint()
//       ..color = AppTheme.brand.withOpacity(0.10)
//       ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

//     final bookLeft = Path()
//       ..moveTo(w * 0.22, h * 0.38)
//       ..lineTo(w * 0.50, h * 0.42)
//       ..lineTo(w * 0.50, h * 0.72)
//       ..lineTo(w * 0.22, h * 0.68)
//       ..close();
//     final bookRight = Path()
//       ..moveTo(w * 0.78, h * 0.38)
//       ..lineTo(w * 0.50, h * 0.42)
//       ..lineTo(w * 0.50, h * 0.72)
//       ..lineTo(w * 0.78, h * 0.68)
//       ..close();

//     canvas.drawPath(bookLeft, shadowPaint);
//     canvas.drawPath(bookRight, shadowPaint);
//     canvas.drawPath(bookLeft, bookPaint);
//     canvas.drawPath(bookRight, bookPaint);

//     // Book spine line
//     final spinePaint = Paint()
//       ..color = AppTheme.borderColor
//       ..strokeWidth = 1.5;
//     canvas.drawLine(
//       Offset(w * 0.50, h * 0.42),
//       Offset(w * 0.50, h * 0.72),
//       spinePaint,
//     );

//     // Lines on pages
//     final linePaint = Paint()
//       ..color = AppTheme.borderColor
//       ..strokeWidth = 1.2
//       ..strokeCap = StrokeCap.round;
//     for (int i = 0; i < 4; i++) {
//       final y = h * 0.50 + i * h * 0.054;
//       canvas.drawLine(Offset(w * 0.27, y), Offset(w * 0.46, y), linePaint);
//       canvas.drawLine(Offset(w * 0.54, y), Offset(w * 0.73, y), linePaint);
//     }

//     // Three floating avatar circles (authors)
//     void drawAvatar(Offset center, double r, Color fill, String initial) {
//       canvas.drawCircle(
//         center,
//         r + 2,
//         Paint()..color = AppTheme.cardBg,
//       ); // white ring
//       canvas.drawCircle(center, r, Paint()..color = fill);
//       final tp = TextPainter(
//         text: TextSpan(
//           text: initial,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: r * 0.9,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         textDirection: TextDirection.ltr,
//       )..layout();
//       tp.paint(canvas, center - Offset(tp.width / 2, tp.height / 2));
//     }

//     drawAvatar(
//       Offset(w * 0.20, h * 0.28),
//       w * 0.09,
//       const Color(0xFF6366F1),
//       'A',
//     );
//     drawAvatar(
//       Offset(w * 0.80, h * 0.28),
//       w * 0.09,
//       const Color(0xFF10B981),
//       'M',
//     );
//     drawAvatar(Offset(w * 0.50, h * 0.20), w * 0.075, AppTheme.accent, 'S');

//     // Lock icon centered (shows locked/sign-in required)
//     final lockPaint = Paint()
//       ..color = AppTheme.accent
//       ..style = PaintingStyle.fill;
//     final cx = w * 0.50;
//     final cy = h * 0.57;
//     final lr = w * 0.055;

//     // Lock body
//     final lockBody = RRect.fromRectAndRadius(
//       Rect.fromCenter(
//         center: Offset(cx, cy + lr * 0.7),
//         width: lr * 2.2,
//         height: lr * 1.8,
//       ),
//       Radius.circular(lr * 0.3),
//     );
//     canvas.drawRRect(lockBody, lockPaint);

//     // Lock shackle
//     final shacklePaint = Paint()
//       ..color = AppTheme.accent
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = lr * 0.35
//       ..strokeCap = StrokeCap.round;
//     final shackle = Path()
//       ..moveTo(cx - lr * 0.65, cy + lr * 0.1)
//       ..lineTo(cx - lr * 0.65, cy - lr * 0.55)
//       ..arcToPoint(
//         Offset(cx + lr * 0.65, cy - lr * 0.55),
//         radius: Radius.circular(lr * 0.65),
//         clockwise: false,
//       )
//       ..lineTo(cx + lr * 0.65, cy + lr * 0.1);
//     canvas.drawPath(shackle, shacklePaint);

//     // Keyhole
//     canvas.drawCircle(
//       Offset(cx, cy + lr * 0.55),
//       lr * 0.22,
//       Paint()..color = Colors.white,
//     );
//     canvas.drawRect(
//       Rect.fromCenter(
//         center: Offset(cx, cy + lr * 0.9),
//         width: lr * 0.28,
//         height: lr * 0.45,
//       ),
//       Paint()..color = Colors.white,
//     );
//   }

//   @override
//   bool shouldRepaint(GuestIllustrationPainter old) => false;
// }