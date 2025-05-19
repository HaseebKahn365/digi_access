class EduItem {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final DateTime createdAt;

  EduItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.createdAt,
  });

  factory EduItem.fromMap(Map<String, dynamic> map) {
    return EduItem(
      id: map['_id'].toString(),
      name: map['name'] as String,
      imageUrl: map['imageUrl'] as String,
      price: (map['price'] as num).toDouble(),
      createdAt: DateTime.parse(map['createdAt'].toString()),
    );
  }
}
