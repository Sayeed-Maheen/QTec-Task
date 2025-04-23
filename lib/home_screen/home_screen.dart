import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qtec_task/constants/app_colors.dart';
import 'package:qtec_task/widgets/space_widget/space_widget.dart';

import '../constants/app_icons_path.dart';
import '../widgets/app_image/app_image.dart';
import '../widgets/icon_widget/icon_widget.dart';
import '../widgets/text_field_widget/text_field_widget.dart';
import '../widgets/text_widget/text_widgets.dart';
import 'controller/product_controller.dart';

class HomeScreen extends StatelessWidget {
  final ProductController _controller = Get.put(ProductController());

  HomeScreen({super.key});

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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFieldWidget(
                          controller: _controller.searchController,
                          hintText: "Search Anything...",
                          maxLines: 1,
                          onChanged:
                              _controller
                                  .updateSearchQuery, // Direct update to searchQuery
                        ),
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
                            return SizedBox(
                              width: constraints.maxWidth / 2 - 24,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppImage(
                                    url: product.image,
                                    width: constraints.maxWidth / 2 - 24,
                                    height: constraints.maxWidth / 2 - 24,
                                    fit: BoxFit.contain,
                                  ),
                                  SpaceWidget(spaceHeight: 8),
                                  Flexible(
                                    child: TextWidget(
                                      text: product.title ?? "No Title",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      fontColor: AppColors.black,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlignment: TextAlign.start,
                                    ),
                                  ),
                                  SpaceWidget(spaceHeight: 8),
                                  Row(
                                    children: [
                                      TextWidget(
                                        text:
                                            "\$${product.price?.toStringAsFixed(2) ?? "0.00"}",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        fontColor: AppColors.black,
                                      ),
                                      const SpaceWidget(spaceWidth: 4),
                                      TextWidget(
                                        text: "\$400",
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        fontColor: AppColors.black.withOpacity(
                                          0.5,
                                        ),
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor: AppColors.black
                                            .withOpacity(0.5),
                                      ),
                                      const SpaceWidget(spaceWidth: 4),
                                      TextWidget(
                                        text: "30% OFF",
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        fontColor: AppColors.orange600,
                                      ),
                                    ],
                                  ),
                                  SpaceWidget(spaceHeight: 8),
                                  Row(
                                    children: [
                                      IconWidget(
                                        height: 16,
                                        width: 16,
                                        icon: AppIconsPath.ratingIcon,
                                      ),
                                      const SpaceWidget(spaceWidth: 4),
                                      TextWidget(
                                        text: "4.3",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        fontColor: AppColors.black,
                                      ),
                                      const SpaceWidget(spaceWidth: 4),
                                      TextWidget(
                                        text: "(41)",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        fontColor: AppColors.grey500,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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
