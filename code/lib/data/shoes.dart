import 'package:flutter/foundation.dart';

/// shoes : [{"id":1,"image":"https://s3-us-west-2.amazonaws.com/s.cdpn.io/1315882/air-zoom-pegasus-36-mens-running-shoe-wide-D24Mcz-removebg-preview.png","name":"Nike Air Zoom Pegasus 36","description":"The iconic Nike Air Zoom Pegasus 36 offers more cooling and mesh that targets breathability across high-heat areas. A slimmer heel collar and tongue reduce bulk, while exposed cables give you a snug fit at higher speeds.","price":108.97,"color":"#e1e7ed"},{"id":2,"image":"https://s3-us-west-2.amazonaws.com/s.cdpn.io/1315882/air-zoom-pegasus-36-shield-mens-running-shoe-24FBGb__1_-removebg-preview.png","name":"Nike Air Zoom Pegasus 36 Shield","description":"The Nike Air Zoom Pegasus 36 Shield gets updated to conquer wet routes. A water-repellent upper combines with an outsole that helps create grip on wet surfaces, letting you run in confidence despite the weather.","price":89.97,"color":"#4D317F"},{"id":3,"image":"https://s3-us-west-2.amazonaws.com/s.cdpn.io/1315882/cruzrone-unisex-shoe-T2rRwS-removebg-preview.png","name":"Nike CruzrOne","description":"Designed for steady, easy-paced movement, the Nike CruzrOne keeps you going. Its rocker-shaped sole and plush, lightweight cushioning let you move naturally and comfortably. The padded collar is lined with soft wool, adding luxury to every step, while mesh details let your foot breathe. There’s no finish line—there’s only you, one step after the next.","price":100.97,"color":"#E8D026"},{"id":4,"image":"https://s3-us-west-2.amazonaws.com/s.cdpn.io/1315882/epic-react-flyknit-2-mens-running-shoe-2S0Cn1-removebg-preview.png","name":"Nike Epic React Flyknit 2","description":"The Nike Epic React Flyknit 2 takes a step up from its predecessor with smooth, lightweight performance and a bold look. An updated Flyknit upper conforms to your foot with a minimal, supportive design. Underfoot, durable Nike React technology defies the odds by being both soft and responsive, for comfort that lasts as long as you can run.","price":89.97,"color":"#FD584A"},{"id":5,"image":"https://s3-us-west-2.amazonaws.com/s.cdpn.io/1315882/odyssey-react-flyknit-2-mens-running-shoe-T3VG7N-removebg-preview.png","name":"Nike Odyssey React Flyknit 2","description":"The Nike Odyssey React Flyknit 2 provides a strategic combination of lightweight Flyknit construction and synthetic material for support. Underfoot, Nike React cushioning delivers a soft, springy ride for a route that begs to be crushed.","price":71.97,"color":"#D4D7D6"},{"id":6,"image":"https://s3-us-west-2.amazonaws.com/s.cdpn.io/1315882/react-infinity-run-flyknit-mens-running-shoe-RQ484B__2_-removebg-preview.png","name":"Nike React Infinity Run Flyknit","description":"A pioneer in the running shoe frontier honors the original pioneer of running culture with the Nike React Infinity Run Flyknit. Blue Ribbon Track Club-inspired details pay homage to the haven that was created before running was even popular. This running shoe is designed to help reduce injury and keep you on the run. More foam and improved upper details provide a secure and cushioned feel.","price":160.0,"color":"#F2F5F4"},{"id":7,"image":"https://s3-us-west-2.amazonaws.com/s.cdpn.io/1315882/react-miler-mens-running-shoe-DgF6nr-removebg-preview.png","name":"Nike React Miler","description":"The Nike React Miler gives you trusted stability for miles with athlete-informed performance. Made for dependability on your long runs, its intuitive design offers a locked-in fit and a durable feel.","price":130.0,"color":"#22AFDC"},{"id":8,"image":"https://s3-us-west-2.amazonaws.com/s.cdpn.io/1315882/renew-ride-mens-running-shoe-JkhdfR-removebg-preview.png","name":"Nike Renew Ride","description":"The Nike Renew Ride helps keep the committed runner moving with plush cushioning. Firm support at the outsole helps you maintain stability no matter the distance.","price":60.97,"color":"#B50320"},{"id":9,"image":"https://s3-us-west-2.amazonaws.com/s.cdpn.io/1315882/vaporfly-4-flyknit-running-shoe-v7G3FB-removebg-preview.png","name":"Nike Vaporfly 4% Flyknit","description":"Built to meet the exacting needs of world-class marathoners, Nike Vaporfly 4% Flyknit is designed for record-breaking speed. The Flyknit upper delivers breathable support, while the responsive foam and full-length plate provide incredible energy return for all 26.2.","price":187.97,"color":"#3569A1"},{"id":10,"image":"https://s3-us-west-2.amazonaws.com/s.cdpn.io/1315882/zoom-fly-3-premium-mens-running-shoe-XhzpPH-removebg-preview.png","name":"Nike Zoom Fly 3 Premium","description":"Inspired by the Vaporfly, the Nike Zoom Fly 3 Premium gives distance runners race-day comfort and durability. The power of a carbon fiber plate keeps you in the running mile after mile.","price":160.0,"color":"#54D4C9"}]

