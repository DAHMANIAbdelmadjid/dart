class Video {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String category;

  Video({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.category,
  });

  factory Video.fromJson(Map<String, dynamic> json, String category) {
    return Video(
      id: json['snippet']['resourceId']['videoId'],
      title: json['snippet']['title'],
      thumbnailUrl: json['snippet']['thumbnails']['high']['url'],
      category: category,
    );
  }
}
