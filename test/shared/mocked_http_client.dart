import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:weather_yerke/core/models/location.dart';

class MockHttpClient extends Mock implements http.Client {
  // void handleAnyMockRequest (http.Response response) {
  //   when(this.get(any, headers: anyNamed('headers')))
  //     .thenAnswer((_) async => response);
  // }
}
