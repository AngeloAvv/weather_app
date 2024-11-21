import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:weather/models/rain/rain.dart';

extension RainFixture on Rain {
  static RainFixtureFactory factory() => RainFixtureFactory();
}

class RainFixtureFactory extends FixtureFactory<Rain> {
  @override
  FixtureDefinition<Rain> definition() => define(
        (faker) => Rain(
          faker.randomGenerator.decimal(),
        ),
      );
}
