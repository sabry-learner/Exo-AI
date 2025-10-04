import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClassificationCard extends StatelessWidget {
  final String title; 
  final String totalCount;
  final String percentageChange;
  final String changeDescription;
  final IconData iconData;
  final Color iconBackgroundColor;

  const ClassificationCard({
    super.key,
    required this.title, 
    required this.totalCount,
    required this.percentageChange,
    required this.changeDescription,
    required this.iconData,
    required this.iconBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    const Color darkBackgroundColor = Color(0xFF1A1C2C);
    const Color primaryTextColor = Colors.white;
    const Color secondaryTextColor = Color(0xFF6C6F82);

    final bool isPositive = percentageChange.startsWith('+') || percentageChange.endsWith('h');
    final Color increaseColor = isPositive ? const Color(0xFF5DD974) : Colors.red;

    return Container(
      padding: EdgeInsets.all(16.w), // متجاوب
      decoration: BoxDecoration(
        color: darkBackgroundColor,
        borderRadius: BorderRadius.circular(12.r), // متجاوب
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10.r, // متجاوب
            offset: Offset(0, 5.h), // متجاوب
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title, 
                style: TextStyle(
                  color: secondaryTextColor,
                  fontSize: 14.sp, // متجاوب
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4.h), // متجاوب
              Text(
                totalCount,
                style: TextStyle(
                  color: primaryTextColor,
                  fontSize: 32.sp, // متجاوب
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h), // متجاوب
              Row(
                children: [
                  Text(
                    percentageChange,
                    style: TextStyle(
                      color: increaseColor,
                      fontSize: 14.sp, // متجاوب
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 4.w), // متجاوب
                  Text(
                    changeDescription,
                    style: TextStyle(
                      color: secondaryTextColor,
                      fontSize: 14.sp, // متجاوب
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: 56.w, // متجاوب
            height: 56.h, // متجاوب
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              borderRadius: BorderRadius.circular(12.r), // متجاوب
            ),
            child: Icon(
              iconData,
              color: primaryTextColor,
              size: 32.sp, // متجاوب
            ),
          ),
        ],
      ),
    );
  }
}
