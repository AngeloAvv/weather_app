part of 'dependency_injector.dart';

class _Providers extends StatelessWidget {
  final Widget child;

  const _Providers({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<Logger>(
            create: (_) => Logger(),
          ),
          Provider<Connectivity>(
            create: (_) => Connectivity(),
          ),
          Provider(
            create: (context) {
              final dio = Dio();

              dio.interceptors.addAll([
                if (kDebugMode)
                  PrettyDioLogger(
                    requestHeader: true,
                    requestBody: true,
                    responseBody: true,
                    responseHeader: false,
                    error: true,
                    compact: true,
                  ),
              ]);

              return dio;
            },
          ),
          Provider<RestClient>(
            create: (context) => RestClient(context.read()),
          ),
        ],
        child: child,
      );
}
