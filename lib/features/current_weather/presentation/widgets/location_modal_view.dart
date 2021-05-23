import 'package:flutter/material.dart';
import 'package:weather_yerke/features/current_weather/presentation/bloc/location/user_location_bloc.dart';

class LocationModalView extends StatelessWidget {
  
  final UserLocationState locationState;
  
  LocationModalView({
    @required this.locationState
  });

  @override
  Widget build(BuildContext context) {    
    if (locationState is LocationUseDenied || locationState is LocationUseDeniedForever)
      return Container(
        child: Center(
          child: Text("Go to the settings"),
        ),
      );

    if (locationState is LocationUseFailure)
      return Column(
        children: [
          Text("An error happened"),
          InkWell(
            child: Container(
              child: Text("Retry"),
            ),
          )
        ],
      );

    return Container();
  }
}