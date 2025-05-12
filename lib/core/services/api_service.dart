import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';
import '../models/anime.dart';
import '../models/genre.dart';
import '../models/schedule.dart';

class ApiService {
  final http.Client _client = http.Client();

  Future<List<Anime>> getOngoingAnime() async {
    try {
      final response = await _client.get(
        Uri.parse(ApiConstants.getOngoingUrl()),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Anime.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load ongoing anime');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Anime>> getCompletedAnime() async {
    try {
      final response = await _client.get(
        Uri.parse(ApiConstants.getCompletedUrl()),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Anime.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load completed anime');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Anime>> getPopularAnime() async {
    try {
      final response = await _client.get(
        Uri.parse(ApiConstants.getPopularUrl()),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Anime.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load popular anime');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Anime>> getMovies() async {
    try {
      final response = await _client.get(
        Uri.parse(ApiConstants.getMoviesUrl()),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Anime.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Anime>> searchAnime(String query) async {
    try {
      final response = await _client.get(
        Uri.parse(ApiConstants.getSearchUrl(query)),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Anime.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search anime');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Schedule>> getSchedule() async {
    try {
      final response = await _client.get(
        Uri.parse(ApiConstants.getScheduleUrl()),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        List<Schedule> schedules = [];

        data.forEach((day, animeList) {
          schedules.add(
            Schedule(
              day: day,
              animeList:
                  (animeList as List)
                      .map((json) => Anime.fromJson(json))
                      .toList(),
            ),
          );
        });

        return schedules;
      } else {
        throw Exception('Failed to load schedule');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Genre>> getGenres() async {
    try {
      final response = await _client.get(
        Uri.parse(ApiConstants.getGenresUrl()),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Genre.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load genres');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Anime>> getAnimeList() async {
    try {
      final response = await _client.get(
        Uri.parse(ApiConstants.getAnimeListUrl()),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Anime.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load anime list');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Anime>> getAnimeByGenre(String genreId) async {
    try {
      final response = await _client.get(
        Uri.parse(ApiConstants.getGenreDetailUrl(genreId)),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Anime.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load anime by genre');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
