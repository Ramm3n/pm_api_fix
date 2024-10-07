part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthInitial {}

class AuthFailed extends AuthInitial {
  final bool isLogged;
  AuthFailed({required this.isLogged});
}

class AuthSuccess extends AuthInitial {
  final dynamic data;
  AuthSuccess({required this.data});
}
