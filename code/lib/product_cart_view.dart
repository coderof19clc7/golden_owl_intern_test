import 'package:code/constants/dimens.dart';
import 'package:code/widgets/product_cart_card_container.dart';
import 'package:flutter/material.dart';

class ProductCartView extends StatelessWidget {
  const ProductCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Dimens.getScreenWidth(context),
      height: Dimens.getScreenHeight(context),
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            constraints: const BoxConstraints(
              maxWidth: 760,
            ),
            width: Dimens.getScreenWidth(context),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 30,
              runSpacing: 20,
              children: [
                ProductCartCardContainer(
                  child: Container(),
                ),
                ProductCartCardContainer(
                  totalPrice: 3656336563.39,
                  child: Container(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
