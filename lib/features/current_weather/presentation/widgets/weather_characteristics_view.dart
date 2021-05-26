import 'package:flutter/material.dart';
import 'package:weather_yerke/core/style/app_theme.dart';

class WeatherCharacteristicsView extends StatelessWidget {
  
  final String title;
  final String description;
  final String iconPath;
  
  WeatherCharacteristicsView({
    @required this.title,
    @required this.description,
    @required this.iconPath
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Opacity(
            opacity: 0.7,
            child: Image.asset(
              iconPath,
              width: 24,
              height: 24,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: AppTextStyle.semibold.copyWith(
              fontSize: 14
            )
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: AppTextStyle.semibold.copyWith(
              fontSize: 12,
              color: Colors.white54
            )
          )
        ],
      ),
    );
  }
}