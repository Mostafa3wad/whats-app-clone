part of 'status_cubit.dart';

abstract class StatusState extends Equatable {
  const StatusState();

  @override
  List<Object> get props => <Widget>[];
}

class StatusInitial extends StatusState {}
