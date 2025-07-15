import 'package:ecommerce_with_bloc/src/data/services/auth_services.dart';
import 'package:ecommerce_with_bloc/src/routes/routes_observer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../presentation/screens/product_details_screen.dart';
import '../presentation/screens/screens.dart';
import '../presentation/screens/wrapper.dart';

part 'routes.dart';

class RoutePages {
  static final authService = AuthService();

  static final ROUTER = GoRouter(
    observers: [RouteLogger()],
    redirect: (context, state) {
      debugPrint("Redirect triggered to: ${state.fullPath}");
      if (authService.checkLoginStatus()) {
        if (state.fullPath == Routes.LOGIN_ROUTE ||
            state.fullPath == Routes.REGISTER_ROUTE ||
            state.fullPath == Routes.WELCOME_ROUTE) {
          return Routes.HOME_ROUTE;
        } else {
          return state.fullPath;
        }
      } else {
        if (state.fullPath == Routes.LOGIN_ROUTE ||
            state.fullPath == Routes.REGISTER_ROUTE) {
          return state.fullPath;
        }
        return Routes.WELCOME_ROUTE;
      }
    },

    routes: [
      GoRoute(
        path: Routes.SPLASH_ROUTE,
        name: Routes.SPLASH_ROUTE,
        pageBuilder: (context, state) =>
            const MaterialPage(child: SplashScreen()),
      ),
      GoRoute(
        path: Routes.WELCOME_ROUTE,
        name: Routes.WELCOME_ROUTE,
        pageBuilder: (context, state) =>
            const MaterialPage(child: WelcomeScreen()),
      ),
      GoRoute(
        path: Routes.LOGIN_ROUTE,
        name: Routes.LOGIN_ROUTE,
        pageBuilder: (context, state) =>
            const MaterialPage(child: LoginScreen()),
      ),
      GoRoute(
        path: Routes.REGISTER_ROUTE,
        name: Routes.REGISTER_ROUTE,
        pageBuilder: (context, state) =>
            const MaterialPage(child: SignupScreen()),
      ),
      GoRoute(
          path: Routes.PRODUCT_DETAILS_ROUTE,
          name: Routes.PRODUCT_DETAILS_ROUTE,
          pageBuilder: (context, state) =>
          const MaterialPage(child: ProductDetailsScreen())),
      ShellRoute(
        builder: (context, state, child) => Wrapper(child: child),
        routes: [
          GoRoute(
            path: Routes.HOME_ROUTE,
            name: Routes.HOME_ROUTE,
            pageBuilder: (context, state) =>
                const MaterialPage(child: HomeScreen()),
          ),
        ],
      ),
    ],
  );
}
