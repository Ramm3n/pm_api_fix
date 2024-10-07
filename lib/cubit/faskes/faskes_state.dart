part of 'faskes_cubit.dart';

abstract class FaskesState {}

class FaskesInitial extends FaskesState {}

class FaskesLoading extends FaskesInitial {}

class FaskesSuccess extends FaskesInitial {
  final dynamic data;
  FaskesSuccess({required this.data});
}
