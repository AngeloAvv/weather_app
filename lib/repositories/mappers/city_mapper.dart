import 'package:dart_mapper/dart_mapper.dart';
import 'package:weather/models/city/city.dart';
import 'package:weather/models/coord/coord.dart';
import 'package:weather/services/network/dtos/city/city_dto.dart';
import 'package:weather/services/network/dtos/coord/coord_dto.dart';

part 'city_mapper.g.dart';

/// The CityMapper to convert CityDTO to City
@Mapper()
abstract class CityMapper {
  /// The CityMapper constructor
  const CityMapper();

  /// The method to convert a CityDTO to a City
  City fromCityDTO(CityDTO dto);
}