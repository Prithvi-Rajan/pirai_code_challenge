class ProductModel {
  final int id;
  final String title;
  final String description;
  final String price;
  final String rating;
  final String ratingCount;
  final String image;
  ProductModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.image,
      required this.rating,
      required this.ratingCount});
}
