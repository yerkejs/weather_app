import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:weather_yerke/features/current_weather/presentation/bloc/location/user_location_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_yerke/features/current_weather/presentation/pages/current_weather_page.dart';
import './injector.dart' as dependencyInjector;
import 'features/current_weather/presentation/bloc/current_weather/current_weather_cubit.dart';
import 'features/search_weather/presentation/search_weather_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependencyInjector.init();
  await Hive.initFlutter();

  runApp(AppMain());
}

class AppMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserLocationBloc>(
          create: (_) => dependencyInjector.sl<UserLocationBloc>()
            ..add(LocationUseCheckPermission()),
        ),
        BlocProvider<CurrentWeatherCubit>(
          create: (_) => dependencyInjector.sl<CurrentWeatherCubit>(),
        )
      ],
      child: MaterialApp(
        home: CurrentWeatherPage(),
      ),
    );
  }
}