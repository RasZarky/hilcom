import 'package:go_router/go_router.dart';
import '../../features/home/domain/models/product_model.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/pages/about_page.dart';
import '../../features/home/presentation/pages/contact_page.dart';
import '../../features/home/presentation/pages/product_details_page.dart';
import '../../features/home/presentation/pages/sell_to_hilcom_page.dart';
import '../../features/home/presentation/pages/my_products_page.dart';

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
    GoRoute(
      path: '/sell-to-hilcom',
      builder: (context, state) => const SellToHilcomPage(),
    ),
    GoRoute(
      path: '/my-products',
      builder: (context, state) => const MyProductsPage(),
    ),
    GoRoute(
      path: '/product',
      builder: (context, state) {
        final product = state.extra as ProductModel;
        return ProductDetailsPage(product: product);
      },
    ),
  ],
);
