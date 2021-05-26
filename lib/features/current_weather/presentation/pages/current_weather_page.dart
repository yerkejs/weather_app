import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_yerke/features/current_weather/presentation/bloc/current_weather/current_weather_cubit.dart';
import 'package:weather_yerke/features/current_weather/presentation/bloc/location/user_location_bloc.dart';
import 'package:weather_yerke/features/current_weather/presentation/pages/weather_view.dart';
import 'package:weather_yerke/features/current_weather/presentation/widgets/location_modal_view.dart';

class CurrentWeatherPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: BlocConsumer<UserLocationBloc, UserLocationState>(
          listener: (context, locationState) {
            if (locationState is LocationUseSucceed) { 
              context.read<CurrentWeatherCubit>().getWeatherByLocation(locationState.geolocation);
            } else if (locationState is LocationUseApproved) {
              context.read<UserLocationBloc>().add(GetUserLocation());
            } else if (locationState is LocationUseDenied) {
              context.read<UserLocationBloc>().add(LocationUseRequestPermission());
            } else if (locationState is LocationUseFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Location error occured",)
              ));
            }
          },
          builder: (context, locationState) {
            if (!(locationState is LocationUseApproved)) {
              return LocationModalView(locationState: locationState);
            }

            return WeatherView();
          }, 
        )
      ),
    );
  }
}