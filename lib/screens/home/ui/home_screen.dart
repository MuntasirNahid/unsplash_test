import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:unsplash_image/routes/routes.dart';
import 'package:unsplash_image/screens/home/bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeBloc _homeBloc;
  @override
  void initState() {
    // TODO: implement initState
    _homeBloc = context.read<HomeBloc>();
    _homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        bloc: _homeBloc,
        listener: (context, state) async {
          if (state is FetchImageListButtonClickedState) {
            await Get.toNamed(AppRoutes.imageListScreen);
            _homeBloc.add(CameBackFromImageListScreenEvent());
          }
          if (state is SearchImageListButtonClickedState) {
            await Get.toNamed(AppRoutes.searchScreen);
            _homeBloc.add(CameBackFromSearchScreenEvent());
          }
        },
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _homeBloc.add(FetchImageListButtonClickedEvent());
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Get Image List'),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _homeBloc.add(SearchImageListButtonClickedEvent());
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Search Image'),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('Image List'),
            );
          }
        },
      ),
    );
  }
}
