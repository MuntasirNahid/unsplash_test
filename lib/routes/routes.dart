import 'package:get/get.dart';
import 'package:unsplash_image/screens/home/ui/home_screen.dart';
import 'package:unsplash_image/screens/search_screen/ui/search_screen.dart';
import 'package:unsplash_image/screens/show_image/ui/image_list_screen.dart';
import 'package:unsplash_image/widgets/full_screen_image.dart';

class AppRoutes {
  static String imageListScreen = '/imageList';
  static String homeScreen = '/home';
  static String searchScreen = '/search';
  static String fullScreenImage = '/fullScreenImage';
}

final getScreens = [
  GetPage(
    name: AppRoutes.imageListScreen,
    page: () => const FetchImageScreen(),
  ),
  GetPage(
    name: AppRoutes.homeScreen,
    page: () => const HomeScreen(),
  ),
  GetPage(
    name: AppRoutes.searchScreen,
    page: () => const SearchScreen(),
  ),
  GetPage(
    name: AppRoutes.fullScreenImage,
    page: () => const FullScreenImage(imagePath: '', title: ''),
  ),
];
