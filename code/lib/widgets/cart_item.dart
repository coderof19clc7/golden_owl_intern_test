import 'package:code/constants/colors.dart';
import 'package:code/constants/fonts.dart';
import 'package:code/data/shoes.dart';
import 'package:code/gen/assets.gen.dart';
import 'package:code/widgets/product_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.shoes,
    this.animation = const AlwaysStoppedAnimation(1.0),
    this.onDecreaseQuantity,
    this.onIncreaseQuantity,
    this.onRemoveItem,
  });

  final Shoes shoes;
  final Animation<double> animation;
  final Function()? onDecreaseQuantity;
  final Function()? onIncreaseQuantity;
  final Function()? onRemoveItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Row(
        children: [
          buildWidget(
            isImage: true,
            child: ProductImage(
              bgWidth: 90,
              bgHeight: 90,
              imageTop: -35,
              imageLeft: -18,
              imageWidth: 90 * 1.4,
              imageAlignment: Alignment.topCenter,
              isCircle: true,
              rotateDeg: -180/28,
              clipBehavior: Clip.none,
              url: shoes.image,
              color: shoes.color,
            ),
          ),
          const SizedBox(width: 29),

          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildWidget(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          shoes.name ?? '',
                          style: AppFonts.boldTextStyle.copyWith(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                buildWidget(
                  bonusDelay: 200,
                  child: Text(
                    "\$${shoes.price ?? 0}",
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: AppFonts.boldTextStyle.copyWith(fontSize: 20),
                  ),
                ),
                const SizedBox(height: 16),

                buildWidget(
                  needSlide: false,
                  fadeDuration: 700,
                  bonusDelay: 400,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              flex: 2,
                              child: buildMinusPlusBtn(
                                onTap: onDecreaseQuantity,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                '${shoes.quantity}',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                            const SizedBox(width: 8),

                            Flexible(
                              flex: 2,
                              child: buildMinusPlusBtn(
                                isMinus: false,
                                onTap: onIncreaseQuantity,
                              ),
                            ),
                          ],
                        )
                      ),

                      Flexible(
                        child: ElevatedButton(
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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

  Widget buildWidget({
    bool isImage = false,
    bool needSlide = true,
    int fadeDuration = 1000,
    int bonusDelay = 0,
    required Widget child,
  }) {
    if (animation.value == 1) {
      return child;
    }

    final listEffects = <Effect>[];
    if (isImage) {
      listEffects.add(
        const ScaleEffect(
          duration: Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
        ),
      );
    } else {
      listEffects.add(
        FadeEffect(
          duration: Duration(milliseconds: fadeDuration),
          delay: Duration(milliseconds: 500 + bonusDelay),
          curve: Curves.easeInOut,
          begin: 0,
          end: 1,
        ),
      );
      if (needSlide) {
        listEffects.add(
          const SlideEffect(
            duration: Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            begin: Offset(1, 0),
            end: Offset(0, 0),
          ),
        );
      }
    }

    return  Animate(
      effects: listEffects,
      child: child,
    );
  }
}
