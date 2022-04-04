import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

/// Search cubit used to toggle the search of a city
class SearchCubit extends Cubit<bool> {
  /// The logger service
  final Logger logger;

  /// The search TextField controller
  final TextEditingController searchController = TextEditingController();
  final BehaviorSubject<String> _searchSubject = BehaviorSubject();

  /// SearchCubit constructor
  SearchCubit({required this.logger}) : super(false);

  /// A getter to update the search value in the sink
  Function(String) get updateSearchValue => _searchSubject.sink.add;

  /// A getter to get the search stream
  Stream<String> get searchStream => _searchSubject.stream;

  @override
  Future<void> close() async {
    await _searchSubject.close();
    searchController.dispose();

    return super.close();
  }

  /// Method used to reset the search controller and clean the search field
  void cleanSearch() {
    logger.d('Clearing search field');
    searchController.text = '';
  }

  /// Method used to enable the search
  void toggleSearch() {
    logger.d('Toggling search');
    if (state) {
      cleanSearch();
    }

    emit(!state);
  }
}
