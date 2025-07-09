import 'package:ecommerce_with_bloc/src/blocs/authentication/login_bloc.dart';
import 'package:ecommerce_with_bloc/src/blocs/blocs.dart';
import 'package:ecommerce_with_bloc/src/data/preference/local_preference.dart';
import 'package:ecommerce_with_bloc/src/presentation/widgets/brand_card.dart';
import 'package:ecommerce_with_bloc/src/presentation/widgets/custom_search_bar.dart';
import 'package:ecommerce_with_bloc/src/presentation/widgets/shimmer_effect.dart';
import 'package:ecommerce_with_bloc/src/routes/route_pages.dart';
import 'package:ecommerce_with_bloc/src/utils/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final layout = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is SignOutSuccess) {
                context.goNamed(Routes.LOGIN_ROUTE);
              }
              if (state is SignOutFailed) {
                Fluttertoast.showToast(msg: state.message);
              }
            },
            child: IconButton(
              onPressed: () => context.read<LoginBloc>().add(RequestSignOut()),
              icon: Icon(
                Icons.logout_rounded,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(
              '${Values.GREETINGS} ${LocalPreferences.getString('username')}',
            ),
            titleTextStyle: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            subtitle: Text("Welcome to laza"),
            subtitleTextStyle: Theme.of(context).textTheme.labelMedium,
          ),
          const CustomSearchBar(),
          const Gap(20),
          SizedBox(
            height: layout.width * 0.13,
            child: BlocBuilder<BrandBloc, BrandState>(
              builder: (context, state) {

                if (state is BrandFetchSuccess) {
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                         BrandCard(brandTitle: state.brands[index].brandName, brandLogo: state.brands[index].brandLogo),
                    separatorBuilder: (context, index) => const Gap(8.0),
                    itemCount: state.brands.length,
                  );
                } else {
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        ShimmerEffect.rectangular(width: 70, height: layout.width * 0.13),
                    separatorBuilder: (context, index) => const Gap(8.0),
                    itemCount: 10
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
