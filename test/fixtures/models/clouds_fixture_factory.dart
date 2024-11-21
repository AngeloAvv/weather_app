import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:weather/models/clouds/clouds.dart';

extension CloudsFixture on Clouds {
  static CloudsFixtureFactory factory() => CloudsFixtureFactory();
}

class CloudsFixtureFactory extends FixtureFactory<Clouds> {
  @override
  FixtureDefinition<Clouds> definition() => define(
        (faker) => Clouds(
          faker.randomGenerator.integer(100),
        ),
      );
}
