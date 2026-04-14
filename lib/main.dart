import 'package:flutter/material.dart';
import 'package:mess_food/presentation/main/widgets/bottom_nav_bar.dart';
import 'package:mess_food/screens/category/presentation/screen/category_screen.dart';
import 'package:mess_food/screens/notifications/presentation/screen/notification_screen.dart';
import 'package:mess_food/screens/order_details/presentation/screen/order_details_screen.dart';
import 'package:mess_food/screens/search/presentation/screen/search_screen.dart';
import 'package:mess_food/screens/splash/presentation/screen/splash_screen.dart';
import 'package:mess_food/tabs/profile/presentation/screens/profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mess Food',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF6B35)),
      ),
      // 1. Set the initial route (like your splash screen)
      initialRoute: '/splash',

      // 2. Define the route generator for custom animations and logic
      onGenerateRoute: (settings) {
        switch (settings.name) {
          // 1. ADD THIS CASE FOR THE NAV BAR
          case '/':
            return MaterialPageRoute(builder: (_) => const BottomNavBar());

          case '/splash':
            return MaterialPageRoute(builder: (_) => const SplashScreen());

          case '/order-details':
            return _createRoute(
              const OrderDetailsScreen(),
              "Order Details",
              true,
            );

          case '/category':
            return MaterialPageRoute(
              builder: (_) => const CategoryScreen(),
              settings:
                  settings, // This ensures arguments (id, name) are passed correctly
            );

          case '/edit-profile':
            return _createRoute(const ProfileScreen(), "Edit Profile", true);

          case '/notifications':
            return _createRoute(
              const NotificationScreen(),
              "Notifications",
              true,
            );

          case '/search':
            // Custom animation: Fade from bottom (Slide + Fade)
            return PageRouteBuilder(
              pageBuilder: (_, _, _) => const SearchScreen(),
              transitionsBuilder: (_, animation, _, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            );

          default:
            // Default fallback (Similar to your main app container)
            return MaterialPageRoute(builder: (_) => const BottomNavBar());
        }
      },
    );
  }

  // Helper to mimic your Stack.Screen options (Header, Title, etc.)
  Route _createRoute(Widget page, String title, bool showHeader) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // This mimics "slide_from_right" from React Native
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
      settings: RouteSettings(name: title), // This can be used for the title
    );
  }
}
