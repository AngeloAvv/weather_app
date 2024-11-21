import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:weather/models/sys/sys.dart';

extension SysFixture on Sys {
  static SysFixtureFactory factory() => SysFixtureFactory();
}

class SysFixtureFactory extends FixtureFactory<Sys> {
  @override
  FixtureDefinition<Sys> definition() => define(
        (faker) => Sys(faker.lorem.word()),
      );
}
