class CartModel{
  late final int? id;
  final String? productId;
  final String? productName;
  final int? initialPrice;
  final int? quantity;
  final String? unitTag;
  final String? image;
  CartModel({
    required this.id,
    required this.productId,
    required this.productName,
    required this.initialPrice,
    required this.quantity,
    required this.image,
    required this.unitTag,
});
  CartModel.fromMap(Map<dynamic,dynamic> result)
      : id = result['id'],
        productId = result['productId'],
        productName = result['productName'],
        initialPrice = result['initialPrice'],
        quantity = result['quantity'],
        unitTag = result['unitTag'],
        image = result['image'];
Map<String, Object?> toMap(){
  return {
    'id': id,
    'productId':productId,
    'productName': productName,
    'initialPrice': initialPrice,
    'quantity': quantity,
    'image':image,
    'unitTag':unitTag
  };
}
}