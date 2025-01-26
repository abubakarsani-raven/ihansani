import 'package:flutter/material.dart';

class IconTextSwitch extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool value;
  final ValueChanged<bool> onChanged;

  const IconTextSwitch({
    super.key,
    required this.icon,
    required this.text,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
              color: Colors.deepPurple,
            ),
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        CustomSwitch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeColor: Colors.white,
      // Thumb color when active
      activeTrackColor: Colors.deepPurple,
      // Track color when active
      inactiveThumbColor: Colors.deepPurple,
      // Thumb color when inactive
      inactiveTrackColor: Colors.white.withOpacity(0.3),
      // Track color when inactive
      trackOutlineColor: WidgetStateProperty.resolveWith<Color?>(
        (states) => states.contains(MaterialState.selected)
            ? Colors.deepPurple
            : Colors.deepPurple.withOpacity(0.5),
      ),
      trackOutlineWidth: WidgetStateProperty.all(1.5),
      // Consistent outline width
      thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
        (states) {
          // Ensures thumb remains consistent regardless of state
          if (states.contains(WidgetState.selected)) {
            return const Icon(
              Icons.circle,
              color: Colors.white,
              size: 12, // Consistent size when active
            );
          }
          return const Icon(
            Icons.circle,
            color: Colors.deepPurple,
            size: 12, // Consistent size when inactive
          );
        },
      ),
      materialTapTargetSize:
          MaterialTapTargetSize.shrinkWrap, // Compact tap target size
    );
  }
}
