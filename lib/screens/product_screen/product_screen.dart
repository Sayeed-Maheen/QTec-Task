import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qtec_task/constants/app_colors.dart';
import 'package:qtec_task/screens/product_screen/widgets/product_card.dart';
import 'package:qtec_task/widgets/icon_button_widget/icon_button_widget.dart';
import 'package:qtec_task/widgets/space_widget/space_widget.dart';
import 'package:qtec_task/widgets/text_button_widget/text_button_widget.dart';
import '../../constants/app_icons_path.dart';
import '../../widgets/text_field_widget/text_field_widget.dart';
import '../../widgets/text_widget/text_widgets.dart';
import 'controller/product_controller.dart';

class ProductScreen extends StatelessWidget {
  final ProductController _controller = Get.put(ProductController());

  ProductScreen({super.key});

  /// Shows a bottom sheet with filter options.
  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 24,
            top: 24,
            right: 8,
            bottom: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextWidget(
                    text: 'Sort By',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontColor: AppColors.black,
                  ),
                  CloseButton(
                    color: AppColors.black,
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SpaceWidget(spaceHeight: 16),
              TextButtonWidget(
                onPressed: () {
                  _controller.updateFilterOption(FilterOption.priceHighToLow);
                  Navigator.pop(context);
                },
                text: "Price - High to Low",
                textColor: AppColors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              const SpaceWidget(spaceHeight: 8),
              TextButtonWidget(
                onPressed: () {
                  _controller.updateFilterOption(FilterOption.priceLowToHigh);
                  Navigator.pop(context);
                },
                text: "Price - Low to High",
                textColor: AppColors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Obx(() {
          print(
            'UI rebuilding with filteredList length: ${_controller.filteredList.length}',
          );
          if (_controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return RefreshIndicator(
            onRefresh: () async {
              print('Pull-to-refresh triggered');
              await _controller.fetchProducts(isRefresh: true);
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  controller: _controller.scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      SpaceWidget(spaceHeight: 24),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: TextFieldWidget(
                                controller: _controller.searchController,
                                hintText: "Search Anything...",
                                maxLines: 1,
                                onChanged: _controller.updateSearchQuery,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: IconButtonWidget(
                              icon: AppIconsPath.filterIcon,
                              size: 40,
                              color: AppColors.black,
                              onTap: () => _showFilterBottomSheet(context),
                            ),
                          ),
                        ],
                      ),
                      SpaceWidget(spaceHeight: 24),
                      if (_controller.filteredList.isEmpty)
                        const Center(
                          child: Text(
                            "No products found.",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      else
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio: 2 / 3.5,
                              ),
                          itemCount: _controller.filteredList.length,
                          itemBuilder: (context, index) {
                            final product = _controller.filteredList[index];
                            print(
                              'Rendering product at index $index: ${product.title}',
                            );
                            return ProductCard(
                              imageUrl: product.image ?? "No image",
                              title: product.title ?? "No title",
                              price: product.price!,
                              originalPrice: 400.00,
                              discountPercentage: 30,
                              rating: 4.3,
                              reviewCount: 41,
                            );
                          },
                        ),
                      if (_controller.isFetchingMore.value)
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CircularProgressIndicator(),
                        ),
                      if (_controller.hasReachedEnd.value &&
                          _controller.filteredList.isNotEmpty)
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "No more products available.",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      const SpaceWidget(spaceHeight: 20),
                    ],
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
