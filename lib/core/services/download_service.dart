import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '../models/anime.dart';
import '../models/episode.dart';
import 'storage_service.dart';

class DownloadService {
  final StorageService _storageService;
  final http.Client _client;

  DownloadService({required StorageService storageService, http.Client? client})
    : _storageService = storageService,
      _client = client ?? http.Client();

  Future<String> _getDownloadPath() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/downloads';
    final dir = Directory(path);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return path;
  }

  Future<Episode> downloadEpisode({
    required Anime anime,
    required Episode episode,
    required Function(double) onProgress,
  }) async {
    try {
      final downloadPath = await _getDownloadPath();
      final fileName = '${anime.id}_${episode.id}.mp4';
      final filePath = '$downloadPath/$fileName';

      // Check if file already exists
      final file = File(filePath);
      if (await file.exists()) {
        // Update episode in storage
        final updatedEpisode = episode.copyWith(
          isDownloaded: true,
          downloadPath: filePath,
        );
        await _storageService.saveDownloadedEpisode(anime.id, updatedEpisode);
        return updatedEpisode;
      }

      // Download file
      final response = await _client.get(Uri.parse(episode.url));
      final bytes = response.bodyBytes;
      final totalBytes = bytes.length;

      // Create file and write bytes
      final outputFile = File(filePath);
      final sink = outputFile.openWrite();

      int bytesWritten = 0;
      final chunkSize = 1024 * 10; // 10KB chunks

      for (var i = 0; i < totalBytes; i += chunkSize) {
        final end = (i + chunkSize < totalBytes) ? i + chunkSize : totalBytes;
        sink.add(bytes.sublist(i, end));
        bytesWritten += end - i;
        onProgress(bytesWritten / totalBytes);

        // Add a small delay to allow UI updates
        await Future.delayed(const Duration(milliseconds: 1));
      }

      await sink.flush();
      await sink.close();

      // Update episode in storage
      final updatedEpisode = episode.copyWith(
        isDownloaded: true,
        downloadPath: filePath,
      );
      await _storageService.saveDownloadedEpisode(anime.id, updatedEpisode);

      return updatedEpisode;
    } catch (e) {
      debugPrint('Error downloading episode: $e');
      rethrow;
    }
  }

  Future<void> deleteDownloadedEpisode(String animeId, Episode episode) async {
    try {
      if (episode.downloadPath != null) {
        final file = File(episode.downloadPath!);
        if (await file.exists()) {
          await file.delete();
        }
      }

      // Update episode in storage
      final updatedEpisode = episode.copyWith(
        isDownloaded: false,
        downloadPath: null,
      );
      await _storageService.saveDownloadedEpisode(animeId, updatedEpisode);
    } catch (e) {
      debugPrint('Error deleting downloaded episode: $e');
      rethrow;
    }
  }

  Future<List<Anime>> getDownloadedAnime() async {
    return _storageService.getDownloadedAnime();
  }

  Future<List<Episode>> getDownloadedEpisodes(String animeId) async {
    return _storageService.getDownloadedEpisodes(animeId);
  }
}
