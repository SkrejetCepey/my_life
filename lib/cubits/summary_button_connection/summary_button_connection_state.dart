part of 'summary_button_connection_cubit.dart';

@immutable
abstract class SummaryButtonConnectionState {}

class SummaryButtonInitial extends SummaryButtonConnectionState {}

class SummaryButtonTryingConnect extends SummaryButtonConnectionState {}

class SummaryButtonFailedConnect extends SummaryButtonConnectionState {}
