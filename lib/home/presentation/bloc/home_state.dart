part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<DataList> posts;
  HomeLoaded(this.posts);
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
