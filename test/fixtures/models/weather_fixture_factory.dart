import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:weather/models/weather/weather.dart';

extension WeatherFixture on Weather {
  static WeatherFixtureFactory factory() => WeatherFixtureFactory();
}

class WeatherFixtureFactory extends FixtureFactory<Weather> {
  @override
  FixtureDefinition<Weather> definition() => define(
        (faker) => Weather(
            id: faker.randomGenerator.integer(9999),
            main: faker.lorem.word(),
            description: faker.lorem.word(),
            icon: faker.lorem.word(),
        ),
      );
}
