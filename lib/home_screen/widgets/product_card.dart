import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_icons_path.dart';
import '../../utils/app_size.dart';
import '../../widgets/app_image/app_image.dart';
import '../../widgets/icon_widget/icon_widget.dart';
import '../../widgets/space_widget/space_widget.dart';
import '../../widgets/text_widget/text_widgets.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double price;
  final double originalPrice;
  final int discountPercentage;
  final double rating;
  final int reviewCount;

  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.originalPrice,
    required this.discountPercentage,
    required this.rating,
    required this.reviewCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth / 2 - 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppImage(
                url: imageUrl,
                width: ResponsiveUtils.width(150),
                height: ResponsiveUtils.width(150),
                fit: BoxFit.contain,
              ),
              SpaceWidget(spaceHeight: 8),
              Flexible(
                child: TextWidget(
                  text: title,
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
                    text: "\$${price.toStringAsFixed(2)}",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontColor: AppColors.black,
                  ),
                  const SpaceWidget(spaceWidth: 4),
                  TextWidget(
                    text: "\$${originalPrice.toStringAsFixed(2)}",
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    fontColor: AppColors.black.withOpacity(0.5),
                    decoration: TextDecoration.lineThrough,
                    decorationColor: AppColors.black.withOpacity(0.5),
                  ),
                  const SpaceWidget(spaceWidth: 4),
                  TextWidget(
                    text: "$discountPercentage% OFF",
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
                    text: rating.toString(),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    fontColor: AppColors.black,
                  ),
                  const SpaceWidget(spaceWidth: 4),
                  TextWidget(
                    text: "($reviewCount)",
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
    );
  }
}

// Example usage:
// ProductCard(
//   imageUrl: "https://example.com/image.jpg",
//   title: "Product Title",
//   price: 280.00,
//   originalPrice: 400.00,
//   discountPercentage: 30,
//   rating: 4.3,
//   reviewCount: 41,
// )
