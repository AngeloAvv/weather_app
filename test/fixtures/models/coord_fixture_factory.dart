import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:weather/models/coord/coord.dart';

extension CoordFixture on Coord {
  static CoordFixtureFactory factory() => CoordFixtureFactory();
}

class CoordFixtureFactory extends FixtureFactory<Coord> {
  @override
  FixtureDefinition<Coord> definition() => define(
        (faker) => Coord(
          lat: faker.randomGenerator.decimal(min: -90),
          lon: faker.randomGenerator.decimal(min: -180),
        ),
      );
}
