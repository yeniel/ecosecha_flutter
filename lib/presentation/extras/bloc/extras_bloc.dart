import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'extras_event.dart';
part 'extras_state.dart';

class ExtrasBloc extends Bloc<ExtrasEvent, ExtrasState> {
  ExtrasBloc() : super(ExtrasInitial()) {
    on<ExtrasEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
