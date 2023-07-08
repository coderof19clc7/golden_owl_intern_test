import 'package:code/bloc/main_cubit.dart';
import 'package:code/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartList extends StatefulWidget {
  const CartList({super.key});

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  late final GlobalKey<AnimatedListState> _listState;

  @override
  void initState() {
    super.initState();
    _listState = GlobalKey<AnimatedListState>();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MainCubit, MainState>(
          listenWhen: (previous, current) {
            return previous.newItemAdded != current.newItemAdded;
          },
          listener: (context, state) {
            if (state.newItemAdded) {
              _listState.currentState?.insertItem(state.listInCart.length - 1);
              context.read<MainCubit>().emitState(state.copyWith(newItemAdded: false));
            }
          },
        ),
        BlocListener<MainCubit, MainState>(
          listenWhen: (previous, current) => previous.removedItemIndex != current.removedItemIndex,
          listener: (context, state) {
            if (state.removedItemIndex != -1) {
              _listState.currentState?.removeItem(
                state.removedItemIndex,
                (context, animation) {
                  return ScaleTransition(
                    scale: animation.drive(
                      Tween<double>(begin: 0.0, end: 1.0).chain(
                        CurveTween(curve: Curves.fastOutSlowIn),
                      ),
                    ),
                    child: CartItem(
                      shoes: state.removedItem!,
                      onRemoveItem: () {},
                    ),
                  );
                },
                duration: Duration(
                  milliseconds: context.read<MainCubit>().removeItemDuration,
                ),
              );
            }
          },
        ),
      ],
      child: BlocBuilder<MainCubit, MainState>(
        buildWhen: (previous, current) {
          return previous.listInCart != current.listInCart;
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final length = state.listInCart.length;
          return Stack(
            children: [
              AnimatedOpacity(
                opacity: length > 0 ? 0 : 1,
                duration: Duration(
                  milliseconds: context.read<MainCubit>().removeItemDuration,
                ),
                child: const Center(
                  child: Text(
                    'Your Cart is empty',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),

              AnimatedList(
                key: _listState,
                initialItemCount: length,
                itemBuilder: (context, index, animation) {
                  return CartItem(
                    shoes: state.listInCart[index],
                    animation: animation,
                    onDecreaseQuantity: () {
                      context.read<MainCubit>().onChangeQuantity(index, isDecrease: true);
                    },
                    onIncreaseQuantity: () {
                      context.read<MainCubit>().onChangeQuantity(index);
                    },
                    onRemoveItem: () {
                      context.read<MainCubit>().onRemoveItem(index);
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
