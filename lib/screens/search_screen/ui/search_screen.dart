import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:unsplash_image/screens/search_screen/bloc/search_screen_bloc.dart';
import 'package:unsplash_image/widgets/image_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  late final SearchScreenBloc _searchScreenBloc;
  @override
  void initState() {
    // TODO: implement initState
    _searchScreenBloc = context.read<SearchScreenBloc>();
    _searchScreenBloc.add(SearchScreenInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Search Screen'),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
      ),
      body: BlocConsumer<SearchScreenBloc, SearchScreenState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is SearchScreenInitialState) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search Image',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    controller: _searchController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _searchScreenBloc.add(
                          SearchButtonClickedEvent(
                            _searchController.text,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Search'),
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is SearchScreenLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SearchQueryCompletedState) {
            return ListView.builder(
              itemCount: state.imageLists.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 350,
                  child: ImageCard(
                    fullImagePath: state.imageLists[index].full,
                    imagePath: state.imageLists[index].regular,
                    title: state.imageLists[index].description ?? "Null",
                  ),
                );
              },
            );
          }
          return const Center(
            child: Text('No Data'),
          );
        },
      ),
    );
  }
}
