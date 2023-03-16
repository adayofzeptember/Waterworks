part of 'undone_bloc.dart';

class NotWriteState extends Equatable {
  NotWriteState({
    required this.notWrite,
    required this.page,
    required this.isLoading,
    required this.error
  });
  List notWrite;
  int page;
  bool isLoading;
  String error;

  NotWriteState copyWith({
    List? notWrite,
    int? page,
    bool? isLoading,
    String? error,
  }) {
    return NotWriteState(
      notWrite: notWrite ?? this.notWrite,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error
    );
  }

  @override
  List<Object> get props => [
        notWrite,
        page,
        isLoading,
        error
      ];
}

