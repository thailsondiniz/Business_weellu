class Item {
  final String? productName;
  final String? price;
  final String? description;
  final String? imageUrl;
  final String? itemId;
  final String? brand;
  final String? model;
  final String? color;
  final String? selectedItem;
  final String? userId;
  final String? nameBusiness;
  final String? categoryBusiness;
  final String? coverPhoto;
  final String? profilePhoto;

  Item(
      {this.nameBusiness,
      this.productName,
      this.price,
      this.description,
      this.imageUrl,
      this.itemId,
      this.brand,
      this.model,
      this.color,
      this.selectedItem,
      this.userId,
      this.categoryBusiness,
      this.coverPhoto,
      this.profilePhoto});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      itemId: json['_id'],
      productName: json['productName'],
      price: json['price'],
      description: json['description'],
      imageUrl: json['imagePath'],
      brand: json['brand'] ?? '',
      model: json['model'] ?? '',
      color: json['color'] ?? '',
      selectedItem: json['category'],
      userId: json['userId'],
      categoryBusiness: json['categoryBusiness'],
      coverPhoto: json['coverPhoto'],
      profilePhoto: json['profilePhoto'],
      nameBusiness: json['nameUser'],
    );
  }
}




  //     factory Item.fromJson(Map<String, dynamic> json) {
  //   return Item(
  //     productName: json['productName'],
  //     price: json['price'],
  //     description: json['description'],
  //     imageUrl: json['imagePath'],
  //     itemId: json['_id'],
  //     brand: json['brand'],
  //     model: json['model'],
  //     color: json['color'],
  //     selectedItem: json['category'],
  //     nameBusiness: json['nameUser'],
  //     coverPhoto: json['coverPhoto'],
  //     profilePhoto: json['profilePhoto'],
  //   );
  // }