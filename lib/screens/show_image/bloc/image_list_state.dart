part of 'image_list_bloc.dart';

@immutable
abstract class ImageListState {}

class ImageListInitial extends ImageListState {}

class ImageListLoadingState extends ImageListState {}

class ImageListLoadedState extends ImageListState {
  final List<ImageModel> imageLists;
  ImageListLoadedState({
    required this.imageLists,
  });
}
