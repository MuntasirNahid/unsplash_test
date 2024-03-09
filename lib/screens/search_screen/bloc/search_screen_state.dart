part of 'search_screen_bloc.dart';

@immutable
abstract class SearchScreenState {}

class SearchScreenInitial extends SearchScreenState {}

class SearchScreenInitialState extends SearchScreenState {}

class SearchScreenLoadingState extends SearchScreenState {}

class SearchQueryCompletedState extends SearchScreenState {
  final List<ImageModel> imageLists;

  SearchQueryCompletedState({required this.imageLists});
}
