import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/routes/route_names.dart';
import '../../../shared/widgets/custom_app_bar.dart';
import '../../../shared/widgets/custom_bottom_nav.dart';
import '../../../shared/widgets/error_widget.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../providers/home_providers.dart';
import 'components/anime_carousel.dart';
import 'components/anime_section.dart';
import 'components/section_header.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carouselItems = ref.watch(carouselItemsProvider);
    final ongoingAnime = ref.watch(ongoingAnimeProvider);
    final completedAnime = ref.watch(completedAnimeProvider);
    final popularAnime = ref.watch(popularAnimeProvider);
    final movies = ref.watch(moviesProvider);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Anime Stream'),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(ongoingAnimeProvider);
          ref.refresh(completedAnimeProvider);
          ref.refresh(popularAnimeProvider);
          ref.refresh(moviesProvider);
          ref.refresh(carouselItemsProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Carousel
              carouselItems.when(
                data: (data) => AnimeCarousel(animeList: data),
                loading:
                    () => const SizedBox(
                      height: 220,
                      child: Center(child: LoadingWidget()),
                    ),
                error:
                    (error, stack) => SizedBox(
                      height: 220,
                      child: CustomErrorWidget(
                        message: 'Failed to load carousel',
                        onRetry: () => ref.refresh(carouselItemsProvider),
                      ),
                    ),
              ),

              const SizedBox(height: 20),

              // Ongoing Section
              SectionHeader(
                title: 'Ongoing Anime',
                showViewAll: true,
                sectionType: 'ongoing',
                onViewAllPressed: () {
                  context.goNamed(
                    RouteNames.animeListBySection,
                    pathParameters: {'sectionType': 'ongoing'},
                    queryParameters: {'title': 'Ongoing Anime'},
                  );
                },
              ),
              ongoingAnime.when(
                data:
                    (data) => AnimeSection(
                      title: 'Ongoing Anime',
                      animeList: data.take(10).toList(),
                      sectionType: 'ongoing',
                    ),
                loading:
                    () => const SizedBox(
                      height: 200,
                      child: Center(child: LoadingWidget()),
                    ),
                error:
                    (error, stack) => SizedBox(
                      height: 200,
                      child: CustomErrorWidget(
                        message: 'Failed to load ongoing anime',
                        onRetry: () => ref.refresh(ongoingAnimeProvider),
                      ),
                    ),
              ),

              const SizedBox(height: 20),

              // Completed Section
              SectionHeader(
                title: 'Complete Anime',
                showViewAll: true,
                sectionType: 'completed',
                onViewAllPressed: () {
                  context.goNamed(
                    RouteNames.animeListBySection,
                    pathParameters: {'sectionType': 'completed'},
                    queryParameters: {'title': 'Completed Anime'},
                  );
                },
              ),
              completedAnime.when(
                data:
                    (data) => AnimeSection(
                      title: 'Complete Anime',
                      animeList: data.take(10).toList(),
                      sectionType: 'completed',
                    ),
                loading:
                    () => const SizedBox(
                      height: 200,
                      child: Center(child: LoadingWidget()),
                    ),
                error:
                    (error, stack) => SizedBox(
                      height: 200,
                      child: CustomErrorWidget(
                        message: 'Failed to load completed anime',
                        onRetry: () => ref.refresh(completedAnimeProvider),
                      ),
                    ),
              ),

              const SizedBox(height: 20),

              // Trending Section
              SectionHeader(
                title: 'Trending Anime',
                showViewAll: true,
                sectionType: 'trending',
                onViewAllPressed: () {
                  context.goNamed(
                    RouteNames.animeListBySection,
                    pathParameters: {'sectionType': 'popular'},
                    queryParameters: {'title': 'Trending Anime'},
                  );
                },
              ),
              popularAnime.when(
                data:
                    (data) => AnimeSection(
                      title: 'Trending Anime',
                      animeList: data.take(10).toList(),
                      sectionType: 'trending',
                    ),
                loading:
                    () => const SizedBox(
                      height: 200,
                      child: Center(child: LoadingWidget()),
                    ),
                error:
                    (error, stack) => SizedBox(
                      height: 200,
                      child: CustomErrorWidget(
                        message: 'Failed to load trending anime',
                        onRetry: () => ref.refresh(popularAnimeProvider),
                      ),
                    ),
              ),

              const SizedBox(height: 20),

              // Movies Section
              SectionHeader(
                title: 'Movies Anime',
                showViewAll: true,
                sectionType: 'movies',
                onViewAllPressed: () {
                  context.goNamed(
                    RouteNames.animeListBySection,
                    pathParameters: {'sectionType': 'movies'},
                    queryParameters: {'title': 'Anime Movies'},
                  );
                },
              ),
              movies.when(
                data:
                    (data) => AnimeSection(
                      title: 'Movies Anime',
                      animeList: data.take(10).toList(),
                      sectionType: 'movies',
                    ),
                loading:
                    () => const SizedBox(
                      height: 200,
                      child: Center(child: LoadingWidget()),
                    ),
                error:
                    (error, stack) => SizedBox(
                      height: 200,
                      child: CustomErrorWidget(
                        message: 'Failed to load movies',
                        onRetry: () => ref.refresh(moviesProvider),
                      ),
                    ),
              ),

              const SizedBox(height: 20),

              // Anime Today Section
              SectionHeader(
                title: 'Anime Hari Ini',
                showViewAll: true,
                sectionType: 'today',
                onViewAllPressed: () {
                  context.goNamed(RouteNames.schedule);
                },
              ),
              Container(
                height: 100,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: ListTile(
                    onTap: () => context.goNamed(RouteNames.schedule),
                    leading: const Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                      size: 32,
                    ),
                    title: const Text(
                      'Lihat Jadwal Anime',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: const Text(
                      'Jadwal rilis anime terbaru minggu ini',
                      style: TextStyle(color: Colors.white70),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              // Already on home page
              break;
            case 1:
              context.goNamed(RouteNames.downloads);
              break;
            case 2:
              context.goNamed(RouteNames.search);
              break;
            case 3:
              context.goNamed(RouteNames.allAnime);
              break;
          }
        },
      ),
    );
  }
}
