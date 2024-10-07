part of 'status_hubungan_cubit.dart';

abstract class StatusHubunganState {}

class StatusHubunganInitial extends StatusHubunganState {}

class StatusHubunganLoading extends StatusHubunganInitial {}

class StatusHubunganSuccess extends StatusHubunganInitial {
  final dynamic data;
  StatusHubunganSuccess({
    required this.data,
  });
}

class StatusHubunganError extends StatusHubunganState {
  final String error;

  StatusHubunganError(this.error);
}
