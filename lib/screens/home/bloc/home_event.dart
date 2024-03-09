part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class FetchImageListButtonClickedEvent extends HomeEvent {}

class SearchImageListButtonClickedEvent extends HomeEvent {}

class CameBackFromImageListScreenEvent extends HomeEvent {}

class CameBackFromSearchScreenEvent extends HomeEvent {}
