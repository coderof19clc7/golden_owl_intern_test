import 'package:code/bloc/main_cubit.dart';
import 'package:code/data/shoes.dart';
import 'package:code/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartList extends StatelessWidget {
  const CartList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        final length = state.listInCart.length;
        if (length == 0) {
          return const Center(
            child: Text(
              'Your Cart is empty',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                bottom: 25,
              ),
              child: CartItem(
                shoes: state.listInCart[index],
                onDecreaseQuantity: () {
                  context.read<MainCubit>().onChangeQuantity(index, isDecrease: true);
                },
                onIncreaseQuantity: () {
                  context.read<MainCubit>().onChangeQuantity(index);
                },
                onRemoveItem: () {
                  context.read<MainCubit>().onRemoveItem(state.listInCart[index]);
                },
              ),
            );
          },
        );
      },
    );
  }
}
