import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tab_event.dart';

enum Tabs { home, favorite, profile }

class TabBloc extends Bloc<TabEvent, Tabs> {
  TabBloc() : super(Tabs.home) {
    on<UpdateTab>((event, emit) => emit(event.tab));
  }
}
