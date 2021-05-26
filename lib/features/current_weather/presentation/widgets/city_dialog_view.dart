import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_yerke/core/style/app_theme.dart';
import 'package:weather_yerke/features/current_weather/domain/entities/city.dart';

class CityDialogView extends StatelessWidget {
  
  final City city;
  final Function() onChangeCityClick;
  final Function() onSelectBoston;

  CityDialogView({
    @required this.city,
    @required this.onChangeCityClick,
    @required this.onSelectBoston
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          32
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 24
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff4fc4f4),
              Color(0xff116af6)
            ]
          ),
          borderRadius: BorderRadius.circular(16)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              city.cityName,
              style: AppTextStyle.bold.copyWith(
                fontSize: 24,
              ),
            ),
            Divider(
              color: Color(0xff4fc4f4),
            ),
            const SizedBox(height: 24,),
            Text(
              "Country: " + city.conutryCode,
              style: AppTextStyle.regular.copyWith(
                
              ),
            ),
            const SizedBox(height: 4,),
            Text(
              "Sunset: "+ DateFormat(DateFormat.HOUR_MINUTE).format(
                city.sunset
              ),
              style: AppTextStyle.regular.copyWith(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4,),
            Text(
              "Sunrise: "+ DateFormat(DateFormat.HOUR_MINUTE).format(
                city.sunrise
              ),
              style: AppTextStyle.regular.copyWith(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Divider(
              color: Color(0xff4fc4f4),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onChangeCityClick();
              }, 
              child: Text("Change")
            ),
            const SizedBox(height: 4),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onSelectBoston();
              }, 
              child: Text("Switch to Boston")
            )
          ],
        ),
      ),
    );
  }
}