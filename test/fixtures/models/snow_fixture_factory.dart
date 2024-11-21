import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:weather/models/snow/snow.dart';

extension SnowFixture on Snow {
  static SnowFixtureFactory factory() => SnowFixtureFactory();
}

class SnowFixtureFactory extends FixtureFactory<Snow> {
  @override
  FixtureDefinition<Snow> definition() => define(
        (faker) => Snow(
          faker.randomGenerator.decimal(),
        ),
      );
}
