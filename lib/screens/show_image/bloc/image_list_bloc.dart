import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:unsplash_image/data/repositories/image_repository.dart';
import 'package:unsplash_image/models/image_model/image_model.dart';

part 'image_list_event.dart';
part 'image_list_state.dart';

class ImageListBloc extends Bloc<ImageListEvent, ImageListState> {
  final ImageRepository imageRepository;

  ImageListBloc(this.imageRepository) : super(ImageListInitial()) {
    on<FetchImageListEvent>(_onFetchImageList);
  }

  FutureOr<void> _onFetchImageList(
    FetchImageListEvent event,
    Emitter<ImageListState> emit,
  ) async {
    emit(ImageListLoadingState());

    final List<ImageModel> imageLists = await ImageRepository().fetchImages();

    emit(
      ImageListLoadedState(
        imageLists: imageLists,
      ),
    );
  }
}
