import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';

class DaySelector extends StatelessWidget {
  final List<String> days;
  final String selectedDay;
  final Function(String) onDaySelected;

  const DaySelector({
    super.key,
    required this.days,
    required this.selectedDay,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: AppColors.primaryDark,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        itemBuilder: (context, index) {
          final day = days[index];
          final isSelected = day == selectedDay;

          return GestureDetector(
            onTap: () => onDaySelected(day),
            child: Container(
              width: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color:
                        isSelected ? AppColors.primaryBlue : Colors.transparent,
                    width: 3,
                  ),
                ),
              ),
              child: Text(
                day,
                style: TextStyle(
                  color:
                      isSelected
                          ? AppColors.primaryBlue
                          : AppColors.textPrimary,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 16,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
