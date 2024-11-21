import 'package:dart_mapper/dart_mapper.dart';
import 'package:weather/models/clouds/clouds.dart';
import 'package:weather/models/forecast/forecast.dart';
import 'package:weather/models/main/main.dart';
import 'package:weather/models/rain/rain.dart';
import 'package:weather/models/snow/snow.dart';
import 'package:weather/models/sys/sys.dart';
import 'package:weather/models/weather/weather.dart';
import 'package:weather/models/wind/wind.dart';
import 'package:weather/services/network/dtos/clouds/clouds_dto.dart';
import 'package:weather/services/network/dtos/forecast/forecast_dto.dart';
import 'package:weather/services/network/dtos/main/main_dto.dart';
import 'package:weather/services/network/dtos/rain/rain_dto.dart';
import 'package:weather/services/network/dtos/snow/snow_dto.dart';
import 'package:weather/services/network/dtos/sys/sys_dto.dart';
import 'package:weather/services/network/dtos/weather/weather_dto.dart';
import 'package:weather/services/network/dtos/wind/wind_dto.dart';

part 'forecast_mapper.g.dart';

/// The ForecastMapper to convert ForecastDTO to Forecast
@Mapper()
abstract class ForecastMapper {
  /// The ForecastMapper constructor
  const ForecastMapper();

  /// The method to convert a ForecastDTO to a Forecast
  Forecast fromForecastDTO(ForecastDTO dto);
}