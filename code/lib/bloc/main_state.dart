part of 'main_cubit.dart';

@immutable
class MainState {
  const MainState({
    this.listProducts = const [],
    this.listInCart = const [],
    this.totalPrice = 0,
  });

  final List<Shoes> listProducts;
  final List<Shoes> listInCart;
  final double totalPrice;

  MainState copyWith({
    List<Shoes>? listProducts,
    List<Shoes>? listInCart,
    double? totalPrice,
  }) {
    return MainState(
      listProducts: listProducts ?? this.listProducts,
      listInCart: listInCart ?? this.listInCart,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MainState &&
          runtimeType == other.runtimeType &&
          listEquals(listProducts, other.listProducts) &&
          listEquals(listInCart, other.listInCart) &&
          totalPrice == other.totalPrice;

  @override
  int get hashCode => listProducts.hashCode ^ listInCart.hashCode ^ totalPrice.hashCode;
}
