import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';

class AlphabetSelector extends StatelessWidget {
  final String? selectedLetter;
  final Function(String?) onLetterSelected;

  const AlphabetSelector({
    super.key,
    required this.selectedLetter,
    required this.onLetterSelected,
  });

  @override
  Widget build(BuildContext context) {
    const alphabet = [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      'O',
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y',
      'Z',
    ];

    return Container(
      height: 60,
      color: AppColors.primaryDark,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: alphabet.length + 1, // +1 for "All" option
              itemBuilder: (context, index) {
                if (index == 0) {
                  // "All" option
                  return _buildLetterItem(
                    'All',
                    selectedLetter == null,
                    () => onLetterSelected(null),
                  );
                } else {
                  final letter = alphabet[index - 1];
                  return _buildLetterItem(
                    letter,
                    selectedLetter == letter,
                    () => onLetterSelected(letter),
                  );
                }
              },
            ),
          ),
          Container(height: 1, color: AppColors.divider),
        ],
      ),
    );
  }

  Widget _buildLetterItem(String letter, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? AppColors.primaryBlue : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        child: Text(
          letter,
          style: TextStyle(
            color: isSelected ? AppColors.primaryBlue : AppColors.textPrimary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
