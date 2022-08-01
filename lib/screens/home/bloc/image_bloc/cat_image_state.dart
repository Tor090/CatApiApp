part of 'cat_image_bloc.dart';

abstract class CatImageState {}

class InitialState extends CatImageState {}

class LoadingState extends CatImageState {}

class LoadedState extends CatImageState {
  LoadedState(this.catImageList);

  final List<CatImage> catImageList;
}

class ErrorState extends CatImageState {
  ErrorState(this.error);

  final String error;
}
