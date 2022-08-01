import 'package:cat_api_test_app/model/model.dart';
import 'package:cat_api_test_app/service/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cat_image_event.dart';
part 'cat_image_state.dart';

class CatImageBloc extends Bloc<CatImageEvent, CatImageState> {
  CatImageBloc(ApiService catImageApi)
      : _catImageApi = catImageApi,
        super(InitialState()) {
    on<FetchCatImage>((event, emin) => _getCatsImageList());
    on<FetchNewCatImage>((event, emit) => _getNewCatsImageList());
    on<UpdateAfterLike>((event, emit) => _upadateCatsImageList(event.index));
  }

  final List<CatImage> _catImageList = [];
  final ApiService _catImageApi;

  Future<void> _getNewCatsImageList() async {
    try {
      final catImageList = await _catImageApi.getImage();
      _catImageList.addAll(catImageList);
      emit(LoadedState(_catImageList));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  Future<void> _getCatsImageList() async {
    emit(LoadingState());
    try {
      final catImageList = await _catImageApi.getImage();
      _catImageList.addAll(catImageList);
      emit(LoadedState(_catImageList));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  void _upadateCatsImageList(int index) {
    _catImageList.removeAt(index);
    emit(LoadedState(_catImageList));
  }
}
