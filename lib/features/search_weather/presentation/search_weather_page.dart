import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_yerke/features/current_weather/presentation/bloc/current_weather/current_weather_cubit.dart';
import 'package:weather_yerke/features/search_weather/presentation/cubit/search_city_cubit.dart';
import 'package:weather_yerke/features/search_weather/presentation/widgets/hightlight_text.dart';
import '../../../injector.dart';

class SearchWeatherPage extends StatefulWidget {
  @override
  _SearchWeatherPageState createState() => _SearchWeatherPageState();
}

class _SearchWeatherPageState extends State<SearchWeatherPage> {
  
  final TextEditingController cityController = TextEditingController();
  
  @override 
  void dispose() {
    this.cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(
          vertical: 0, horizontal: 16
        ),
        child: BlocProvider(
          create: (context) => sl<SearchCityCubit>()..getSavedCities(),
          child: BlocConsumer<SearchCityCubit, SearchCityState> (
            listener: (BuildContext context, SearchCityState state) {
              if (state.status == SearchCityStatus.done) {
                context.read<SearchCityCubit>().saveCity(cityController.text);
                context.read<CurrentWeatherCubit>().getWeatherByCity(cityController.text);
                Navigator.of(context).pop();
              }
            },
            builder: (BuildContext context, SearchCityState state) {
              return Container(
                width: MediaQuery.of(context).size.width - 32,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _getSearchHeader(context),
                    InkWell(
                      onTap: () => context.read<SearchCityCubit>().onSelectedCity(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text("Select ${cityController.text}")
                            ),
                            const SizedBox(width: 12),
                            Icon(
                              Icons.chevron_right
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.historySearches.length,
                        itemBuilder: (BuildContext context, int index) {
                          return HighlightText(
                            text: state.historySearches[index],
                            highlight: state.queryText,
                            maxLines: 1,
                            highlightColor: Colors.red,
                            style: TextStyle(
                              color: Colors.black
                            ),
                          );
                        }
                      )
                    )
                  ],
                ),
              );
            }, 
          )
        )
      ),
    );
  }

  Widget _getSearchHeader (BuildContext context) => Row(
    children: [
      Expanded(
        child: TextField(
          controller: cityController,
          decoration: InputDecoration(
            hintText: "Search",
          ),
          onChanged: (String text) {
            context.read<SearchCityCubit>().cityQueryChanged(text);
          },
        ),
      ),
      const SizedBox(width: 16),
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () => context.read<SearchCityCubit>().onSelectedCity()
      )
    ]
  );
}