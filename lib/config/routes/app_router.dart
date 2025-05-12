import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/home/views/home_page.dart';
import '../../features/downloads/views/download_page.dart'; // Ensure this file defines the DownloadPage class
import '../../features/downloads/views/downloaded_episodes_page.dart'; // Ensure this file defines the DownloadedEpisodesPage class
import '../../features/search/views/search_page.dart';
import '../../features/anime_list/views/all_anime_page.dart';
import '../../features/anime_list/views/anime_list_by_section_page.dart';
import '../../features/anime_detail/views/anime_detail_page.dart';
import '../../features/schedule/views/schedule_page.dart';
import '../../features/video_player/views/video_player_page.dart';
import 'route_names.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      // Main Navigation Routes
      GoRoute(
        path: '/',
        name: RouteNames.home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/downloads',
        name: RouteNames.downloads,
        builder: (context, state) => const DownloadPage(),
      ),
      GoRoute(
        path: '/search',
        name: RouteNames.search,
        builder: (context, state) => const SearchPage(),
      ),
      GoRoute(
        path: '/all-anime',
        name: RouteNames.allAnime,
        builder: (context, state) => const AllAnimePage(),
      ),

      // Supporting Routes
      GoRoute(
        path: '/anime-list/:sectionType',
        name: RouteNames.animeListBySection,
        builder: (context, state) {
          final sectionType = state.pathParameters['sectionType'] ?? '';
          final sectionTitle = state.uri.queryParameters['title'] ?? 'Anime List';
          return AnimeListBySectionPage(
            sectionType: sectionType,
            sectionTitle: sectionTitle,
          );
        },
      ),
      GoRoute(
        path: '/anime/:animeId',
        name: RouteNames.animeDetail,
        builder: (context, state) {
          final animeId = state.pathParameters['animeId'] ?? '';
          return AnimeDetailPage(animeId: animeId);
        },
      ),
      GoRoute(
        path: '/schedule',
        name: RouteNames.schedule,
        builder: (context, state) => const SchedulePage(),
      ),
      GoRoute(
        path: '/downloads/:animeId',
        name: RouteNames.downloadedEpisodes,
        builder: (context, state) {
          final animeId = state.pathParameters['animeId'] ?? '';
          return DownloadedEpisodesPage(animeId: animeId);
        },
      ),
      GoRoute(
        path: '/video-player',
        name: RouteNames.videoPlayer,
        builder: (context, state) {
          final videoUrl = state.uri.queryParameters['videoUrl'] ?? '';
          final title = state.uri.queryParameters['title'] ?? '';
          final episodeNumber = state.uri.queryParameters['episodeNumber'] ?? '';
          return VideoPlayerPage(
            videoUrl: videoUrl,
            title: title,
            episodeNumber: episodeNumber,
          );
        },
      ),
    ],
  );
}
