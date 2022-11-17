import 'package:equatable/equatable.dart';

abstract class ListTvshowsEvent extends Equatable {}

class OnListTvshowsCalled extends ListTvshowsEvent {
  @override
  List<Object> get props => [];
}
