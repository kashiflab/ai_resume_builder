import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

/// Base state that all feature states should extend
abstract class BaseState extends Equatable {
  final bool isLoading;
  final String? errorMessage;

  const BaseState({
    this.isLoading = false,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [isLoading, errorMessage];
}

/// Base event that all feature events should extend
abstract class BaseEvent extends Equatable {
  const BaseEvent();

  @override
  List<Object?> get props => [];
}

/// Base BLoC that all feature BLoCs should extend
abstract class BaseBloc<E extends BaseEvent, S extends BaseState>
    extends Bloc<E, S> {
  BaseBloc(S initialState) : super(initialState) {
    on<E>((event, emit) async {
      try {
        await handleEvent(event, emit);
      } catch (error) {
        emit(handleError(error));
      }
    });
  }

  /// Handle incoming events
  Future<void> handleEvent(E event, Emitter<S> emit);

  /// Handle errors that occur during event handling
  S handleError(dynamic error);

  /// Emit a loading state
  void emitLoading(Emitter<S> emit) {
    emit(createState(isLoading: true) as S);
  }

  /// Create a new state with the given parameters
  BaseState createState({
    bool isLoading = false,
    String? errorMessage,
  });
}
