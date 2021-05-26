import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:weather_yerke/core/blocs/cubit/internet_connection_cubit.dart';
import 'package:weather_yerke/features/current_weather/presentation/bloc/location/user_location_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_yerke/features/current_weather/presentation/pages/current_weather_page.dart';
import './injector.dart' as dependencyInjector;
import 'core/style/app_theme.dart';
import 'features/current_weather/presentation/bloc/current_weather/current_weather_cubit.dart';

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
        ),
        BlocProvider<InternetConnectionCubit>(
          create: (_) => dependencyInjector.sl<InternetConnectionCubit>()
        )
      ],
      child: MaterialApp(
        home: BlocConsumer<InternetConnectionCubit, InternetConnectionState>(
          listener: (context, _) {},
          builder: (BuildContext context, InternetConnectionState state) {
            if (state.status == InternetConnectionStatus.noConnection) {
              return NoInternetWidget();
            }

            return CurrentWeatherPage();
          },
        ),
      ),
    );
  }
}


class NoInternetWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "No Internet Connection",
              style: AppTextStyle.bold.copyWith(
                color: Colors.black, 
                fontSize: 24
              )
            ),
            const SizedBox(height: 8),
            Text("Please check your network connection")
          ],
        ),
      ),
    );
  }
}