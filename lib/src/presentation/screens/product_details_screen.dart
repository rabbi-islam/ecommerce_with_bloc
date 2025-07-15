import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_with_bloc/src/data/model/product_model.dart';
import 'package:ecommerce_with_bloc/src/presentation/widgets/full_width_button.dart';
import 'package:ecommerce_with_bloc/src/presentation/widgets/product_review_card.dart';
import 'package:ecommerce_with_bloc/src/presentation/widgets/product_varient_category_item.dart';
import 'package:ecommerce_with_bloc/src/utils/asset_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:readmore/readmore.dart';

import '../../blocs/blocs.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final layout = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton.filled(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is SingleProductFetchSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //product Image
                  AspectRatio(
                    aspectRatio: 3 / 3,
                    child: CachedNetworkImage(
                      imageUrl:
                          state.product.imageGallery?.first.url ??
                          AssetManager.THUMBNAIL_PLACEHOLDER,
                      fit: BoxFit.cover,
                    ),
                  ),

                  //title & price bar
                  ListTile(
                    title: BlocBuilder<CategoryBloc, CategoryState>(
                      builder: (context, state) => Text(
                        state is CategoryFetchSuccess
                            ? state.category.title ?? ''
                            : 'No Category',
                      ),
                    ),
                    titleTextStyle: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                    subtitle: Text(
                      state.product.productName ?? "Unknown Product",
                    ),
                    subtitleTextStyle: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.onBackground,
                      fontWeight: FontWeight.bold,
                    ),
                    trailing: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Price',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.outline,
                          ),
                        ),
                        Text(
                          '\$${state.product.productPrice?.toStringAsFixed(2)}',
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.colorScheme.onBackground,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),

                  //image gallery
                  _buildProductImageGallery(
                    layout.size.width * 0.2,
                    state.product.imageGallery,
                  ),

                  //product varient gallery
                  _buildProductVarientGallery(state.product.varient),

                  //description
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onBackground,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        ReadMoreText(
                          state.product.productDetails ?? "No Details Found!",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.outline,
                          ),
                          textAlign: TextAlign.justify,
                          trimMode: TrimMode.Line,
                          trimLines: 2,
                          moreStyle: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.tertiary,
                          ),
                          lessStyle: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.tertiary,
                          ),
                          trimCollapsedText: 'Show More',
                          trimExpandedText: 'Show Less',
                        ),
                      ],
                    ),
                  ),

                  //product review
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Reviews',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onBackground,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'View All',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.outline,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Column(
                    children: [
                      ProductReviewCard(
                        name: 'Rabbi Islam',
                        date: '5th Oct 2025',
                        ratingPoint: 4.8,
                        review:
                            "It is a very good product, over all Very Good,",
                      ),
                      Gap(20),
                    ],
                  ),
                ],
              );
            } else if (state is ProductFetchFailed) {
              return Column(
                children: [
                  LottieBuilder.asset(AssetManager.ERROR_ANIM),
                  const Gap(20),
                  Text(
                    state.message,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            tileColor: theme.colorScheme.surfaceVariant,
            title: Text(
              'Total Price',
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              'with VAT,SD',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.outline,
                fontWeight: FontWeight.w300,
              ),
            ),
            trailing: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                final double vat = state is SingleProductFetchSuccess
                    ? state.product.vatSd ?? 0.0
                    : 0.0;
                debugPrint('Vat $vat');
                final double price = state is SingleProductFetchSuccess
                    ? state.product.productPrice ?? 0.0
                    : 0.0;
                final double totalPrice = vat + price;
                return Text(
                  '\$${totalPrice.toStringAsFixed(2)}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w900,
                  ),
                );
              },
            ),
          ),
          FullWidthButton(
            buttonText: "Add to Cart",
            textStyle: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductImageGallery(
    double height,
    List<ImageGallery>? imageGallery,
  ) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const Gap(10);
          }
          return AspectRatio(
            aspectRatio: 3 / 3,
            child: CachedNetworkImage(
              imageUrl:
                  imageGallery?[index].url ??
                  AssetManager.THUMBNAIL_PLACEHOLDER,
              fit: BoxFit.cover,
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Gap(10);
        },
        itemCount: imageGallery?.length ?? 0 + 1,
      ),
    );
  }

  Widget _buildProductVarientGallery(List<Varient>? varient) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children:
        List.generate(
            varient?.length ?? 0,
            (index)=> ProductVarientCategoryItem(title: varient?[index].category ?? '', items: varient?[index].items ?? [],)
        )

    );
  }
}
