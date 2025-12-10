import 'package:aorta/core/navigation/auto_router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SendMoneyRoute.page, initial: true),
    AutoRoute(page: TransactionHistoryRoute.page),
  ];
  @override
  late final List<AutoRouteGuard> guards = [
    AutoRouteGuard.simple((resolver, router) {
      // if(false || resolver.routeName == LoginRoute.name) {
      //   // we continue navigation
      //   resolver.next();
      // } else {
      //   // else we navigate to the Login page so we get authenticated
      //
      //   // tip: use resolver.redirectUntil to have the redirected route
      //   // automatically removed from the stack when the resolver is completed
      //   resolver.redirectUntil(LoginRoute(onResult: (didLogin) => resolver.next(didLogin)));
      // }
      resolver.next();
    }),
    // add more guards here
  ];
}
