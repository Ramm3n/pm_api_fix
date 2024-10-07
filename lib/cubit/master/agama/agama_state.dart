part of 'agama_cubit.dart';

abstract class AgamaState {}

class AgamaInitial extends AgamaState {}

class AgamaLoading extends AgamaInitial {}

class AgamaSuccess extends AgamaInitial {
  final dynamic data;
  AgamaSuccess({
    required this.data,
  });
}

class AgamaError extends AgamaState {
  final String error;

  AgamaError(this.error);
}
