import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:weather/models/wind/wind.dart';

extension WindFixture on Wind {
  static WindFixtureFactory factory() => WindFixtureFactory();
}

class WindFixtureFactory extends FixtureFactory<Wind> {
  @override
  FixtureDefinition<Wind> definition() => define(
        (faker) => Wind(
            speed: faker.randomGenerator.decimal(min: 0),
            deg: faker.randomGenerator.integer(360),
        ),
      );
}
