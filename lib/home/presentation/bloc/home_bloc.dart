import 'package:bharat_next_task/home/presentation/data/model/data_list.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/api_services/api_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiService apiService;
  HomeBloc(this.apiService) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      emit(HomeLoading());
      try {
        final data = await apiService.fetchPosts();
        emit(HomeLoaded(data));
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });
  }
}
