import 'package:cat_api_test_app/service/service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cat_facts_event.dart';
part 'cat_facts_state.dart';

class CatFactsBloc extends Bloc<CatFactsEvent, CatFactsState> {
  CatFactsBloc({required ApiService apiService})
      : _apiService = apiService,
        super(CatFactsInitial()) {
    on<FactsLoad>((event, emit) => _getCatFacts());
  }

  final ApiService _apiService;

  Future<void> _getCatFacts() async {
    emit(CatFactsLoading());
    try {
      final catFactsList = await _apiService.getFacts();
      emit(CatFactsLoaded(facts: catFactsList));
    } catch (e) {
      emit(CatFactsError(error: e.toString()));
    }
  }
}
