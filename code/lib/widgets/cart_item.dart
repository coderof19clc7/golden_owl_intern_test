import 'package:code/constants/colors.dart';
import 'package:code/constants/fonts.dart';
import 'package:code/data/shoes.dart';
import 'package:code/gen/assets.gen.dart';
import 'package:code/widgets/product_image.dart';
import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.shoes,
    this.onDecreaseQuantity,
    this.onIncreaseQuantity,
    this.onRemoveItem,
  });

  final Shoes shoes;
  final Function()? onDecreaseQuantity;
  final Function()? onIncreaseQuantity;
  final Function()? onRemoveItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProductImage(
          height: 90,
          width: 90,
          bgWidth: 90,
          bgHeight: 90,
          imageAlignment: Alignment.topCenter,
          isCircle: true,
          url: shoes.image,
          color: shoes.color,
        ),
        const SizedBox(width: 20),

        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      shoes.name ?? '',
                      style: AppFonts.boldTextStyle.copyWith(fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Text(
                "\$${shoes.price ?? 0}",
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                style: AppFonts.boldTextStyle.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Flexible(
                          child: buildMinusPlusBtn(
                            onTap: onDecreaseQuantity,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${shoes.quantity}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(width: 8),

                        Flexible(
                          child: buildMinusPlusBtn(
                            isMinus: false,
                            onTap: onIncreaseQuantity,
                          ),
                        ),
                      ],
                    )
                  ),

                  ElevatedButton(
                    onPressed: onRemoveItem,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.white,
                      backgroundColor: AppColors.yellow,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(8),
                    ),
                    child: Assets.images.trash.image(
                      width: 17,
                      height: 17,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildMinusPlusBtn({ bool isMinus = true, Function()? onTap }) {
    const btnSize = 10.0;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: AppColors.lightGray,
            shape: BoxShape.circle,
          ),
          child: isMinus
              ? Assets.images.minus.image(
            width: btnSize,
            height: btnSize,
          )
              : Assets.images.plus.image(
            width: btnSize,
            height: btnSize,
          ),
        ),
      ),
    );
  }
}
