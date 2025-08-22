import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zanadu/core/constants.dart';

class DynamicPopupMenu extends StatelessWidget {
  final String selectedValue;
  final List<String> items;
  final Function(String) onSelected;

  DynamicPopupMenu({
    required this.selectedValue,
    required this.items,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: AppColors.textLight.withOpacity(0.4)),
      ),
      child: PopupMenuButton<String>(
        color: AppColors.white,
        onSelected: onSelected,
        itemBuilder: (BuildContext context) {
          return items.map((String item) {
            return PopupMenuItem<String>(
              value: item,
              child:
                  simpleText(item, color: AppColors.textLight.withOpacity(0.7)),
            );
          }).toList();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              simpleText(selectedValue,
                  fontWeight: FontWeight.w400, color: AppColors.textDark),
              SvgPicture.asset(
                'assets/icons/arrow-up.svg',
                width: 24,
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DynamicPopupMenuHealthChart extends StatelessWidget {
  final String selectedValue;
  final List<String> items;
  final Function(String) onSelected;

  DynamicPopupMenuHealthChart({
    required this.selectedValue,
    required this.items,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //  height: 56.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: AppColors.textLight.withOpacity(0.6)),
      ),
      child: PopupMenuButton<String>(
        color: AppColors.white,
        onSelected: onSelected,
        itemBuilder: (BuildContext context) {
          return items.map((String item) {
            return PopupMenuItem<String>(
              value: item,
              child:
                  simpleText(item, color: AppColors.textLight.withOpacity(0.7)),
            );
          }).toList();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 7.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              simpleText(selectedValue,
                  color: AppColors.textLight.withOpacity(0.7)),
              SvgPicture.asset('assets/icons/arrow-up.svg'),
            ],
          ),
        ),
      ),
    );
  }
}
