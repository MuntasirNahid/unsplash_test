import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:unsplash_image/data/repositories/image_repository.dart';
import 'package:unsplash_image/routes/routes.dart';
import 'package:unsplash_image/screens/home/bloc/home_bloc.dart';
import 'package:unsplash_image/screens/search_screen/bloc/search_screen_bloc.dart';
import 'package:unsplash_image/screens/show_image/bloc/image_list_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ImageRepository>(create: (_) => ImageRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(create: (_) => HomeBloc()),
          BlocProvider<ImageListBloc>(
            create: (blocContext) => ImageListBloc(
              blocContext.read<ImageRepository>(),
            ),
          ),
          BlocProvider<SearchScreenBloc>(
            create: (_) => SearchScreenBloc(),
          ),
        ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Unsplash Image',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: AppRoutes.homeScreen,
          getPages: getScreens,
        ),
      ),
    );
    // return G
  }
}
