import 'package:code/constants/colors.dart';
import 'package:code/constants/dimens.dart';
import 'package:code/constants/fonts.dart';
import 'package:code/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class ProductCartCardContainer extends StatelessWidget {
  const ProductCartCardContainer({
    super.key, this.totalPrice, required this.child,
  });

  final double? totalPrice;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    const decorSize = 300.0;
    return LayoutBuilder(
      builder: (context, constraint) {
        var width = 360.0;
        var height = 600.0;
        var padding = 28.0;
        if (constraint.maxWidth <= 340) {
          width = 300.0;
          height = 480.0;
          padding = 14.0;
        } else if (constraint.maxWidth <= 480) {
          width = 340.0;
        }

        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Stack(
              children: [
                Positioned(
                  top: -decorSize / 2,
                  left: -decorSize / 2,
                  child: Container(
                    width: decorSize,
                    height: decorSize,
                    decoration: BoxDecoration(
                      color: AppColors.yellow,
                      borderRadius: BorderRadius.circular(decorSize),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: padding),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      Assets.images.nike.image(
                        width: 50,
                        height: 26,
                      ),

                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 3,
                            child: Text(
                              totalPrice == null ? 'Our Products' : 'Your cart',
                              style: AppFonts.boldTextStyle.copyWith(
                                fontSize: 24,
                              ),
                            ),
                          ),

                          if (totalPrice != null)
                            Flexible(
                              flex: 4,
                              child: Text(
                                '\$${totalPrice!.toStringAsFixed(2)}',
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                                style: AppFonts.boldTextStyle.copyWith(
                                  fontSize: 24,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      Expanded(
                        child: child,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
