part of 'pendidikan_cubit.dart';

abstract class PendidikanState {}

class PendidikanInitial extends PendidikanState {}

class PendidikanLoading extends PendidikanInitial {}

class PendidikanSuccess extends PendidikanInitial {
  final dynamic data;
  PendidikanSuccess({
    required this.data,
  });
}

class PendidikanError extends PendidikanState {
  final String error;

  PendidikanError(this.error);
}
