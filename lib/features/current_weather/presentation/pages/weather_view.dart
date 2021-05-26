import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_yerke/features/current_weather/presentation/bloc/current_weather/current_weather_cubit.dart';
import 'package:weather_yerke/features/current_weather/presentation/pages/current_weather_page.dart';
import 'package:weather_yerke/features/current_weather/presentation/widgets/city_dialog_view.dart';
import 'package:weather_yerke/features/current_weather/presentation/widgets/weather_forecast_items.dart';
import 'package:weather_yerke/features/current_weather/presentation/widgets/weather_header.dart';
import 'package:weather_yerke/features/search_weather/presentation/search_weather_page.dart';

class WeatherView extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CurrentWeatherCubit, CurrentWeatherState>(
      listener: (context, CurrentWeatherState state) {
        if (state.status is CurrentWeatherErrorStatus) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(
              (state.status as CurrentWeatherErrorStatus).message 
            ))
          );
        }
      },
      builder: (BuildContext context, CurrentWeatherState state) {
        if (state.status is CurrentWeatherLoadingStatus) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 12
          ),
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              WeatherHeader(
                weather: state.weatherDetails,
                onClickCityInfo: () {
                  showDialog(
                    context: context, 
                    builder: (_) => CityDialogView(
                      city: state.weatherDetails.city,
                      onChangeCityClick: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SearchWeatherPage()
                        ));
                      },
                      onSelectBoston: () {
                        context.read<CurrentWeatherCubit>().getWeatherByCity("Boston");
                      },
                    )
                  );
                },
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16
                  ),
                  child: WeatherForecastItems(
                    weatherEntity: state.weatherDetails,
                  )
                )
              )
            ],
          ),
        );
      }, 
    );
  }
}