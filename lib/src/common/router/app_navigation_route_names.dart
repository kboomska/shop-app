abstract final class AppNavigationRoutes {
  /// Root routes
  static const categories = '/categories';
  static const search = '/search';
  static const cart = '/cart';
  static const profile = '/profile';

  /// Nested routes
  static const dishesRouteName = 'dishes';
  static const dishes = '$categories/$dishesRouteName';
}
