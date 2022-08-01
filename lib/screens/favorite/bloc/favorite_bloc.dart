import 'package:cat_api_test_app/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/model.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc({required FavoriteRepository favoriteRepository})
      : _favoriteRepository = favoriteRepository,
        super(FavotiteInitialState()) {
    on<AddFavoriteEvent>((event, emit) async {
      Favorite favorite =
          Favorite(id: event.id, url: event.url, created: DateTime.now());
      await _favoriteRepository.addLike(favorite);
    });
    on<DislikeEvent>((event, emit) async {
      await _favoriteRepository.dislike(event.id);
    });
    on<FetchFavorite>((event, emit) async {
      emit(FavoriteSucces(favList: _favoriteRepository.fetchItems()));
    });
  }

  final FavoriteRepository _favoriteRepository;
}
