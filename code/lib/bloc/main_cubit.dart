import 'dart:convert';

import 'package:code/constants/locals.dart';
import 'package:code/data/shoes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(const MainState(isLoading: true)) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // get data
      final listProducts = getListProducts();

      // init shared preferences and get list shoes in cart
      prefs = await SharedPreferences.getInstance();
      final totalPrice = prefs!.getDouble(StringConstants.totalPriceKey) ?? 0;
      final listShoesInCart = getListProductsInCart();

      // check any shoes in cart
      final length = listShoesInCart.length;
      for (var i = 0; i < length; i++) {
        final shoesInCart = listShoesInCart[i];
        final index = listProducts.indexWhere((e) => e.id == shoesInCart.id);
        if (index != -1) {
          if (shoesInCart.quantity > 0) {
            listProducts[index] = listProducts[index].copyWith(
              isInCart: true,
            );
          }
        }
      }

      emitState(state.copyWith(
        isLoading: false,
        listProducts: listProducts,
        listInCart: listShoesInCart,
        totalPrice: finalizeTotalPrice(totalPrice),
      ));
    });
  }

  List<Shoes> getListProducts() {
    return ShoesList.fromJson(MockData.shoesList).shoesList;
  }
  List<Shoes> getListProductsInCart() {
    var listShoesInCart = <Shoes>[];
    if (prefs != null) {
      final jsonStringYourCart = prefs!.getString(StringConstants.yourCartKey);
      if (jsonStringYourCart != null) {
        final jsonYourCart = json.decode(jsonStringYourCart);
        listShoesInCart = ShoesList.fromJson(jsonYourCart).shoesList;
      }
    }

    return listShoesInCart;
  }

  double finalizeTotalPrice(double totalPrice) {
    return num.parse(totalPrice.toStringAsFixed(2)).toDouble();
  }

  emitState(MainState newState) {
    if (!isClosed) {
      emit(newState);
    }
  }

  Future<void> saveDataInCart() async {
    if (prefs != null) {
      await Future.wait([
        prefs!.setString(
          StringConstants.yourCartKey,
          json.encode(ShoesList(shoesList: state.listInCart).toJson()),
        ),
        prefs!.setDouble(
          StringConstants.totalPriceKey,
          state.totalPrice,
        ),
      ]);
    }
  }

  late final SharedPreferences? prefs;
  final removeItemDuration = 500;

  Future<void> onAddToCart(Shoes shoes) async {
    final listProducts = state.listProducts.map(
      (e) {
        if (e.id == shoes.id) {
          return e.copyWith(
            isInCart: true,
          );
        }
        return e.copyWith();
      }
    ).toList();

    final listInCart = state.listInCart.map((e) => e.copyWith()).toList();
    listInCart.add(shoes.copyWith(quantity: 1));

    emitState(state.copyWith(
      listProducts: listProducts,
      listInCart: listInCart,
      totalPrice: finalizeTotalPrice(state.totalPrice + (shoes.price ?? 0)),
      newItemAdded: true,
    ));

    await saveDataInCart();
  }

  Future<void> onChangeQuantity(int index, { bool isDecrease = false, }) async {
    if (state.listInCart[index].quantity == 1 && isDecrease) {
      onRemoveItem(index);
      return;
    }

    final listInCart = state.listInCart.map((e) => e.copyWith()).toList();
    final shoes = listInCart[index];
    listInCart[index] = shoes.copyWith(
      quantity: isDecrease ? shoes.quantity - 1 : shoes.quantity + 1,
    );
    final newPrice = isDecrease
        ? state.totalPrice - (shoes.price ?? 0)
        : state.totalPrice + (shoes.price ?? 0);

    emitState(state.copyWith(
      listInCart: listInCart,
      totalPrice: finalizeTotalPrice(newPrice),
    ));

    await saveDataInCart();
  }

  Future<void> onRemoveItem(int index) async {
    final shoes = state.listInCart[index];
    final listInCart = state.listInCart.map(
      (e) {
        if (e.id == shoes.id) {
          return e.copyWith(
            quantity: 0,
          );
        }
        return e.copyWith();
      }
    ).toList();
    final newPrice = state.totalPrice - (shoes.price ?? 0) * shoes.quantity;

    // emit to show change quantity from n to 0 and update new total price
    emitState(state.copyWith(
      listInCart: listInCart,
      totalPrice: finalizeTotalPrice(newPrice),
    ));

    await Future.delayed(const Duration(milliseconds: 100));

    // actual remove item
    final listProducts = state.listProducts.map(
      (e) {
        if (e.id == shoes.id) {
          return e.copyWith(
            isInCart: false,
          );
        }
        return e.copyWith();
      }
    ).toList();

    // final finalListInCart = state.listInCart.where((e) => e.id != shoes.id).toList();

    emitState(state.copyWith(
      listProducts: listProducts,
      // listInCart: finalListInCart,
      totalPrice: newPrice,
      removedItemIndex: index,
      removedItem: shoes.copyWith(quantity: 0),
    ));

    // wait for animation
    final finalListInCart = state.listInCart.where((e) => e.id != shoes.id).toList();
    emitState(state.copyWith(
      listInCart: finalListInCart,
      removedItemIndex: -1,
    ));

    await saveDataInCart();
  }

  @override
  Future<void> close() async {
    saveDataInCart();

    return super.close();
  }
}
