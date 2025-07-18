import 'package:ecommerce_with_bloc/src/blocs/blocs.dart';
import 'package:ecommerce_with_bloc/src/data/repository/repository.dart';
import 'package:ecommerce_with_bloc/src/routes/route_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'theme/theme.dart';

class BlocEcommerceApp extends StatelessWidget {
  const BlocEcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context)=>AuthRepository()),
        RepositoryProvider(create: (context)=>StoreRepository()),
        RepositoryProvider(create: (context)=>ProductRepository())
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) =>
          SplashCubit()
            ..startSplash()),
          BlocProvider(create: (context) => RememberSwitchCubit()),
          BlocProvider(create: (context) => LoginBloc(context.read<AuthRepository>())),
          BlocProvider(create: (context) => SignupBloc(context.read<AuthRepository>())),
          BlocProvider(create: (context) => BrandBloc(context.read<StoreRepository>())..add(FetchBrands())),
          BlocProvider(create: (context) => ProductBloc(context.read<ProductRepository>())..add(FetchProduct())),
          BlocProvider(create: (context) => CategoryBloc(context.read<StoreRepository>())),
        ],
        child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return MaterialApp.router(
              theme: const MaterialTheme(TextTheme()).light(),
              darkTheme: const MaterialTheme(TextTheme()).dark(),
              debugShowCheckedModeBanner: false,
              routerConfig: RoutePages.ROUTER,
            );
          },
        ),
      ),
    );
  }
}
