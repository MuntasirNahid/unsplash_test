import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:unsplash_image/data/repositories/image_repository.dart';
import 'package:unsplash_image/models/image_model/image_model.dart';

part 'search_screen_event.dart';
part 'search_screen_state.dart';

class SearchScreenBloc extends Bloc<SearchScreenEvent, SearchScreenState> {
  SearchScreenBloc() : super(SearchScreenInitial()) {
    on<SearchScreenInitialEvent>(_onSearchScreenInitial);
    on<SearchButtonClickedEvent>(_onSearchButtonClicked);
  }

  FutureOr<void> _onSearchScreenInitial(
      SearchScreenInitialEvent event, Emitter<SearchScreenState> emit) {
    emit(SearchScreenInitialState());
  }

  FutureOr<void> _onSearchButtonClicked(
      SearchButtonClickedEvent event, Emitter<SearchScreenState> emit) async {
    emit(SearchScreenLoadingState());

    final List<ImageModel> imageLists =
        await ImageRepository().searchImages(event.query);
    emit(
      SearchQueryCompletedState(
        imageLists: imageLists,
      ),
    );
  }
}
