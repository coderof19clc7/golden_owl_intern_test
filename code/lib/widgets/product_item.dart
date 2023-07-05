import 'package:code/constants/colors.dart';
import 'package:code/constants/fonts.dart';
import 'package:code/data/shoes.dart';
import 'package:code/gen/assets.gen.dart';
import 'package:code/widgets/product_image.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key, required this.shoes, this.onAddToCartTab,
  });

  final Shoes shoes;
  final Function()? onAddToCartTab;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductImage(
          height: 380,
          padding: const EdgeInsets.only(right: 16),
          url: shoes.image,
          color: shoes.color,
        ),
        const SizedBox(height: 20),

        Text(
          shoes.name ?? '',
          style: AppFonts.boldTextStyle.copyWith(fontSize: 20),
        ),
        const SizedBox(height: 20),

        Text(
          shoes.description ?? '',
          style: const TextStyle(fontSize: 13, color: AppColors.black),
        ),
        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "\$${shoes.price ?? 0}",
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                style: AppFonts.boldTextStyle.copyWith(fontSize: 18),
              ),
            ),

            if (shoes.isInCart)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.yellow,
                  shape: BoxShape.circle,
                ),
                child: Assets.images.check.image(
                  width: 20,
                  height: 20,
                ),
              )
            else
              ElevatedButton(
                onPressed: onAddToCartTab,
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.white,
                  backgroundColor: AppColors.yellow,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                ),
                child: Text(
                  "Add to cart",
                  style: AppFonts.boldTextStyle.copyWith(fontSize: 14),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
