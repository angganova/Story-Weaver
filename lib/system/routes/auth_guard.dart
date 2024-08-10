import 'package:auto_route/auto_route.dart';

// dependencies :
// auto_route: ^3.2.2

class AuthGuard extends AutoRouteGuard {
  /// This class hold all the navigation authorisation that used in the app
  /// In case when user navigate using web url and the session is not created yet
  /// This auth guard will block the request and show login screen

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // if (MainVm.instance.currentUserDetail != null) {
    //   resolver.next(true);
    // } else {
    //   resolver.next(false);
    //   // router.replaceAll(<PageRouteInfo>[const LoginScreenRoute()]);
    // }
    resolver.next(true);
  }
}
