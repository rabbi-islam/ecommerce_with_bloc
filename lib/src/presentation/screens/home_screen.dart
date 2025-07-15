import 'package:ecommerce_with_bloc/src/blocs/authentication/login_bloc.dart';
import 'package:ecommerce_with_bloc/src/blocs/blocs.dart';
import 'package:ecommerce_with_bloc/src/data/preference/local_preference.dart';
import 'package:ecommerce_with_bloc/src/presentation/widgets/brand_card.dart';
import 'package:ecommerce_with_bloc/src/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:ecommerce_with_bloc/src/presentation/widgets/custom_search_bar.dart';
import 'package:ecommerce_with_bloc/src/presentation/widgets/product_card.dart';
import 'package:ecommerce_with_bloc/src/presentation/widgets/shimmer_effect.dart';
import 'package:ecommerce_with_bloc/src/routes/route_pages.dart';
import 'package:ecommerce_with_bloc/src/utils/asset_manager.dart';
import 'package:ecommerce_with_bloc/src/utils/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final layout = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const Drawer(),
      body: SafeArea(
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, isScrollable) => [
            SliverAppBar(
              floating: true,
              leading: IconButton.filled(
                onPressed: () {},
                icon: SvgPicture.asset(AssetManager.MENU_ICON),
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    theme.colorScheme.surfaceVariant,
                  ),
                ),
              ),
              actions: [
                IconButton.filled(
                  onPressed: () {},
                  icon: SvgPicture.asset(AssetManager.CART_ICON),
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      theme.colorScheme.surfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      '${Values.GREETINGS} ${LocalPreferences.getString('username')}',
                    ),
                    titleTextStyle: Theme.of(context).textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                    subtitle: Text("Welcome to laza"),
                    subtitleTextStyle: Theme.of(context).textTheme.labelMedium,
                  ),

                  const CustomSearchBar(),
                  const Gap(20),

                  //brand chip
                  SizedBox(
                    height: layout.width * 0.13,
                    child: BlocBuilder<BrandBloc, BrandState>(
                      builder: (context, state) {
                        if (state is BrandFetchSuccess) {
                          return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final brand = state.brands[index];
                              return Padding(
                                padding: EdgeInsets.only(
                                  left: index == 0
                                      ? MediaQuery.of(context).size.width * 0.04
                                      : 0,
                                ),
                                child: BrandCard(
                                  brandTitle: brand.brandName,
                                  brandLogo: brand.brandLogo,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const Gap(8.0),
                            itemCount: state.brands.length,
                          );
                        } else {
                          return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) =>
                                ShimmerEffect.rectangular(
                                  width: 70,
                                  height: layout.width * 0.13,
                                ),
                            separatorBuilder: (context, index) =>
                                const Gap(8.0),
                            itemCount: 10,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              const SliverToBoxAdapter(child: Gap(20)),
              SliverToBoxAdapter(
                child: ListTile(
                  title: const Text('New Arrival'),
                  titleTextStyle: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  trailing: Text('View All', style: theme.textTheme.labelSmall),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: layout.width * 0.04),
                sliver: BlocBuilder<ProductBloc, ProductState>(
                    builder: (context,state){
                  if(state is ProductFetchSuccess){
                    return SliverGrid.builder(
                      itemCount: state.productList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        mainAxisExtent: layout.width * 0.6,
                      ),
                      itemBuilder: (context, index) => ProductCard(
                        onItemTap: (){
                          context.read<ProductBloc>().add(
                              FetchSingleProduct(state.productList[index].productId)
                          );
                          context.read<CategoryBloc>().add(
                              FetchSingleCategory(state.productList[index].categoryId ?? "")
                          );
                          context.pushNamed(Routes.PRODUCT_DETAILS_ROUTE);
                        },
                        productName: state.productList[index].productName?? "Unknown Product",
                        productPrice: state.productList[index].productPrice,
                        productThumbnail: state.productList[index].imageGallery?.first.url,
                      ),
                    );
                  }else{
                        return SliverToBoxAdapter(
                          child: Center(
                            child: LoadingAnimationWidget.hexagonDots(
                                color: theme.colorScheme.primary, size: 35.w
                            ),
                          ),
                        );
                  }
                })
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
