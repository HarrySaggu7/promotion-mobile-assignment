import 'package:ema_mobile/features/auth/screens/login_screen.dart';
import 'package:ema_mobile/features/cart/screens/cart_screen.dart';
import 'package:ema_mobile/features/dashboard/screens/dashboard_screen.dart';
import 'package:ema_mobile/features/products/models/product_model.dart';
import 'package:ema_mobile/features/products/screens/product_detail_screen.dart';
import 'package:ema_mobile/features/store/screens/store_locator_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/product',
      builder: (context, state) {
        final product = state.extra as ProductModel;

        return ProductDetailScreen(
          product: product,
        );
      },
    ),
    GoRoute(
      path: '/stores',
      builder: (context, state) => const StoreLocatorScreen(),
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => const CartScreen(),
    ),
  ],
);