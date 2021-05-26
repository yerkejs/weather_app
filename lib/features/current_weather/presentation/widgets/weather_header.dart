import 'package:flutter/material.dart';
import 'package:weather_yerke/core/constants/constants.dart';
import 'package:weather_yerke/core/style/app_theme.dart';
import 'package:weather_yerke/features/current_weather/domain/entities/weather_entity.dart';
import 'package:weather_yerke/features/current_weather/presentation/widgets/weather_characteristics_view.dart';
import 'package:intl/intl.dart';

class WeatherHeader extends StatelessWidget {

  final WeatherEntity weather;
  final Function() onClickCityInfo;

  WeatherHeader({
    @required this.weather,
    @required this.onClickCityInfo
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildLayout(
        context, 
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 20, horizontal: 16
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.pin_drop,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        weather.city.cityName,
                        style: AppTextStyle.semibold.copyWith(
                          fontSize: 20
                        )
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildCityInfoButton()
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  if (weather.condition?.mainImagePath != null)
                    Image.asset(
                      weather.condition?.mainImagePath,
                      width: 128,
                      height: 128,
                    ),
                  const SizedBox(width: 16),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        weather.dateTime != null ? 
                          DateFormat('EEEE').format(
                            weather.dateTime 
                          ) : "--/--/--",
                        style: AppTextStyle.regular.copyWith(
                          fontSize: 18
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            weather.temperature?.toStringAsFixed(0) ?? "--",
                            style: AppTextStyle.bold.copyWith(
                              fontSize: 60
                            )
                          ),
                          Text(
                            "/${weather.feelsLikeTemperature?.toStringAsFixed(0) ?? "--"}°",
                            style: AppTextStyle.bold.copyWith(
                              fontSize: 30,
                              color: Colors.white30
                            )
                          ),
                        ],
                      ),
                      Text(
                        weather.condition?.description?.toUpperCase() ?? "--",
                        style: AppTextStyle.regular.copyWith(
                          fontSize: 14,
                          color: Colors.white60
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 4),
              Divider(
                color: Color(0xff4fc4f4)
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _getWeatherCharacteristicsWidgets(),
              )
            ],
          ),
        )
      ),
    );
  }

  // MARK: - UI Helpers

  Widget _buildCityInfoButton () {
    return InkWell(
      onTap: onClickCityInfo,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 4, horizontal: 16
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white54
          )
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 2,
              backgroundColor: Colors.orange,
            ),
            const SizedBox(width: 8),
            Text(
              "Info",
              style: AppTextStyle.regular.copyWith(
                fontSize: 12
              ),
            )
          ],
        )
      ),
    );
  }

  Widget _buildLayout (BuildContext context, {
    Widget child
  }) => Stack(
    children: [
      Positioned(
        bottom: 10,
        left: 12,
        child: Container(
          height: 80,
          width: MediaQuery.of(context).size.width - 56,
          decoration: BoxDecoration(
            color: Color(0xff073b87),
            borderRadius: BorderRadius.circular(85),
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff4fc4f4),
              Color(0xff116af6)
            ]
          ),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: Color(0xff4fc4f4),
          )
        ),
        width: MediaQuery.of(context).size.width - 32,
        child: child,
      ),
    ],
  );

  List<Widget> _getWeatherCharacteristicsWidgets () => [
    WeatherCharacteristicsView(
      title: weather.windSpeed.toString() + " km/h", 
      description: 'Wind', 
      iconPath: '${ICONS_ASSET_PATH}wind.png'
    ),
    WeatherCharacteristicsView(
      title: weather.humidity.toString() + " %", 
      description: 'Humidity', 
      iconPath: '${ICONS_ASSET_PATH}humidity.png'
    ),
    WeatherCharacteristicsView(
      title: weather.pressure.toString() + ' mb', 
      description: 'Pressure', 
      iconPath: '${ICONS_ASSET_PATH}pressure.png'
    )
  ];
}