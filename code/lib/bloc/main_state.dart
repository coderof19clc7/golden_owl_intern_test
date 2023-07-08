part of 'main_cubit.dart';

@immutable
class MainState {
  const MainState({
    this.listProducts = const [],
    this.listInCart = const [],
    this.totalPrice = 0,
    this.isLoading = false,
    this.newItemAdded = false,
    this.removedItemIndex = -1,
    this.removedItem,
  });

  final List<Shoes> listProducts;
  final List<Shoes> listInCart;
  final double totalPrice;
  final bool isLoading, newItemAdded;
  final int removedItemIndex;
  final Shoes? removedItem;

  MainState copyWith({
    List<Shoes>? listProducts,
    List<Shoes>? listInCart,
    double? totalPrice,
    bool? isLoading,
    bool? newItemAdded,
    int? removedItemIndex,
    Shoes? removedItem,
  }) {
    return MainState(
      listProducts: listProducts ?? this.listProducts,
      listInCart: listInCart ?? this.listInCart,
      totalPrice: totalPrice ?? this.totalPrice,
      isLoading: isLoading ?? this.isLoading,
      newItemAdded: newItemAdded ?? this.newItemAdded,
      removedItemIndex: removedItemIndex ?? this.removedItemIndex,
      removedItem: removedItem ?? this.removedItem,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MainState &&
          runtimeType == other.runtimeType &&
          listEquals(listProducts, other.listProducts) &&
          listEquals(listInCart, other.listInCart) &&
          totalPrice == other.totalPrice &&
          isLoading == other.isLoading &&
          newItemAdded == other.newItemAdded &&
          removedItemIndex == other.removedItemIndex &&
          removedItem == other.removedItem;

  @override
  int get hashCode =>
      listProducts.hashCode ^
      listInCart.hashCode ^
      totalPrice.hashCode ^
      isLoading.hashCode ^
      newItemAdded.hashCode ^
      removedItemIndex.hashCode ^
      removedItem.hashCode;
}
