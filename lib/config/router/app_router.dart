import 'package:go_router/go_router.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/pages/about_page.dart';
import '../../features/home/presentation/pages/contact_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/about',
      builder: (context, state) => const AboutPage(),
    ),
    GoRoute(
      path: '/contact',
      builder: (context, state) => const ContactPage(),
    ),
  ],
);
