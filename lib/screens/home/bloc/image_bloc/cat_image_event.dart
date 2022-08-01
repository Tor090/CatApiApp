part of 'cat_image_bloc.dart';

abstract class CatImageEvent {}

class FetchCatImage extends CatImageEvent {
  FetchCatImage();
}

class FetchNewCatImage extends CatImageEvent {
  FetchNewCatImage();
}

class UpdateAfterLike extends CatImageEvent {
  UpdateAfterLike({required this.index});

  final int index;
}
