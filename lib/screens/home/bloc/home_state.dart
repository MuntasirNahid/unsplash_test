part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class FetchImageListButtonClickedState extends HomeState {}

class SearchImageListButtonClickedState extends HomeState {}
