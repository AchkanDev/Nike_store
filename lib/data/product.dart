class ProductSort {
  static const int latest = 0;
  static const int popular = 1;
  static const int hifhToLow = 2;
  static const int lowToHigh = 3;
}

class ProductEntity {
  final int id;
  final String title;
  final int price;
  final int discount;
  final String image;
  final int previousPrice;

  ProductEntity(this.id, this.title, this.price, this.discount, this.image,
      this.previousPrice);

  ProductEntity.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        price = json["previous_price"] == null
            ? json["price"] - json["discount"]
            : json["price"],
        discount = json["discount"],
        image = json["image"],
        previousPrice = json["previous_price"] ?? json['price'];
}
