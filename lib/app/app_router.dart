import 'package:go_router/go_router.dart';

import '../features/auth/screens/login_screen.dart';

final GoRouter appRouter = GoRouter(

  initialLocation: '/',

  routes: [

    GoRoute(

      path: '/',

      builder: (context, state) => const LoginScreen(),

    ),

  ],

);