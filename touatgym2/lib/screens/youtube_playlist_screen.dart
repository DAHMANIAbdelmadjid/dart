import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'video_player_screen.dart';

class CachedVideo {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String duration;

  CachedVideo({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.duration,
  });

  factory CachedVideo.fromVideo(Video video) {
    return CachedVideo(
      id: video.id.value,
      title: video.title,
      thumbnailUrl: video.thumbnails.highResUrl,
      duration: video.duration?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'thumbnailUrl': thumbnailUrl,
    'duration': duration,
  };

  factory CachedVideo.fromJson(Map<String, dynamic> json) {
    return CachedVideo(
      id: json['id'] as String,
      title: json['title'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      duration: json['duration'] as String,
    );
  }
}

class YoutubePlaylistScreen extends StatefulWidget {
  const YoutubePlaylistScreen({Key? key}) : super(key: key);

  @override
  _YoutubePlaylistScreenState createState() => _YoutubePlaylistScreenState();
}

class _YoutubePlaylistScreenState extends State<YoutubePlaylistScreen> {
  final String playlistId = 'PLrLOS7pybFNnpU2mzb7C_j_0vXq7glytg';
  final yt = YoutubeExplode();
  List<CachedVideo> videos = [];
  bool isLoading = true;
  bool hasError = false;
  String errorMessage = '';
  static const String cacheKey = 'youtube_playlist_cache';
  static const Duration cacheDuration = Duration(hours: 1);

  @override
  void initState() {
    super.initState();
    _loadVideos();
  }

  Future<void> _loadVideos() async {
    try {
      // Try to load from cache first
      final cachedVideos = await _loadFromCache();
      if (cachedVideos != null) {
        if (mounted) {
          setState(() {
            videos = cachedVideos;
            isLoading = false;
          });
        }
        return;
      }

      await _fetchPlaylistVideos();
    } catch (e) {
      if (mounted) {
        setState(() {
          hasError = true;
          errorMessage = 'Failed to load videos. Please try again later.';
          isLoading = false;
        });
      }
    }
  }

  Future<List<CachedVideo>?> _loadFromCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? cachedData = prefs.getString(cacheKey);
      final String? cacheTimestamp = prefs.getString('${cacheKey}_timestamp');

      if (cachedData != null && cacheTimestamp != null) {
        final timestamp = DateTime.parse(cacheTimestamp);
        if (DateTime.now().difference(timestamp) < cacheDuration) {
          final List<dynamic> decoded = json.decode(cachedData);
          return decoded.map((videoJson) => CachedVideo.fromJson(videoJson)).toList();
        }
      }
    } catch (e) {
      print('Cache loading error: $e');
    }
    return null;
  }

  Future<void> _saveToCache(List<CachedVideo> videos) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String encodedVideos = json.encode(videos.map((v) => v.toJson()).toList());
      await prefs.setString(cacheKey, encodedVideos);
      await prefs.setString('${cacheKey}_timestamp', DateTime.now().toIso8601String());
    } catch (e) {
      print('Cache saving error: $e');
    }
  }

  Future<void> _fetchPlaylistVideos() async {
    try {
      final List<CachedVideo> fetchedVideos = [];
      await for (var video in yt.playlists.getVideos(playlistId)) {
        if (!mounted) break;
        fetchedVideos.add(CachedVideo.fromVideo(video));
        // Add a small delay between requests to avoid rate limiting
        await Future.delayed(const Duration(milliseconds: 200));
      }

      if (mounted) {
        setState(() {
          videos = fetchedVideos;
          isLoading = false;
          hasError = false;
        });
      }

      // Save to cache
      await _saveToCache(fetchedVideos);
    } catch (e) {
      print('Error fetching playlist: $e');
      if (mounted) {
        setState(() {
          hasError = true;
          errorMessage = 'Failed to load videos. Please try again later.';
          isLoading = false;
        });
      }
    }
  }

  Future<void> _retryLoading() async {
    if (mounted) {
      setState(() {
        isLoading = true;
        hasError = false;
        errorMessage = '';
      });
    }
    await _loadVideos();
  }

  Future<void> _launchVideo(String videoId, String title) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPlayerScreen(
          videoId: videoId,
          title: title,
        ),
      ),
    );
  }

  @override
  void dispose() {
    yt.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gym Workout Videos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _retryLoading,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : hasError
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(errorMessage),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _retryLoading,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: videos.length,
                  itemBuilder: (context, index) {
                    final video = videos[index];
                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Image.network(
                          video.thumbnailUrl,
                          width: 120,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 120,
                              color: Colors.grey,
                              child: const Icon(Icons.error),
                            );
                          },
                        ),
                        title: Text(
                          video.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          'Duration: ${video.duration}',
                        ),
                        onTap: () => _launchVideo(video.id, video.title),
                      ),
                    );
                  },
                ),
    );
  }
}
