import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_yerke/core/style/app_theme.dart';
import 'package:weather_yerke/features/current_weather/domain/entities/weather_entity.dart';

class WeatherForecastItems extends StatelessWidget {
  
  final WeatherEntity weatherEntity;

  WeatherForecastItems({
    @required this.weatherEntity
  });

  @override
  Widget build(BuildContext context) {
    final totalDaysCount = (weatherEntity?.forecasts ?? []).length;
    final itemCount = totalDaysCount >= 3 ? 3 : totalDaysCount;
    final itemWidth = (MediaQuery.of(context).size.width - 64) / 3;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 0.0,
        mainAxisSpacing: 12.0,
        childAspectRatio: itemWidth / 40
      ), 
      itemCount: itemCount * 3,
      itemBuilder: (context, index) {
        final itemIndex = (index/3).floor();
        final weather = weatherEntity.forecasts[itemIndex];

        if (index % 3 == 0) {
          return _buildDayText(
            weather?.dateTime != null ?
              DateFormat("EEE").format(
                weather.dateTime
              ) : "---",
          );
        } else if (index % 3 == 1) {
          return _buildDayConditionView(weather);
        } else {
          return Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "${weather.temperature?.toStringAsFixed(0) ?? "--"}°", 
                  style: AppTextStyle.medium
                ),
                const SizedBox(width: 8),
                Text(
                  "${weather.feelsLikeTemperature?.toStringAsFixed(0) ?? "--"}°", 
                  style: AppTextStyle.medium.copyWith(
                    color: Colors.white54
                  )
                ),
              ],
            ),
          );
        }
      }
    );
  }

  // MARK: - UI Helpers

  Widget _buildDayText (String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Spacer(),
        Text(
          text,
          style: AppTextStyle.medium.copyWith(
            color: Colors.grey[400]
          ),
        ),
        Spacer(),
      ],
    );
  }

  Widget _buildDayConditionView (WeatherEntity weather) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          weather.condition?.mainImagePath,
          width: 24,
          height: 24
        ),
        const SizedBox(width: 4),
        Text(
          weather.condition?.name ?? "",
          style: AppTextStyle.medium.copyWith(
            color: Colors.grey[400]
          ),
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }
}