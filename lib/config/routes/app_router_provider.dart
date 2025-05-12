// lib/config/routes/app_router_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_router.dart';

final appRouterProvider = Provider<AppRouter>((ref) {
  return AppRouter();
});
