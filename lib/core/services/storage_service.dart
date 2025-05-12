import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/anime.dart';
import '../models/episode.dart';

class StorageService {
  static const String _downloadedAnimeKey = 'downloaded_anime';
  static const String _downloadedEpisodesPrefix = 'downloaded_episodes_';

  Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  // Save downloaded anime
  Future<void> saveDownloadedAnime(Anime anime) async {
    final prefs = await _prefs;
    final downloadedAnimeJson = prefs.getStringList(_downloadedAnimeKey) ?? [];

    // Check if anime already exists
    final animeExists = downloadedAnimeJson.any((json) {
      final Map<String, dynamic> data = jsonDecode(json);
      return data['id'] == anime.id;
    });

    if (!animeExists) {
      downloadedAnimeJson.add(jsonEncode(anime.toJson()));
      await prefs.setStringList(_downloadedAnimeKey, downloadedAnimeJson);
    }
  }

  // Get all downloaded anime
  Future<List<Anime>> getDownloadedAnime() async {
    final prefs = await _prefs;
    final downloadedAnimeJson = prefs.getStringList(_downloadedAnimeKey) ?? [];

    return downloadedAnimeJson.map((json) {
      final Map<String, dynamic> data = jsonDecode(json);
      return Anime.fromJson(data);
    }).toList();
  }

  // Save downloaded episode
  Future<void> saveDownloadedEpisode(String animeId, Episode episode) async {
    final prefs = await _prefs;
    final key = _downloadedEpisodesPrefix + animeId;
    final downloadedEpisodesJson = prefs.getStringList(key) ?? [];

    // Check if episode already exists and update it
    final episodeIndex = downloadedEpisodesJson.indexWhere((json) {
      final Map<String, dynamic> data = jsonDecode(json);
      return data['id'] == episode.id;
    });

    if (episodeIndex >= 0) {
      downloadedEpisodesJson[episodeIndex] = jsonEncode(episode.toJson());
    } else {
      downloadedEpisodesJson.add(jsonEncode(episode.toJson()));
    }

    await prefs.setStringList(key, downloadedEpisodesJson);

    // Make sure the anime is saved as well
    final anime = await getAnimeById(animeId);
    if (anime != null) {
      await saveDownloadedAnime(anime);
    }
  }

  // Get downloaded episodes for an anime
  Future<List<Episode>> getDownloadedEpisodes(String animeId) async {
    final prefs = await _prefs;
    final key = _downloadedEpisodesPrefix + animeId;
    final downloadedEpisodesJson = prefs.getStringList(key) ?? [];

    return downloadedEpisodesJson.map((json) {
      final Map<String, dynamic> data = jsonDecode(json);
      return Episode.fromJson(data);
    }).toList();
  }

  // Remove downloaded anime
  Future<void> removeDownloadedAnime(String animeId) async {
    final prefs = await _prefs;
    final downloadedAnimeJson = prefs.getStringList(_downloadedAnimeKey) ?? [];

    final updatedList =
        downloadedAnimeJson.where((json) {
          final Map<String, dynamic> data = jsonDecode(json);
          return data['id'] != animeId;
        }).toList();

    await prefs.setStringList(_downloadedAnimeKey, updatedList);

    // Also remove all downloaded episodes for this anime
    final key = _downloadedEpisodesPrefix + animeId;
    await prefs.remove(key);
  }

  // Get anime by ID
  Future<Anime?> getAnimeById(String animeId) async {
    final prefs = await _prefs;
    final downloadedAnimeJson = prefs.getStringList(_downloadedAnimeKey) ?? [];

    for (final json in downloadedAnimeJson) {
      final Map<String, dynamic> data = jsonDecode(json);
      if (data['id'] == animeId) {
        return Anime.fromJson(data);
      }
    }

    return null;
  }
}
