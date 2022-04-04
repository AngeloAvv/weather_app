import 'package:app_settings/app_settings.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weather/blocs/forecast/forecast_bloc.dart';
import 'package:weather/cubits/search_cubit.dart';
import 'package:weather/routers/app_router.gr.dart';
import 'package:weather/widgets/error_widget.dart' as e;
import 'package:weather/widgets/forecast_widget.dart';
import 'package:weather/widgets/welcome_widget.dart';

/// The MainPage widget page
class MainPage extends StatelessWidget with AutoRouteWrapper {
  /// The MainPage constructor
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SearchCubit(
              logger: context.read(),
            ),
          ),
          BlocProvider(
            create: (context) => ForecastBloc(
              repository: context.read(),
              connectivity: context.read(),
              logger: context.read(),
            ),
          ),
        ],
        child: this,
      );

  @override
  Widget build(BuildContext context) => BlocBuilder<SearchCubit, bool>(
        builder: (context, isSearching) => Scaffold(
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: isSearching ? 1 : 0,
            title: isSearching ? _searchField(context) : null,
            automaticallyImplyLeading: isSearching,
            actions: isSearching
                ? _searchActions(context)
                : _defaultActions(context),
          ),
          body: _body(),
        ),
      );

  Widget _searchField(BuildContext context) => TextField(
        autofocus: true,
        controller: context.watch<SearchCubit>().searchController,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: AppLocalizations.of(context)?.hint_search ?? '',
        ),
        onChanged: context.watch<SearchCubit>().updateSearchValue,
        onSubmitted: (value) {
          context.read<ForecastBloc>().performSearch(value,
              locale: Localizations.localeOf(context).languageCode);
          context.read<SearchCubit>().toggleSearch();
        },
      );

  List<Widget> _defaultActions(BuildContext context) => [
        BlocBuilder<ForecastBloc, ForecastState>(
          builder: (context, state) => state.maybeWhen(
            fetchingForecastState: () => IconButton(
              onPressed: null,
              icon: SizedBox.fromSize(
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                size: const Size(24, 24),
              ),
            ),
            orElse: () => IconButton(
              icon: const Icon(Icons.search),
              tooltip: AppLocalizations.of(context)?.tooltip_search ?? '',
              onPressed: () => _startSearch(context),
            ),
          ),
        ),
      ];

  List<Widget> _searchActions(BuildContext context) => [
        StreamBuilder<String>(
          stream: context.watch<SearchCubit>().searchStream,
          builder: (context, snapshot) => IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                Navigator.pop(context);
                return;
              }
              context.read<SearchCubit>().cleanSearch();
            },
          ),
        )
      ];

  Widget _body() => BlocBuilder<ForecastBloc, ForecastState>(
        buildWhen: (_, current) => current is! FetchingForecastState,
        builder: (context, state) => state.when(
          undefinedCityState: () =>
              WelcomeWidget(onTap: () => _startSearch(context)),
          fetchedForecastState: (response) => ForecastWidget(
            city: response.city.name,
            forecast: response.forecast,
            onTap: (city, forecast, dayForecast) => context.router.push(
              ForecastRoute(
                forecast: forecast,
                city: city,
                dayForecast: dayForecast,
              ),
            ),
          ),
          fetchingForecastState: _progressIndicator,
          notFoundErrorForecastState: (city) =>
              e.ErrorWidget.notFound(city, onTap: () => _startSearch(context)),
          invalidAPITokenErrorForecastState: () =>
              e.ErrorWidget.invalidAPIToken(onTap: () => _startSearch(context)),
          noInternetErrorForecastState: () => e.ErrorWidget.noInternet(
              onTap: () => AppSettings.openDataRoamingSettings()),
          emptyCityErrorForecastState: () =>
              e.ErrorWidget.emptyCity(onTap: () => _startSearch(context)),
          errorForecastState: (_) => e.ErrorWidget(
            onTap: () => _startSearch(context),
          ),
        ),
      );

  Widget _progressIndicator() =>
      const Center(child: CircularProgressIndicator());

  void _startSearch(BuildContext context) {
    ModalRoute.of(context)?.addLocalHistoryEntry(
      LocalHistoryEntry(onRemove: context.read<SearchCubit>().toggleSearch),
    );

    context.read<SearchCubit>().toggleSearch();
  }
}
