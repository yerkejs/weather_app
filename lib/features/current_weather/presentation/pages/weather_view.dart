import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_yerke/features/current_weather/presentation/bloc/current_weather/current_weather_cubit.dart';
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
          color: Colors.red,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => SearchWeatherPage()
                  ));
                }, 
                child: Text("Change city")
              ),
              Text(state.weatherDetails?.temperature.toString() ?? ""),
              Text(state.weatherDetails?.cityName ?? ""),
              Text(state.weatherDetails?.condition?.description ?? ""),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: state.weatherDetails?.forecasts?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return Text(
                      state.weatherDetails.forecasts[index].humidity.toString()
                    );
                  }
                ),
              )
            ],
          ),
        );
      }, 
    );
  }
}