class ShoesList {
  const ShoesList({
    this.shoesList = const <Shoes>[],
  });

  factory ShoesList.fromJson(dynamic json) {
    final mapJson = json as Map<String, dynamic>;
    return ShoesList(
      shoesList: mapJson['shoes'] != null
          ? (mapJson['shoes'] as List).map(Shoes.fromJson).toList()
          : const <Shoes>[],
    );
  }

  final List<Shoes> shoesList;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShoesList &&
          runtimeType == other.runtimeType &&
          listEquals(shoesList, other.shoesList);

  @override
  int get hashCode => shoesList.hashCode;

  ShoesList copyWith({
    List<Shoes>? shoesList,
  }) {
    return ShoesList(shoesList: shoesList ?? this.shoesList,);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['shoes'] = shoesList.map((v) => v.toJson()).toList();
    return map;
  }

}

/// id : 1
/// image : "https://s3-us-west-2.amazonaws.com/s.cdpn.io/1315882/air-zoom-pegasus-36-mens-running-shoe-wide-D24Mcz-removebg-preview.png"
/// name : "Nike Air Zoom Pegasus 36"
/// description : "The iconic Nike Air Zoom Pegasus 36 offers more cooling and mesh that targets breathability across high-heat areas. A slimmer heel collar and tongue reduce bulk, while exposed cables give you a snug fit at higher speeds."
/// price : 108.97
/// color : "#e1e7ed"

class Shoes {
  const Shoes({
    this.id,
    this.image,
    this.name,
    this.description,
    this.price,
    this.color,
    this.quantity = 0,
    this.isInCart = false,
  });

  factory Shoes.fromJson(dynamic json) {
    final mapJson = json as Map<String, dynamic>;
    return Shoes(
      id: mapJson['id'] as num?,
      image: mapJson['image'] as String?,
      name: mapJson['name'] as String?,
      description: mapJson['description'] as String?,
      price: mapJson['price'] as num?,
      color: mapJson['color'] as String?,
      quantity: mapJson['quantity'] as num? ?? 0,
      isInCart: mapJson['isInCart'] as bool? ?? false,
    );
  }

  final num? id;
  final String? image;
  final String? name;
  final String? description;
  final num? price;
  final String? color;
  final num quantity;
  final bool isInCart;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Shoes &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          image == other.image &&
          name == other.name &&
          description == other.description &&
          price == other.price &&
          color == other.color &&
          quantity == other.quantity &&
          isInCart == other.isInCart;

  @override
  int get hashCode =>
      id.hashCode ^
      image.hashCode ^
      name.hashCode ^
      description.hashCode ^
      price.hashCode ^
      color.hashCode ^
      quantity.hashCode^
      isInCart.hashCode;

  Shoes copyWith({
    num? id,
    String? image,
    String? name,
    String? description,
    num? price,
    String? color,
    num? quantity,
    bool? isInCart,
  }) {
    return Shoes(  id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      color: color ?? this.color,
      quantity: quantity ?? this.quantity,
      isInCart: isInCart ?? this.isInCart,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (id != null) map['id'] = id;
    if (image != null) map['image'] = image;
    if (name != null) map['name'] = name;
    if (description != null) map['description'] = description;
    if (price != null) map['price'] = price;
    if (color != null) map['color'] = color;
    map['quantity'] = quantity;
    map['isInCart'] = isInCart;

    return map;
  }

}