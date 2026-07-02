import 'package:ema_mobile/features/auth/screens/login_screen.dart';
import 'package:ema_mobile/features/dashboard/screens/dashboard_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  debugLogDiagnostics: true,
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
  ],
);