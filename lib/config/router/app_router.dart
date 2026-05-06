import 'package:go_router/go_router.dart';
import '../../features/home/domain/models/product_model.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/pages/about_page.dart';
import '../../features/home/presentation/pages/contact_page.dart';
import '../../features/home/presentation/pages/product_details_page.dart';
import '../../features/home/presentation/pages/sell_to_hilcom_page.dart';
import '../../features/home/presentation/pages/my_products_page.dart';
import '../../features/home/presentation/pages/cart_page.dart';
import '../../features/home/presentation/pages/login_page.dart';
import '../../features/home/presentation/pages/admin_login_page.dart';
import '../../features/home/presentation/pages/account_page.dart';
import '../../features/home/presentation/pages/register_page.dart';
import '../../features/home/presentation/pages/forgot_password_page.dart';
import '../../features/home/presentation/pages/wishlist_page.dart';
import '../../features/home/presentation/pages/splash_page.dart';
import '../../features/home/presentation/pages/category_page.dart';

final appRouter = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/category/:name',
      builder: (context, state) {
        final categoryName = state.pathParameters['name']!;
        return CategoryPage(categoryName: categoryName);
      },
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
      path: '/cart',
      builder: (context, state) => const CartPage(),
    ),
    GoRoute(
      path: '/wishlist',
      builder: (context, state) => const WishlistPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/admin-login',
      builder: (context, state) => const AdminLoginPage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordPage(),
    ),
    GoRoute(
      path: '/account',
      builder: (context, state) => const AccountPage(),
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
