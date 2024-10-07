part of 'golongan_darah_cubit.dart';

abstract class GolonganDarahState {}

class GolonganDarahInitial extends GolonganDarahState {}

class GolonganDarahLoading extends GolonganDarahInitial {}

class GolonganDarahSuccess extends GolonganDarahInitial {
  final dynamic data;
  GolonganDarahSuccess({
    required this.data,
  });
}

class GolonganDarahError extends GolonganDarahState {
  final String error;

  GolonganDarahError(this.error);
}
