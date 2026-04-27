import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class KpiCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String unit;

  const KpiCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Card(
      child: AspectRatio(
        aspectRatio: 1.6,
        child: Padding(
          padding: EdgeInsets.all(screenHeight * 0.012),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(screenHeight * 0.006),
                    decoration: BoxDecoration(
                      color: AppColors.primaryOrange.withAlpha(25),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(icon, color: AppColors.primaryOrange, size: screenHeight * 0.016),
                  ),
                  SizedBox(width: screenHeight * 0.008),
                  Text(
                    title,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: screenHeight * 0.012,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        value,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: screenHeight * 0.024,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: screenHeight * 0.002),
                        child: Text(
                          unit,
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: screenHeight * 0.012,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
