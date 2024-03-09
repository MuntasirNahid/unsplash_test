part of 'search_screen_bloc.dart';

@immutable
abstract class SearchScreenEvent {}

class SearchScreenInitialEvent extends SearchScreenEvent {}

class SearchButtonClickedEvent extends SearchScreenEvent {
  final String query;

  SearchButtonClickedEvent(this.query);
}
