import 'dart:convert';

import 'package:code/constants/locals.dart';
import 'package:code/data/shoes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(const MainState()) {
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

      emit(state.copyWith(
        listProducts: listProducts,
        listInCart: listShoesInCart,
        totalPrice: totalPrice,
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

    emit(state.copyWith(
      listProducts: listProducts,
      listInCart: listInCart,
      totalPrice: state.totalPrice + (shoes.price ?? 0),
    ));

    await saveDataInCart();
  }

  Future<void> onChangeQuantity(int index, { bool isDecrease = false, }) async {
    if (state.listInCart[index].quantity == 1 && isDecrease) {
      onRemoveItem(state.listInCart[index]);
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

    emit(state.copyWith(
      listInCart: listInCart,
      totalPrice: newPrice,
    ));

    await saveDataInCart();
  }

  Future<void> onRemoveItem(Shoes shoes) async {
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

    final listInCart = state.listInCart.where((e) => e.id != shoes.id).toList();

    await prefs?.setString(
      StringConstants.yourCartKey,
      json.encode(ShoesList(shoesList: listInCart).toJson()),
    );

    final newPrice = state.totalPrice - (shoes.price ?? 0) * shoes.quantity;

    emit(state.copyWith(
      listProducts: listProducts,
      listInCart: listInCart,
      totalPrice: newPrice,
    ));

    await saveDataInCart();
  }

  @override
  Future<void> close() async {
    saveDataInCart();

    return super.close();
  }
}
