part of 'connection_page_cubit.dart';

@immutable
abstract class ConnectionPageState {}

class ConnectionPageInitial extends ConnectionPageState {}

class ConnectionPageTryingConnect extends ConnectionPageState {}

class FailedPageConnect extends ConnectionPageState {
  final Exception exception;

  FailedPageConnect({this.exception});
}
