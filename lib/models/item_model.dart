class Item {
  final String id;
  final String name;
  // final String category;
  // final double price;
  final DateTime date;
  final String url;

  const Item(
      {required this.id,
      required this.name,
      // required this.category,
      // required this.price,
      required this.date,
      required this.url});

  factory Item.fromMap(Map<String, dynamic> map) {
    final properties = map['properties'] as Map<String, dynamic>;
    final nameList = (properties['Name']?['title'] ?? []) as List;
    final dateStr = properties['Data']?['date']?['start'];
    final id = map['id'];
    final url = map['url'];

    return Item(
        id: id,
        name: nameList.isNotEmpty ? nameList[0]['plain_text'] : '?',
        // category: properties['Category']?['select']?['name'] ?? 'Any',
        // price: (properties['Price']?['number'] ?? 0).toDouble(),
        date: dateStr != null ? DateTime.parse(dateStr) : DateTime.now(),
        url: url);
  }
}
