part of 'cat_facts_bloc.dart';

abstract class CatFactsState {}

class CatFactsInitial extends CatFactsState {}

class CatFactsLoading extends CatFactsState {}

class CatFactsLoaded extends CatFactsState {
  final List<String> facts;

  CatFactsLoaded({required this.facts});
}

class CatFactsError extends CatFactsState {
  final String error;

  CatFactsError({required this.error});
}
