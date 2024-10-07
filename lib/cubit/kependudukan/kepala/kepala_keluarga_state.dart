abstract class KepalaKeluargaState {}

class KepalaKeluargaInitial extends KepalaKeluargaState {}

class KepalaKeluargaLoading extends KepalaKeluargaInitial {}

class ExpiredToken extends KepalaKeluargaInitial {}

class KepalaKeluargaError extends KepalaKeluargaInitial {
  final String data;
  KepalaKeluargaError(this.data);
}

class KepalaKeluargaLoaded extends KepalaKeluargaInitial {
  final dynamic data;
  KepalaKeluargaLoaded(this.data);
}
