import 'package:code/bloc/main_cubit.dart';
import 'package:code/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.listProducts.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                bottom: 25,
              ),
              child: ProductItem(
                shoes: state.listProducts[index],
                onAddToCartTab: () {
                  context.read<MainCubit>().onAddToCart(state.listProducts[index]);
                },
              ),
            );
          },
        );
      },
    );
  }
}
