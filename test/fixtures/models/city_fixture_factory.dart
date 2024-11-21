import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:weather/models/city/city.dart';

import 'coord_fixture_factory.dart';

extension CityFixture on City {
  static CityFixtureFactory factory() => CityFixtureFactory();
}

class CityFixtureFactory extends FixtureFactory<City> {
  @override
  FixtureDefinition<City> definition() => define(
        (faker) => City(
            id: faker.randomGenerator.integer(9999),
            name: faker.address.city(),
            coord: CoordFixture.factory().makeSingle(),
            country: faker.address.countryCode(),
            population: faker.randomGenerator.integer(9999),
            timezone: faker.randomGenerator.integer(9999),
            sunrise: faker.randomGenerator.integer(9999),
            sunset: faker.randomGenerator.integer(9999)
        ),
      );
}
