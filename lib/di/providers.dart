part of 'dependency_injector.dart';

final List<SingleChildWidget> _providers = [
  Provider<Talker>(
    create: (context) => Talker(),
  ),
  Provider(
    create: (context) {
      final dio = Dio();

      dio.interceptors.addAll([
        if (kDebugMode) ...[
          TalkerDioLogger(
            talker: context.read(),
            settings: const TalkerDioLoggerSettings(
              printRequestHeaders: true,
              printResponseHeaders: true,
            ),
          ),
          CurlLoggerDioInterceptor(
            printOnSuccess: true,
          ),
        ],
      ]);

      return dio;
    },
  ),
  Provider<RestClient>(
    create: (context) => RestClient(context.read()),
  ),
];
