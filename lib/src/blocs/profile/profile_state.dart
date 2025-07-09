part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileFetchSuccess extends ProfileState {}
