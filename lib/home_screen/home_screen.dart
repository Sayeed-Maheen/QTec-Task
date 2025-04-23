import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qtec_task/constants/app_colors.dart';
import 'package:qtec_task/constants/app_icons_path.dart';
import 'package:qtec_task/widgets/icon_widget/icon_widget.dart';
import 'package:qtec_task/widgets/space_widget/space_widget.dart';
import 'package:qtec_task/widgets/text_widget/text_widgets.dart';

import '../widgets/app_image/app_image.dart';
import 'controller/product_controller.dart';

class HomeScreen extends StatelessWidget {
  final ProductController _controller = Get.put(ProductController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(title: const Text("All Products")),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (_controller.productList.isEmpty) {
          return const Center(child: Text("No products available."));
        }
        return LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 3.5,
                    children: List.generate(_controller.productList.length, (
                      index,
                    ) {
                      final product = _controller.productList[index];
                      return SizedBox(
                        width: constraints.maxWidth / 2 - 24, // Adjust width
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppImage(
                              url: product.image,
                              width: constraints.maxWidth / 2 - 24,
                              // Adjust width
                              height: constraints.maxWidth / 2 - 24,
                              // Adjust height
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
                                  fontColor: AppColors.black.withOpacity(0.5),
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: AppColors.black.withOpacity(
                                    0.5,
                                  ),
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
                    }),
                  ),
                  const SpaceWidget(spaceHeight: 20),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
