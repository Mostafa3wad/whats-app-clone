part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => <Object>[];
}

class HomeInitial extends HomeState {}
