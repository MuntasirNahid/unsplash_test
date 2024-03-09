import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(_onHomeInitial);
    on<FetchImageListButtonClickedEvent>(_onFetchImageListButtonClicked);
    on<SearchImageListButtonClickedEvent>(_onSearchImageListButtonClicked);
    on<CameBackFromImageListScreenEvent>(_onCameBackFromImageListScreen);
    on<CameBackFromSearchScreenEvent>(_onCameBackFromSearchScreen);
  }

  FutureOr<void> _onHomeInitial(
      HomeInitialEvent event, Emitter<HomeState> emit) {
    emit(HomeLoadingState());
  }

  FutureOr<void> _onFetchImageListButtonClicked(
      FetchImageListButtonClickedEvent event, Emitter<HomeState> emit) {
    emit(FetchImageListButtonClickedState());
  }

  FutureOr<void> _onSearchImageListButtonClicked(
      SearchImageListButtonClickedEvent event, Emitter<HomeState> emit) {
    emit(
      SearchImageListButtonClickedState(),
    );
  }

  FutureOr<void> _onCameBackFromImageListScreen(
      CameBackFromImageListScreenEvent event, Emitter<HomeState> emit) {
    emit(HomeLoadingState());
  }

  FutureOr<void> _onCameBackFromSearchScreen(
      CameBackFromSearchScreenEvent event, Emitter<HomeState> emit) {
    emit(HomeLoadingState());
  }
}
