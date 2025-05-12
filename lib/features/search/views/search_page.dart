import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/routes/route_names.dart';
import '../../../config/theme/app_colors.dart';
import '../../../shared/widgets/custom_bottom_nav.dart';
import '../../../shared/widgets/error_widget.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../providers/search_providers.dart';
import 'components/genre_grid.dart';
import 'components/search_result_item.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');
final isSearchingProvider = StateProvider<bool>((ref) => false);

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    ref.read(isSearchingProvider.notifier).state = _searchFocusNode.hasFocus;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.removeListener(_onFocusChange);
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchQuery = ref.watch(searchQueryProvider);
    final isSearching = ref.watch(isSearchingProvider);
    final searchResults = ref.watch(searchResultsProvider);
    final genres = ref.watch(genresProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              decoration: InputDecoration(
                hintText: 'Search anime...',
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.textSecondary,
                ),
                suffixIcon:
                    searchQuery.isNotEmpty
                        ? IconButton(
                          icon: const Icon(
                            Icons.clear,
                            color: AppColors.textSecondary,
                          ),
                          onPressed: () {
                            _searchController.clear();
                            ref.read(searchQueryProvider.notifier).state = '';
                          },
                        )
                        : null,
                filled: true,
                fillColor: AppColors.cardBackground,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              style: const TextStyle(color: AppColors.textPrimary),
              onChanged: (value) {
                ref.read(searchQueryProvider.notifier).state = value;
              },
            ),
          ),
        ),
      ),
      body:
          searchQuery.isEmpty && !isSearching
              ? genres.when(
                data: (data) => GenreGrid(genres: data),
                loading: () => const Center(child: LoadingWidget()),
                error:
                    (error, stack) => CustomErrorWidget(
                      message: 'Failed to load genres',
                      onRetry: () => ref.refresh(genresProvider),
                    ),
              )
              : searchQuery.isEmpty
              ? const Center(
                child: Text(
                  'Type to search anime',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              )
              : searchResults.when(
                data: (data) {
                  if (data.isEmpty) {
                    return const Center(
                      child: Text(
                        'No results found',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final anime = data[index];
                      return SearchResultItem(
                        anime: anime,
                        onTap: () {
                          context.goNamed(
                            RouteNames.animeDetail,
                            pathParameters: {'animeId': anime.id},
                          );
                        },
                      );
                    },
                  );
                },
                loading: () => const Center(child: LoadingWidget()),
                error:
                    (error, stack) => CustomErrorWidget(
                      message: 'Failed to search anime',
                      onRetry: () => ref.refresh(searchResultsProvider),
                    ),
              ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: 2,
        onTap: (index) {
          switch (index) {
            case 0:
              context.goNamed(RouteNames.home);
              break;
            case 1:
              context.goNamed(RouteNames.downloads);
              break;
            case 2:
              // Already on search page
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
