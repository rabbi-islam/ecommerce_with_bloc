part of 'remember_switch_cubit.dart';

@immutable
sealed class RememberSwitchState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class RememberSwitchInitial extends RememberSwitchState {}

final class SwitchChanged extends RememberSwitchState {
  final bool value;
  SwitchChanged(this.value);

  @override
  List<Object?> get props => [value];
}
