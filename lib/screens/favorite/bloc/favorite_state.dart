part of 'favorite_bloc.dart';

abstract class FavoriteState {}

class FavotiteInitialState extends FavoriteState {}

class FavoriteError extends FavoriteState {
  final String error;

  FavoriteError({required this.error});
}

class FavoriteSucces extends FavoriteState {
  Stream<List<Favorite>> favList;

  FavoriteSucces({required this.favList});
}
