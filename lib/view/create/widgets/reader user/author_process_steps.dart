import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tech_node/core/constants/themes.dart';

class AuthorProcessSteps extends StatefulWidget {
  const AuthorProcessSteps({super.key});

  @override
  State<AuthorProcessSteps> createState() => _AuthorProcessStepsState();
}

class _AuthorProcessStepsState extends State<AuthorProcessSteps> {
  int _currentStep = 1; // Defaulting to step 1 (the active action task)

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.01),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.03)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Sliding Step Headers & Control Toggles
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "MILESTONE PROFILE",
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.3),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),

              // Arrow Switchers to shift Left and Right
              Row(
                children: [
                  IconButton(
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      LucideIcons.chevronLeft,
                      size: 16,
                      color: _currentStep == 0
                          ? Colors.white10
                          : Colors.white54,
                    ),
                    onPressed: _currentStep == 0
                        ? null
                        : () => setState(() => _currentStep = 0),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      LucideIcons.chevronRight,
                      size: 16,
                      color: _currentStep == 1
                          ? Colors.white10
                          : Colors.white54,
                    ),
                    onPressed: _currentStep == 1
                        ? null
                        : () => setState(() => _currentStep = 1),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // 2. Swappable Content Views based on active index selection
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: _currentStep == 0
                ? _buildStepContent(
                    key: const ValueKey(0),
                    icon: LucideIcons.checkCircle2,
                    iconColor: context.primary,
                    stepNumber: "Step 1 of 2",
                    title: "Account Setup Completed",
                    description:
                        "Your safe authentication keys and local storage files are initialized.",
                  )
                : _buildStepContent(
                    key: const ValueKey(1),
                    icon: LucideIcons.feather,
                    iconColor: Colors.amberAccent,
                    stepNumber: "Step 2 of 2 (Action Required)",
                    title: "Verify Creator Profile",
                    description:
                        "Submit your specialization fields to unlock your Markdown engine.",
                  ),
          ),
          const SizedBox(height: 20),

          // 3. Dynamic Progress Bar matching the active view index
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: _currentStep == 0
                  ? 0.5
                  : 1.0, // Moves forward as they switch steps
              backgroundColor: Colors.white.withValues(alpha: 0.04),
              valueColor: AlwaysStoppedAnimation<Color>(
                _currentStep == 0
                    ? context.primary.withValues(alpha: 0.5)
                    : context.primary,
              ),
              minHeight: 4,
            ),
          ),
        ],
      ),
    );
  }

  // Quick internal clean widget layer to house the information text patterns
  Widget _buildStepContent({
    required Key key,
    required IconData icon,
    required Color iconColor,
    required String stepNumber,
    required String title,
    required String description,
  }) {
    return Column(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor, size: 18),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.4),
            fontSize: 12,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          stepNumber,
          style: TextStyle(
            color: context.primary.withValues(alpha: 0.6),
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
