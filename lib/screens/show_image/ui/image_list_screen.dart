import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:unsplash_image/screens/show_image/bloc/image_list_bloc.dart';
import 'package:unsplash_image/widgets/image_card.dart';

class FetchImageScreen extends StatefulWidget {
  const FetchImageScreen({super.key});

  @override
  State<FetchImageScreen> createState() => _FetchImageScreenState();
}

class _FetchImageScreenState extends State<FetchImageScreen> {
  late final ImageListBloc _imageListBloc;

  @override
  void initState() {
    // TODO: implement initState
    _imageListBloc = context.read<ImageListBloc>();
    _imageListBloc.add(FetchImageListEvent());
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
        title: const Text('Fetch Image Screen'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: BlocConsumer<ImageListBloc, ImageListState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ImageListLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ImageListLoadedState) {
            return ListView.builder(
              itemCount: state.imageLists.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 350,
                  child: ImageCard(
                    fullImagePath: state.imageLists[index].full,
                    imagePath: state.imageLists[index].regular,
                    title: state.imageLists[index].description ?? "null",
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
