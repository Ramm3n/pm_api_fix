part of 'kependudukan_cubit.dart';

abstract class KependudukanState {}

class KependudukanInitial extends KependudukanState {}

class KependudukanLoading extends KependudukanInitial {}

class PostPendudukResponse extends KependudukanInitial {
  final bool isResponse;
  PostPendudukResponse({required this.isResponse});
  // @override
  // List<Object> get props => [isResponse];
}

class KependudukanSuccess extends KependudukanInitial {
  final dynamic data;
  KependudukanSuccess({
    required this.data,
  });
}

class DataFailure extends KependudukanInitial {
  final dynamic data;
  DataFailure({
    required this.data,
  });
}

class DataAnggotaFailure extends KependudukanInitial {
  final bool isResponse;
  final String msg;
  DataAnggotaFailure({
    required this.isResponse,
    required this.msg,
  });
}

class ExpiredTokenInput extends KependudukanInitial {}

class ResponseDeleteData extends KependudukanInitial {
  final bool isResponse;
  final String msg;
  ResponseDeleteData({
    required this.isResponse,
    required this.msg,
  });
}

class PsksSuccess extends KependudukanInitial {
  final dynamic data;
  PsksSuccess({required this.data});
}

class PsksFailure extends KependudukanInitial {
  final dynamic data;
  PsksFailure({required this.data});
}

abstract class LokasiState {}

class LokasiInitial extends LokasiState {}

class ExpiredLokasiInput extends LokasiInitial {}

class LokasiObjekSuccess extends LokasiInitial {
  final bool isResponse;
  final dynamic data;
  LokasiObjekSuccess({
    required this.isResponse,
    required this.data,
  });
}

class GetLokasiSuccess extends LokasiInitial {
  final dynamic data;
  GetLokasiSuccess({
    required this.data,
  });
}

class GetLokasiFailure extends LokasiInitial {
  final dynamic data;
  GetLokasiFailure({
    required this.data,
  });
}

class LokasiLoading extends LokasiInitial {}

class EditLokasiSuccess extends LokasiInitial {
  final dynamic data;
  EditLokasiSuccess({
    required this.data,
  });
}

class EditLokasiFailure extends LokasiInitial {
  final dynamic data;
  EditLokasiFailure({
    required this.data,
  });
}

// State untuk PSKSCubit
abstract class PsksState {}

class PsksInitial extends PsksState {}

class DataPsksSuccess extends PsksInitial {
  final dynamic data;
  DataPsksSuccess({required this.data});
}

class DataPsksFailure extends PsksInitial {
  final dynamic data;
  DataPsksFailure({required this.data});
}

class EditPsksSuccess extends PsksInitial {
  final dynamic data;
  EditPsksSuccess({required this.data});
}

class EditPsksFailure extends PsksInitial {
  final dynamic data;
  EditPsksFailure({required this.data});
}

class DeletePsksSuccess extends PsksInitial {
  final dynamic data;
  DeletePsksSuccess({required this.data});
}

class DeletePsksFailure extends PsksInitial {
  final dynamic data;
  DeletePsksFailure({required this.data});
}

abstract class PpksState {}

class PpksInitial extends PpksState {}

class DataPpksSuccess extends PpksInitial {
  final dynamic data;
  DataPpksSuccess({required this.data});
}

class DataPpksFailure extends PpksInitial {
  final dynamic data;
  DataPpksFailure({required this.data});
}

class EditPpksSuccess extends PpksInitial {
  final dynamic data;
  EditPpksSuccess({required this.data});
}

class EditPpksFailure extends PpksInitial {
  final dynamic data;
  EditPpksFailure({required this.data});
}

class DeletePpksSuccess extends PpksInitial {
  final dynamic data;
  DeletePpksSuccess({required this.data});
}

class DeletePpksFailure extends PpksInitial {
  final dynamic data;
  DeletePpksFailure({required this.data});
}

abstract class BansosState {}

class BansosInitial extends BansosState {}

class DataBansosSuccess extends BansosState {
  final dynamic data;
  DataBansosSuccess({required this.data});
}

class DataBansosFailure extends BansosState {
  final dynamic data;
  DataBansosFailure({required this.data});
}

class DeleteBansosSuccess extends BansosState {
  final dynamic data;
  DeleteBansosSuccess({required this.data});
}

class DeleteBansosFailure extends BansosInitial {
  final dynamic data;
  DeleteBansosFailure({required this.data});
}

// State untuk ProvinsiCubit
abstract class ProvinsiState {}

class ProvinsiInitial extends ProvinsiState {}

class ProvinsiLoading extends ProvinsiState {}

class ProvinsiLoaded extends ProvinsiState {
  final dynamic provinsiList;

  ProvinsiLoaded(this.provinsiList);
}

class ProvinsiError extends ProvinsiState {
  final String error;

  ProvinsiError(this.error);
}

// State untuk KabupatenCubit
abstract class KabupatenState {}

class KabupatenInitial extends KabupatenState {}

class KabupatenLoading extends KabupatenState {}

class KabupatenLoaded extends KabupatenState {
  final dynamic kabupatenList;

  KabupatenLoaded(this.kabupatenList);
}

class KabupatenError extends KabupatenState {
  final String error;

  KabupatenError(this.error);
}

// State untuk KecamatanCubit
abstract class KecamatanState {}

class KecamatanInitial extends KecamatanState {}

class KecamatanLoading extends KecamatanState {}

class KecamatanLoaded extends KecamatanState {
  final dynamic kecamatanList;

  KecamatanLoaded(this.kecamatanList);
}

class KecamatanError extends KecamatanState {
  final String error;

  KecamatanError(this.error);
}

// State untuk KecamatanCubit
abstract class KelurahanState {}

class KelurahanInitial extends KelurahanState {}

class KelurahanLoading extends KelurahanState {}

class KelurahanLoaded extends KelurahanState {
  final dynamic kelurahanList;

  KelurahanLoaded(this.kelurahanList);
}

class KelurahanError extends KelurahanState {
  final String error;

  KelurahanError(this.error);
}
