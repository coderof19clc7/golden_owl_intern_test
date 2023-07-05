import 'package:code/bloc/main_cubit.dart';
import 'package:code/constants/dimens.dart';
import 'package:code/widgets/cart_list.dart';
import 'package:code/widgets/product_cart_card_container.dart';
import 'package:code/widgets/products_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCartView extends StatelessWidget {
  const ProductCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child: SizedBox(
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
                  const ProductCartCardContainer(
                    child: ProductsList(),
                  ),

                  BlocBuilder<MainCubit, MainState>(
                    buildWhen: (previous, current) {
                      return previous.totalPrice != current.totalPrice;
                    },
                    builder: (context, state) {
                      return ProductCartCardContainer(
                        totalPrice: state.totalPrice,
                        child: const CartList(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
