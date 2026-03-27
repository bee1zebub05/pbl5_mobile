import 'package:flutter/material.dart';
import 'package:pbl5_mobile/generated/colors.gen.dart';
import 'package:pbl5_mobile/src/common/widgets/text/paragrahp_text.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _navItem(Icons.location_on_outlined, "GPS Tracker", 1),
          _navItem(Icons.remove_red_eye, "Vision Feed", 0),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xffDBEAFE) // màu xanh nhạt như hình
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox(
          height: 60,
          width: 120,
          child: Column(
            children: [
              Icon(
                icon,
                size: 30,
                color: isSelected ? ColorName.primary : ColorName.muted,
              ),
              const SizedBox(width: 8),
              ParagraphText(
                text: label,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? ColorName.primary : ColorName.muted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
