import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:weather/models/forecast/forecast.dart';

import 'clouds_fixture_factory.dart';
import 'main_fixture_factory.dart';
import 'rain_fixture_factory.dart';
import 'snow_fixture_factory.dart';
import 'sys_fixture_factory.dart';
import 'weather_fixture_factory.dart';
import 'wind_fixture_factory.dart';

extension ForecastFixture on Forecast {
  static ForecastFixtureFactory factory() => ForecastFixtureFactory();
}

class ForecastFixtureFactory extends FixtureFactory<Forecast> {
  @override
  FixtureDefinition<Forecast> definition() => define(
        (faker) => Forecast(
            dt: faker.date.dateTime(),
            main: MainFixture.factory().makeSingle(),
            weather: WeatherFixture.factory().makeMany(3),
            clouds: CloudsFixture.factory().makeSingle(),
            wind: WindFixture.factory().makeSingle(),
            rain: RainFixture.factory().makeSingle(),
            snow: SnowFixture.factory().makeSingle(),
            visibility: faker.randomGenerator.integer(1000),
            pop: faker.randomGenerator.decimal(),
            sys: SysFixture.factory().makeSingle(),
            dtTxt: faker.date.dateTime().toIso8601String(),
        ),
      );
}
