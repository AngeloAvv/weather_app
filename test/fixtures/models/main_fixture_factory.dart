import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:weather/models/main/main.dart';

extension MainFixture on Main {
  static MainFixtureFactory factory() => MainFixtureFactory();
}

class MainFixtureFactory extends FixtureFactory<Main> {
  @override
  FixtureDefinition<Main> definition() => define(
        (faker) => Main(
            temp: faker.randomGenerator.decimal(),
            feelsLike: faker.randomGenerator.decimal(),
            tempMin: faker.randomGenerator.decimal(),
            tempMax: faker.randomGenerator.decimal(),
            pressure: faker.randomGenerator.integer(10),
            seaLevel: faker.randomGenerator.integer(10),
            grndLevel: faker.randomGenerator.integer(10),
            humidity: faker.randomGenerator.integer(10),
            tempKf: faker.randomGenerator.decimal(),
        ),
      );
}
