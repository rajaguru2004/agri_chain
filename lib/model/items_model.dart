class FoodDetail {
  String id;
  String image;
  String name;
  double price;
  double rate;
  String kcal;
  String deliveryTime;
  String description;
  String category;

  FoodDetail({
    required this.id,
    required this.image,
    required this.name,
    required this.category,
    required this.price,
    required this.rate,
    required this.kcal,
    required this.deliveryTime,
    required this.description,
  });
}

List<FoodDetail> foodsItems = [];

void fetchItems(Map<String, dynamic> map) {
  List<dynamic> products = map['products'] ?? [];

  for (var product in products) {
    foodsItems.add(FoodDetail(
      id: product['_id'] ?? '',
      image: (product['productImage'] != null &&
              product['productImage'].isNotEmpty)
          ? product['productImage'][0]
          : 'https://via.placeholder.com/150',
      // Default placeholder
      name: product['productName'] ?? 'Unknown',
      category: product['productCategory'] ?? 'Unknown',
      price: (product['productPrice'] is int)
          ? (product['productPrice'] as int).toDouble()
          : (product['productPrice'] ?? 0.0),
      rate: 4.5,
      // Placeholder since rate isn't in the data
      kcal: product['kcal']?.toString() ?? '100',
      // Convert to string if necessary
      deliveryTime: product['deliveryTime']?.toString() ?? '5',
      // Convert to string
      description: product['productDescription'] ?? 'No description available',
    ));
  }
}
