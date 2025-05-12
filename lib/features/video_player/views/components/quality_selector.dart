import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';

class QualityOption {
  final String label;
  final String value;
  final String size;

  QualityOption({required this.label, required this.value, required this.size});
}

class QualitySelector extends StatelessWidget {
  final List<QualityOption> options;
  final String selectedQuality;
  final Function(String) onQualitySelected;

  const QualitySelector({
    super.key,
    required this.options,
    required this.selectedQuality,
    required this.onQualitySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: const [
                Icon(Icons.settings, color: Colors.white, size: 16),
                SizedBox(width: 8),
                Text(
                  'Quality',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.grey, height: 1),
          ...options.map((option) => _buildQualityOption(option)),
        ],
      ),
    );
  }

  Widget _buildQualityOption(QualityOption option) {
    final isSelected = option.value == selectedQuality;

    return InkWell(
      onTap: () => onQualitySelected(option.value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        color:
            isSelected
                ? AppColors.primaryBlue.withOpacity(0.3)
                : Colors.transparent,
        child: Row(
          children: [
            if (isSelected)
              const Icon(Icons.check, color: AppColors.primaryBlue, size: 16),
            if (isSelected) const SizedBox(width: 8),
            Text(
              option.label,
              style: TextStyle(
                color: isSelected ? AppColors.primaryBlue : Colors.white,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            const Spacer(),
            Text(
              option.size,
              style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
