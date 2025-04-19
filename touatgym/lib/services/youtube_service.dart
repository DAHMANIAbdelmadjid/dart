import '../models/video_model.dart';

class YoutubeService {
  // Hardcoded video IDs from your playlist
  final List<Map<String, String>> videoData = [
    {
      'id': 'YaXPRqUwItQ',
      'title': 'Full Body Workout',
      'thumbnailUrl': 'https://img.youtube.com/vi/YaXPRqUwItQ/maxresdefault.jpg',
    },
    {
      'id': 'ml6cT4AZdqI',
      'title': 'Chest Workout',
      'thumbnailUrl': 'https://img.youtube.com/vi/ml6cT4AZdqI/maxresdefault.jpg',
    },
    // Add more videos from your playlist here
  ];

  Future<List<VideoModel>> getPlaylistVideos() async {
    try {
      return videoData.map((video) => VideoModel(
        id: video['id'] ?? '',
        title: video['title'] ?? '',
        thumbnailUrl: video['thumbnailUrl'] ?? '',
        duration: '0:00',
      )).toList();
    } catch (e) {
      print('Error getting videos: $e');
      return [];
    }
  }
}
