import 'package:flutter/material.dart';
import 'package:weather_yerke/core/style/app_theme.dart';
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
        padding: const EdgeInsets.symmetric(
          horizontal: 16
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Allow us to access your location",
                style: AppTextStyle.bold.copyWith(
                  fontSize: 20
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "This is needed to determine the weather in your city.",
                style: AppTextStyle.medium.copyWith(
                  fontSize: 16,
                  color: Colors.white60
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Divider(color: Colors.white24),
              const SizedBox(height: 8),
              _buildStepTile(
                icon: Icons.settings,
                title: "Go to Settings",
              ),
              _buildStepTile(
                icon: Icons.ac_unit,
                title: "Open this application from there",
              ),
              _buildStepTile(
                icon: Icons.place,
                title: "Click on the button Location",
              ),
              _buildStepTile(
                icon: Icons.settings_applications,
                title: "Select one option except Never",
              ),
            ],
          ),
        ),
      );

    return Container();
  }


  ListTile _buildStepTile ({
    @required String title,
    @required IconData icon 
  }) => ListTile(
    leading: Icon(
      icon, color: Colors.white,
    ),
    title: Text(
      title,
      style: AppTextStyle.medium.copyWith(
        fontSize: 14
      )
    ),
  );
}