part of 'favorite_bloc.dart';

abstract class FavoriteEvent {}

class AddFavoriteEvent extends FavoriteEvent {
  final String id;
  final String url;

  AddFavoriteEvent({required this.id, required this.url});
}

class FetchFavorite extends FavoriteEvent {
  FetchFavorite();
}

class DislikeEvent extends FavoriteEvent {
  final String id;

  DislikeEvent({required this.id});
}

class FavoriteExist extends FavoriteEvent {
  final String id;

  FavoriteExist({required this.id});
}
