class Circular {
  final String title;
  final String description;
  final String category;
  final String date;
  final String author;
  final String status;

  Circular({
    required this.title,
    required this.description,
    required this.category,
    required this.date,
    required this.author,
    required this.status,
  });

  factory Circular.fromJson(Map<String, dynamic> json) {
    return Circular(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      date: json['date'] ?? '',
      author: json['author'] ?? '',
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'date': date,
      'author': author,
      'status': status,
    };
  }
}
