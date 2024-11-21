import 'package:app_settings/app_settings.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:weather/blocs/forecast/forecast_bloc.dart';
import 'package:weather/errors/invalid_api_exception.dart';
import 'package:weather/errors/not_found_exception.dart';
import 'package:weather/features/routing/app_router.dart';
import 'package:weather/pages/main/widgets/generic_error_widget.dart';
import 'package:weather/pages/main/widgets/invalid_api_error_widget.dart';
import 'package:weather/pages/main/widgets/no_internet_error_widget.dart';
import 'package:weather/pages/main/widgets/not_found_error_widget.dart';
import 'package:weather/pages/main/widgets/reactive_search_field.dart';
import 'package:weather/pages/main/widgets/search_button.dart';
import 'package:weather/pages/main/widgets/searching_button.dart';
import 'package:weather/pages/main/widgets/forecast_widget.dart';
import 'package:weather/widgets/loading_widget.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:weather/pages/main/widgets/welcome_widget.dart';

/// The MainPage widget page
@RoutePage()
class MainPage extends StatefulWidget implements AutoRouteWrapper {
  static const _kSearchForm = 'search';

  /// The MainPage constructor
  const MainPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<ForecastBloc>(
            create: (context) => ForecastBloc(
              repository: context.read(),
            ),
          ),
        ],
        child: this,
      );

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _searching = false;

  final _form = FormGroup({
    MainPage._kSearchForm: FormControl<String>(
      validators: [Validators.required],
    ),
  });

  @override
  Widget build(BuildContext context) => OfflineBuilder(
        connectivityBuilder: (
          context,
          connectivity,
          _,
        ) {
          final connected = !connectivity.contains(ConnectivityResult.none);

          return Scaffold(
            resizeToAvoidBottomInset: false,
            extendBodyBehindAppBar: true,
            appBar: switch (connected) {
              true => AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: _searching ? 1 : 0,
                  automaticallyImplyLeading: _searching,
                  title: switch (_searching) {
                    true => ReactiveForm(
                      formGroup: _form,
                      child: ReactiveSearchField(
                          formControlName: MainPage._kSearchForm,
                          onSubmitted: (_) {
                            _performSearch(context);
                            _clearSearch();
                          },
                        ),
                    ),
                    _ => null,
                  },
                  actions: [
                    if (_searching)
                      CloseButton(
                        onPressed: () {
                          final city = _form
                              .control(MainPage._kSearchForm)
                              .value as String?;

                          if (city == null || city.isEmpty == true) {
                            Navigator.pop(context);
                            return;
                          }

                          _clearSearch();
                        },
                      ),
                    if (!_searching)
                      BlocBuilder<ForecastBloc, ForecastState>(
                        builder: (context, state) => switch (state) {
                          FetchingForecastState() => const SearchingButton(),
                          _ => SearchButton(
                              onPressed: () => _startSearch(context),
                            ),
                        },
                      ),
                  ],
                ),
              false => null,
            },
            body: switch (connected) {
              true => BlocBuilder<ForecastBloc, ForecastState>(
                  buildWhen: (_, current) => current is! FetchingForecastState,
                  builder: (context, state) => switch (state) {
                    FetchingForecastState() => LoadingWidget(),
                    InitialCityState() => WelcomeWidget(
                        searching: _searching,
                        onTap: () => _startSearch(context),
                      ),
                    FetchedForecastState(
                      :final forecasts,
                      :final city,
                    ) =>
                      ForecastWidget(
                        city: city.name,
                        forecast: forecasts,
                        onTap: (city, forecast, dayForecast) =>
                            context.router.push(
                          ForecastRoute(
                            forecast: forecast,
                            city: city,
                            dayForecast: dayForecast,
                          ),
                        ),
                      ),
                    ErrorFetchingForecastState(:final error) => switch (error) {
                        NotFoundException(:final city) => NotFoundErrorWidget(
                            city,
                            searching: _searching,
                            onTap: () => _startSearch(context),
                          ),
                        InvalidAPIException() => InvalidAPIErrorWidget(
                            searching: _searching,
                            onTap: () => _startSearch(context)),
                        _ => GenericErrorWidget(
                            searching: _searching,
                            onTap: () => _startSearch(context),
                          ),
                      },
                    _ => const SizedBox.shrink(),
                  },
                ),
              false => NoInternetErrorWidget(
                  searching: _searching,
                  onTap: () => AppSettings.openAppSettings(
                    type: AppSettingsType.dataRoaming,
                  ),
                ),
            },
          );
        },
        child: const SizedBox.shrink(),
      );

  void _startSearch(BuildContext context) {
    ModalRoute.of(context)?.addLocalHistoryEntry(LocalHistoryEntry(
      onRemove: _toggleSearch,
    ));

    setState(() => _searching = true);
  }

  void _performSearch(BuildContext context) {
    if (!_form.valid) return;

    final city = _form.control(MainPage._kSearchForm).value as String;

    _toggleSearch();

    context.read<ForecastBloc>().performSearch(
          city,
          locale: Localizations.localeOf(context).languageCode,
        );
  }

  void _clearSearch() => _form.reset();

  void _toggleSearch() {
    _clearSearch();
    setState(() => _searching = !_searching);
  }
}
